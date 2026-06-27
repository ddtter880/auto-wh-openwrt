-- CBI Model for WHU Auth Settings
-- Based on: https://github.com/cccht/auto-whu-openwrt

local m, s, o

m = Map("whu-auth", translate("WHU Campus Network Authentication"),
    translate("Automatically authenticate to WuHan University campus network portal. " ..
              "Based on auto-whu-openwrt project."))

-- Global switch
s = m:section(TypedSection, "whu-auth", translate("General Settings"))
s.anonymous = true
s.addremove = false

-- Enable/Disable
o = s:option(Flag, "enabled", translate("Enable"),
    translate("Enable WHU campus network auto-authentication"))
o.default = "0"
o.rmempty = false

-- Username
o = s:option(Value, "username", translate("Username"),
    translate("Your campus network account username (student ID)"))
o.datatype = "string"
o.placeholder = "2023301012345"
o.rmempty = false

-- Password
o = s:option(Value, "password", translate("Password"),
    translate("Your campus network account password"))
o.password = true
o.rmempty = false

-- ISP Domain
o = s:option(ListValue, "domain", translate("ISP / Service Provider"),
    translate("Select your Internet Service Provider (ISP domain for authentication)"))
o:value("", translate("-- None / Default --"))
o:value("@telecom", translate("China Telecom (电信)"))
o:value("@unicom", translate("China Unicom (联通)"))
o:value("@cmcc", translate("China Mobile (移动)"))
o:value("@campus", translate("Campus Network (校园网)"))
o.default = ""
o.rmempty = true

-- Auth Server
o = s:option(Value, "auth_server", translate("Auth Server URL"),
    translate("Portal authentication server address"))
o.default = "https://portal.whu.edu.cn"
o.datatype = "string"
o.placeholder = "https://portal.whu.edu.cn"
o.rmempty = false

-- Network Interface
o = s:option(ListValue, "interface", translate("Network Interface"),
    translate("WAN interface used for authentication"))
o:value("wan", "WAN")
o:value("wan6", "WAN6")
o.default = "wan"
o.rmempty = false

-- Advanced Settings
s = m:section(TypedSection, "whu-auth", translate("Advanced Settings"))
s.anonymous = true
s.addremove = false

-- Check Interval
o = s:option(Value, "check_interval", translate("Check Interval (seconds)"),
    translate("How often to check the connection status (default: 60s)"))
o.datatype = "uinteger"
o.default = "60"
o.placeholder = "60"
o.rmempty = true

-- Retry Count
o = s:option(Value, "retry_count", translate("Retry Count"),
    translate("Number of authentication retry attempts (default: 3)"))
o.datatype = "uinteger"
o.default = "3"
o.placeholder = "3"
o.rmempty = true

return m
