if vim.g.nvim_spawn_trace_loaded then
  return
end
vim.g.nvim_spawn_trace_loaded = true

local log_dir = vim.fn.expand("~/.local/state/nvim-embed-watch")
local log_path = log_dir .. "/nvim-spawn-trace.log"
local uv_log_path = log_dir .. "/nvim-uv-handles.log"
local uv_handles = {}
local uv_handle_refs = setmetatable({}, { __mode = "v" })

local function mkdir_p(path)
  pcall(vim.fn.mkdir, path, "p")
end

local function basename(path)
  if type(path) ~= "string" or path == "" then
    return ""
  end
  return (path:gsub("/+$", ""):match("([^/]+)$") or path)
end

local function is_list(value)
  return type(value) == "table" and vim.tbl_islist(value)
end

local function join_argv(argv)
  if not is_list(argv) then
    return tostring(argv)
  end

  local parts = {}
  for _, item in ipairs(argv) do
    parts[#parts + 1] = tostring(item)
  end
  return table.concat(parts, " ")
end

local function command_snapshot(cmd, opts)
  if type(cmd) == "string" then
    return {
      argv0 = cmd:match("^%s*(%S+)") or "",
      text = cmd,
      kind = "string",
    }
  end

  if is_list(cmd) then
    return {
      argv0 = tostring(cmd[1] or ""),
      text = join_argv(cmd),
      kind = "argv",
    }
  end

  if type(cmd) == "table" then
    local path = tostring(cmd.path or cmd.cmd or "")
    local args = cmd.args or opts and opts.args or {}
    local full = {}

    if path ~= "" then
      full[#full + 1] = path
    end
    if is_list(args) then
      for _, arg in ipairs(args) do
        full[#full + 1] = tostring(arg)
      end
    end

    return {
      argv0 = path,
      text = table.concat(full, " "),
      kind = "table",
    }
  end

  return {
    argv0 = "",
    text = tostring(cmd),
    kind = type(cmd),
  }
end

local function should_log(cmd, opts)
  local snapshot = command_snapshot(cmd, opts)
  local argv0 = basename(snapshot.argv0)
  if argv0 == "nvim" then
    return true, snapshot
  end

  if snapshot.text:find("--embed", 1, true) then
    return true, snapshot
  end

  return false, snapshot
end

local function plugin_hints(trace)
  local hints = {}

  for plugin in trace:gmatch("/lazy/([^/\n]+)/") do
    hints[plugin] = true
  end
  for plugin in trace:gmatch("/lua/plugins/([^/\n]+)%.lua") do
    hints[plugin] = true
  end

  local items = {}
  for hint in pairs(hints) do
    items[#items + 1] = hint
  end
  table.sort(items)
  return items
end

local function current_context()
  if vim.in_fast_event() then
    return {
      cwd = (vim.uv or vim.loop).cwd() or "",
      buf = "",
      filetype = "",
      mode = "fast",
    }
  end

  local ok_name, buf_name = pcall(vim.api.nvim_buf_get_name, 0)
  local ok_ft, filetype = pcall(function()
    return vim.bo.filetype
  end)
  local ok_mode, mode = pcall(vim.api.nvim_get_mode)

  return {
    cwd = (vim.uv or vim.loop).cwd() or "",
    buf = ok_name and buf_name or "",
    filetype = ok_ft and filetype or "",
    mode = ok_mode and mode.mode or "",
  }
end

local function append_log(lines)
  mkdir_p(log_dir)

  local ok, handle = pcall(io.open, log_path, "a")
  if not ok or not handle then
    return
  end

  handle:write(table.concat(lines, "\n"))
  handle:write("\n\n")
  handle:close()
end

local function append_uv_log(lines)
  mkdir_p(log_dir)

  local ok, handle = pcall(io.open, uv_log_path, "a")
  if not ok or not handle then
    return
  end

  handle:write(table.concat(lines, "\n"))
  handle:write("\n\n")
  handle:close()
end

local function log_spawn(api_name, cmd, opts)
  local matched, snapshot = should_log(cmd, opts)
  if not matched then
    return
  end

  local trace = debug.traceback("spawn trace", 3)
  local context = current_context()
  local hints = plugin_hints(trace)
  local lines = {
    ("[%s] %s"):format(os.date("%Y-%m-%dT%H:%M:%S%z"), api_name),
    ("argv0: %s"):format(snapshot.argv0),
    ("command_kind: %s"):format(snapshot.kind),
    ("command: %s"):format(snapshot.text),
    ("cwd: %s"):format(context.cwd),
    ("buffer: %s"):format(context.buf),
    ("filetype: %s"):format(context.filetype),
    ("mode: %s"):format(context.mode),
  }

  if opts and type(opts) == "table" then
    if opts.cwd then
      lines[#lines + 1] = ("spawn_cwd: %s"):format(opts.cwd)
    end
    if opts.detach ~= nil then
      lines[#lines + 1] = ("detach: %s"):format(tostring(opts.detach))
    end
    if opts.rpc ~= nil then
      lines[#lines + 1] = ("rpc: %s"):format(tostring(opts.rpc))
    end
  end

  if #hints > 0 then
    lines[#lines + 1] = ("plugin_hints: %s"):format(table.concat(hints, ", "))
  end

  lines[#lines + 1] = "traceback:"
  lines[#lines + 1] = trace
  append_log(lines)
end

local function wrap_jobstart()
  local original = vim.fn.jobstart
  vim.fn.jobstart = function(cmd, ...)
    log_spawn("vim.fn.jobstart", cmd, select(1, ...))
    return original(cmd, ...)
  end
end

local function wrap_termopen()
  if type(vim.fn.termopen) ~= "function" then
    return
  end

  local original = vim.fn.termopen
  vim.fn.termopen = function(cmd, ...)
    log_spawn("vim.fn.termopen", cmd, select(1, ...))
    return original(cmd, ...)
  end
end

local function wrap_system()
  if type(vim.system) ~= "function" then
    return
  end

  local original = vim.system
  vim.system = function(cmd, opts, on_exit)
    log_spawn("vim.system", cmd, opts)
    return original(cmd, opts, on_exit)
  end
end

local function wrap_uv_spawn(uv, label)
  if type(uv) ~= "table" or type(uv.spawn) ~= "function" then
    return
  end

  local original = uv.spawn
  uv.spawn = function(path, opts, on_exit)
    local cmd = {
      path = path,
      args = opts and opts.args or {},
    }
    log_spawn(label, cmd, opts)
    return original(path, opts, on_exit)
  end
end

local function inspect_value(value)
  local ok, rendered = pcall(vim.inspect, value)
  if not ok then
    return tostring(value)
  end
  rendered = rendered:gsub("%s+", " ")
  if #rendered > 180 then
    rendered = rendered:sub(1, 177) .. "..."
  end
  return rendered
end

local function record_uv_handle(kind, handle, details)
  if handle == nil then
    return
  end

  local id = tostring(handle)
  local trace = debug.traceback("uv handle trace", 3)
  local context = current_context()

  uv_handles[id] = {
    id = id,
    kind = kind,
    created_at = os.date("%Y-%m-%dT%H:%M:%S%z"),
    details = details,
    cwd = context.cwd,
    buf = context.buf,
    filetype = context.filetype,
    mode = context.mode,
    trace = trace,
    hints = plugin_hints(trace),
  }
  uv_handle_refs[id] = handle
end

local function call_handle_method(handle, method)
  local ok_method, fn = pcall(function()
    return handle[method]
  end)
  if not ok_method or type(fn) ~= "function" then
    return nil
  end

  local ok_call, result = pcall(fn, handle)
  if not ok_call then
    return nil
  end
  return result
end

local function dump_uv_handles(reason)
  local live = {}
  local kind_counts = {}
  local plugin_counts = {}

  for id, meta in pairs(uv_handles) do
    local handle = uv_handle_refs[id]
    if handle then
      local closing = call_handle_method(handle, "is_closing")
      local active = call_handle_method(handle, "is_active")
      if closing ~= true then
        meta.closing = closing
        meta.active = active
        meta.path = call_handle_method(handle, "getpath")
        live[#live + 1] = meta
        kind_counts[meta.kind] = (kind_counts[meta.kind] or 0) + 1
        if #meta.hints == 0 then
          plugin_counts["<core>"] = (plugin_counts["<core>"] or 0) + 1
        else
          for _, hint in ipairs(meta.hints) do
            plugin_counts[hint] = (plugin_counts[hint] or 0) + 1
          end
        end
      end
    end
  end

  if #live == 0 then
    append_uv_log({
      ("[%s] uv handles %s"):format(os.date("%Y-%m-%dT%H:%M:%S%z"), reason),
      "live_handles: 0",
    })
    return
  end

  table.sort(live, function(a, b)
    if a.kind == b.kind then
      return a.id < b.id
    end
    return a.kind < b.kind
  end)

  local kind_parts = {}
  for kind, count in pairs(kind_counts) do
    kind_parts[#kind_parts + 1] = ("%s=%d"):format(kind, count)
  end
  table.sort(kind_parts)

  local plugin_parts = {}
  for hint, count in pairs(plugin_counts) do
    plugin_parts[#plugin_parts + 1] = ("%s=%d"):format(hint, count)
  end
  table.sort(plugin_parts)

  local lines = {
    ("[%s] uv handles %s"):format(os.date("%Y-%m-%dT%H:%M:%S%z"), reason),
    ("live_handles: %d"):format(#live),
    ("by_kind: %s"):format(table.concat(kind_parts, ", ")),
    ("by_plugin_hint: %s"):format(table.concat(plugin_parts, ", ")),
  }

  for _, meta in ipairs(live) do
    lines[#lines + 1] = "---"
    lines[#lines + 1] = ("id: %s"):format(meta.id)
    lines[#lines + 1] = ("kind: %s"):format(meta.kind)
    lines[#lines + 1] = ("created_at: %s"):format(meta.created_at)
    lines[#lines + 1] = ("details: %s"):format(meta.details)
    lines[#lines + 1] = ("cwd: %s"):format(meta.cwd)
    lines[#lines + 1] = ("buffer: %s"):format(meta.buf)
    lines[#lines + 1] = ("filetype: %s"):format(meta.filetype)
    lines[#lines + 1] = ("mode: %s"):format(meta.mode)
    if meta.path and meta.path ~= "" then
      lines[#lines + 1] = ("path: %s"):format(meta.path)
    end
    lines[#lines + 1] = ("active: %s"):format(tostring(meta.active))
    lines[#lines + 1] = ("closing: %s"):format(tostring(meta.closing))
    if #meta.hints > 0 then
      lines[#lines + 1] = ("plugin_hints: %s"):format(table.concat(meta.hints, ", "))
    end
    lines[#lines + 1] = "traceback:"
    lines[#lines + 1] = meta.trace
  end

  append_uv_log(lines)
end

local function wrap_uv_constructor(uv, field, kind)
  if type(uv) ~= "table" or type(uv[field]) ~= "function" or uv["_codex_wrapped_" .. field] then
    return
  end

  local original = uv[field]
  uv[field] = function(...)
    local handle = original(...)
    record_uv_handle(kind, handle, inspect_value({ ... }))
    return handle
  end
  uv["_codex_wrapped_" .. field] = true
end

wrap_jobstart()
wrap_termopen()
wrap_system()
wrap_uv_spawn(vim.uv, "vim.uv.spawn")
if vim.loop ~= vim.uv then
  wrap_uv_spawn(vim.loop, "vim.loop.spawn")
end
wrap_uv_constructor(vim.uv, "new_timer", "timer")
wrap_uv_constructor(vim.uv, "new_fs_event", "fs_event")
wrap_uv_constructor(vim.uv, "new_fs_poll", "fs_poll")
wrap_uv_constructor(vim.uv, "new_check", "check")
wrap_uv_constructor(vim.uv, "new_async", "async")
wrap_uv_constructor(vim.uv, "new_pipe", "pipe")
wrap_uv_constructor(vim.uv, "new_idle", "idle")
wrap_uv_constructor(vim.uv, "new_signal", "signal")
if vim.loop ~= vim.uv then
  wrap_uv_constructor(vim.loop, "new_timer", "timer")
  wrap_uv_constructor(vim.loop, "new_fs_event", "fs_event")
  wrap_uv_constructor(vim.loop, "new_fs_poll", "fs_poll")
  wrap_uv_constructor(vim.loop, "new_check", "check")
  wrap_uv_constructor(vim.loop, "new_async", "async")
  wrap_uv_constructor(vim.loop, "new_pipe", "pipe")
  wrap_uv_constructor(vim.loop, "new_idle", "idle")
  wrap_uv_constructor(vim.loop, "new_signal", "signal")
end

local augroup = vim.api.nvim_create_augroup("codex_uv_trace", { clear = true })
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = augroup,
  callback = function()
    dump_uv_handles("VimLeavePre")
  end,
})

vim.api.nvim_create_user_command("CodexUvHandles", function(opts)
  dump_uv_handles(opts.args ~= "" and opts.args or "manual")
end, {
  desc = "Dump live libuv handles with creation traces",
  nargs = "?",
})
