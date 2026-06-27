# luci-app-whu-auth

OpenWrt LuCI plugin for WuHan University (WHU) campus network auto-authentication.

Based on [auto-whu-openwrt](https://github.com/cccht/auto-whu-openwrt).
Reference: [WHU OpenWrt 认证方案](https://www.miaoer.net/posts/network/whu-openwrt-authentication)

## Features

- Auto-detect captive portal on WHU campus network
- Automatic login with stored credentials
- Support for ISP domain selection (China Telecom / Unicom / Mobile / Campus)
- Periodic connection health checks with auto-reconnect
- LuCI web interface for easy configuration
- Chinese (zh-CN) localization
- Service management (start/stop/restart) from web UI
- Real-time status monitoring and log viewer

## Build ipk (via GitHub Actions)

1. Fork or push this repository to GitHub
2. The GitHub Actions workflow will automatically build the `.ipk` package
3. Download the ipk from the Actions artifacts

## Manual Build (OpenWrt SDK)

```bash
# In OpenWrt SDK root
mkdir -p package/luci-app-whu-auth
cp -r /path/to/luci-app-whu-auth/* package/luci-app-whu-auth/
make package/luci-app-whu-auth/compile V=s
```

## Install

```bash
opkg install luci-app-whu-auth_1.0.0-1_all.ipk
```

## Usage

1. Navigate to **Services > WHU Auth** in LuCI web interface
2. Enter your campus network username (student ID) and password
3. Select your ISP domain (if applicable)
4. Enable the service and click Save & Apply
5. The daemon will automatically authenticate when a captive portal is detected

## File Structure

```
luci-app-whu-auth/
├── Makefile
├── preview.html                    # UI preview (open in browser)
├── root/
│   ├── etc/
│   │   ├── config/whu-auth         # UCI config file
│   │   └── init.d/whu-auth         # procd init script
│   └── usr/
│       ├── bin/whu-auth             # Auth daemon script
│       ├── lib/luci/luci/
│       │   ├── controller/whu-auth.lua   # LuCI controller
│       │   ├── model/cbi/whu-auth/settings.lua  # CBI model
│       │   └── view/whu-auth/
│       │       ├── status.htm       # Status page
│       │       └── log.htm          # Log page
│       └── share/
│           ├── luci/
│           │   ├── menu.d/whu-auth.json   # Menu definition
│           │   └── i18n/whu-auth/zh-cn.po # Chinese translation
│           └── rpcd/acl.d/whu-auth.json   # ACL permissions
└── .github/workflows/build.yml     # CI build workflow
```

## License

MIT
