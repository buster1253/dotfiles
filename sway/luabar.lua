#!/usr/bin/luajit

local ffi    = require "ffi"
local concat = table.concat
local format = string.format

ffi.cdef[[
void sleep(int sec);
]]

local sleep = ffi.C.sleep

-- Initial config implementation
local config = {
	order = {
		"download", "ip", "battery", "date"
	},
	date = {
		format = "%Y-%m-%d %H:%M:%S"
	},
	ip = {
		interface = "wlp61s0"
	},
	batteries = {
		"BAT0"
	}
}

local wifi_cmd = [[wpa_cli status | sed "/^\(ssid\|ip_addr\)/!d;
s/ssid=\|ip_address=\([a-zA-Z0-9]*\)/\1/" | tr "\n" " "]]
local download_cmd = "cat /proc/net/dev | grep " .. config.ip.interface ..
" | awk '{printf $2}'"

-- prefix batteries name with path
for i,b in ipairs(config.batteries) do
	config.batteries[i] = "/sys/class/power_supply/" .. b
end


local cmd_output = function(cmd)
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
	return result
end

local bat_sym = {"","","","","","","","","","","",""}

local battery = function()
	for _,bat in ipairs(config.batteries) do
		local cap    = cmd_output("cat " .. bat .. "/capacity")
		local status = cmd_output("cat " .. bat .. "/status")
		local sym
		if status == "Full\n" then
			sym = bat_sym[11]
		elseif status == "Charging\n" then
			sym = bat_sym[12]
		else
			sym = bat_sym[math.floor(cap/10 + 0.5)]
		end
		return format("%d%% %s ", math.floor(cap), sym)
	end
end

local time = function()
	return os.date(config.date.format)
end

local wifi = function()
	return format("%s%s", " ", cmd_output(wifi_cmd))
end

local sizes = {"B", "K", "M", "G"}

local read_download = function()
	return cmd_output(download_cmd)
end

local prev_download
local get_download = function()
	local curr = tonumber(cmd_output(download_cmd))
	if prev_download == nil then
		prev_download = curr
	end
	if prev_download == curr then
		return "0 B "
	end

	local delta = curr - prev_download

	prev_download = curr

	local size = 1
	while delta > 1000 do
		size = size + 1
		delta = delta / 1000
	end

	return format("%d %s ", math.floor(delta), sizes[size])
end

---------------------------------------------
local action = {
	["date"] = time,
	["ip"]   = wifi,
	["download"] = get_download,
	["battery"] = battery
}

local out = {}

-- Main loop
while true do
	for i=1, #config.order do
		out[i] = action[config.order[i]]()
	end
	io.write(concat(out, "| "))
	io.flush()
	sleep(1)
end
