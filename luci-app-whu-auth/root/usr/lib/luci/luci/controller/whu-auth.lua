-- LuCI Controller for WHU Auth
-- Based on: https://github.com/cccht/auto-whu-openwrt

module("luci.controller.whu-auth", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/whu-auth") then
        return
    end

    entry({"admin", "services", "whu-auth"}, alias("admin", "services", "whu-auth", "settings"), _("WHU Auth"), 60)
    entry({"admin", "services", "whu-auth", "settings"}, cbi("whu-auth/settings"), _("Settings"), 1)
    entry({"admin", "services", "whu-auth", "status"}, template("whu-auth/status/status"), _("Status"), 2)
    entry({"admin", "services", "whu-auth", "log"}, template("whu-auth/log"), _("Log"), 3)

    entry({"admin", "services", "whu-auth", "action"}, call("whu_auth_action"), nil).leaf = true
    entry({"admin", "services", "whu-auth", "get_status"}, call("get_status_json"), nil)
end

function whu_auth_action()
    local action = luci.http.formvalue("action")
    local result = {}

    if action == "start" then
        os.execute("/etc/init.d/whu-auth start")
        result = { code = 0, message = "Service started" }
    elseif action == "stop" then
        os.execute("/etc/init.d/whu-auth stop")
        result = { code = 0, message = "Service stopped" }
    elseif action == "restart" then
        os.execute("/etc/init.d/whu-auth restart")
        result = { code = 0, message = "Service restarted" }
    elseif action == "enable" then
        os.execute("/etc/init.d/whu-auth enable")
        result = { code = 0, message = "Service enabled" }
    elseif action == "disable" then
        os.execute("/etc/init.d/whu-auth disable")
        result = { code = 0, message = "Service disabled" }
    elseif action == "check" then
        local handle = io.popen("/usr/bin/whu-auth --check 2>&1")
        local output = handle:read("*a")
        handle:close()
        local status = "offline"
        if output:match("online") then
            status = "online"
        end
        result = { code = 0, status = status }
    else
        result = { code = -1, message = "Unknown action: " .. tostring(action) }
    end

    luci.http.prepare_content("application/json")
    luci.http.write_json(result)
end

function get_status_json()
    local result = {}

    -- Get daemon running status
    local pid_file = io.open("/var/run/whu-auth.pid", "r")
    if pid_file then
        local pid = pid_file:read("*a"):match("%d+")
        pid_file:close()
        if pid then
            local proc = io.open("/proc/" .. pid .. "/status", "r")
            if proc then
                proc:close()
                result.daemon = "running"
                result.pid = pid
            else
                result.daemon = "stopped"
            end
        else
            result.daemon = "stopped"
        end
    else
        result.daemon = "stopped"
    end

    -- Get auth state
    local state_file = io.open("/tmp/whu-auth.state", "r")
    if state_file then
        result.state = state_file:read("*a"):match("^%s*(.-)%s*$")
        state_file:close()
    else
        result.state = "unknown"
    end

    -- Check internet connectivity
    local handle = io.popen("/usr/bin/whu-auth --check 2>&1")
    if handle then
        local output = handle:read("*a")
        handle:close()
        result.internet = output:match("online") and "online" or "offline"
    end

    result.code = 0

    luci.http.prepare_content("application/json")
    luci.http.write_json(result)
end
