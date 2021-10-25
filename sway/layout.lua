#!/usr/bin/luajit

local cjson = require "cjson.safe"
local format = string.format
local ffi = require "ffi"
local C = ffi.C

ffi.cdef[[
unsigned int sleep(unsigned int seconds);
]]

local expected_outputs = {
	{
		make = "BenQ Corporation",
		model = "BenQ XL2420G",
		serial = "JCE00573SL0",
		disabled = false,
		pos = {
			x = 3840,
			y = 0,
		},
		mode = "1920x1080@30hz",
		workspace = 1,
	},
	{
		make = "Synaptics Inc",
		model = "Non-PnP",
		serial = "0x00000101",
		disabled = false,
		pos = {
			x = 3840,
			y = 1080
		},
		mode = "1920x1080@30hz",
		workspace = 2,
	},
	{
		make = "Goldstar Company Ltd",
		model = "LG Ultra HD",
		serial = "0x000017A1",
		disabled = false,
		pos = {
			x = 0,
			y = 0,
		},
		mode = "3840x2160@30hz",
		workspace = 3,
	},
	{
		make = "Chimei Innolux Corporation",
		model = "0x14C9",
		serial = "0x00000000",
		disabled = true,
		pos = "",
		mode = "",
		workspace = 1,
	},

}

local function get_outputs()
	local handle = io.popen("swaymsg -t get_outputs")
	local ret = handle:read("*a")
	return cjson.decode(ret)
end

local function is_same(out1, out2)
	return out1.make == out2.make
	       and out1.model == out2.model
		   and out1.serial == out2.serial
end

-- check that the outputs are present
local all_found = true
for _,output in ipairs(get_outputs()) do
	local found = false
	for _, expected in ipairs(expected_outputs) do
		if is_same(output, expected) then
			found = true
		end
	end
	if not found then
		all_found = false
		print(format("missing output: %s %s %s", output.make, output.model, output.serial))
	end
end

if not all_found then
	return
end

local cmd = "swaymsg output eDP-1 disable"
local handle = io.popen(cmd)

local result, err = cjson.decode(handle:read("*a"))
if not result then
	print("failed to parse result: ", err)
	return
else
	if result[1].success ~= true then
		print(format("cmd %q failed: %s", cmd, err))
		return
	end
end


local function fail()
	local cmd = "swaymsg output eDP-1 enable"
	local handle = io.popen(cmd)
	return
end

for _, output in ipairs(expected_outputs) do
	local out_name = format("\\'%s %s %s\\'", output.make, output.model, output.serial)
	local out_cmd = format("swaymsg output %s", out_name)
	if output.disabled then
		cmd = format("%s dpms off disable", out_cmd)
	else
		cmd = format("%s pos %d %d mode %s dpms on enable", out_cmd, output.pos.x, output.pos.y, output.mode)
	end

	print("running: ", cmd)
	handle = io.popen(cmd)
	result, err = cjson.decode(handle:read("*a"))
	if not result then
		print("failed to parse result: ", err)
	else
		if result[1].success ~= true then
			print(format("cmd %q failed: %s", cmd, err))
			return fail()
		end
	end

	-- move workspace
	cmd = format("swaymsg workspace %d", output.workspace)

	handle = io.popen(cmd)

	cmd = format("swaymsg move workspace to %s", out_name)
end
