-- https://fantasy.cat/forums/index.php?threads/headdot-esp.3957/
local autoupdate = {
	name = "settings_autoupdate",
	version = "settings_autoupdate_version",
	font = "settings_autoupdate_font",
	color_r = "settings_autoupdate_color_r",
	color_g = "settings_autoupdate_color_g",
	color_b = "settings_autoupdate_color_b",
	color_a = "settings_autoupdate_color_a"
}

function autoupdate.PostInitialize()
	-- plugin variable and hardcoding version number
	moonlight.vars.add(autoupdate.name, 1)
	moonlight.vars.add(autoupdate.version, 2, false, true)
	
	-- create font
	moonlight.vars.add(autoupdate.font, moonlight.visuals.add_font("Consolas", 8))
	
	-- create color
	moonlight.vars.add(autoupdate.color_r, 0.0, true)
	moonlight.vars.add(autoupdate.color_g, 255.0, true)
	moonlight.vars.add(autoupdate.color_b, 0.0, true)
	moonlight.vars.add(autoupdate.color_a, 255.0, true)
	
	-- download upstream's version
	local content, response = moonlight.windows.download("https://raw.githubusercontent.com/Tipomz/AutoUpdate-PoC/main/version.txt")
	-- check if download was successful
	if response ~= 0 then return end
	
	-- get versions
	local current_version = moonlight.vars.get(autoupdate.version)
	local upstream_version = tonumber(content)

	-- compare versions
	if upstream_version == current_version then return end
	
	-- download the newer version of plugin
	local content, response = moonlight.windows.download("https://raw.githubusercontent.com/Tipomz/AutoUpdate-PoC/main/autoupdate.lua")
	--check if download was successful
	if response ~= 0 then return end
	
	-- write new version of plugin on top of current version
	moonlight.windows.file.write("scripts\\autoupdate.lua", content)
	-- reload new version
	moonlight.scripts.reload("scripts\\autoupdate.lua")
end

function autoupdate.OnEndScene(device)
	-- ingame check
    if moonlight.game.is_connected() == false or moonlight.game.is_ingame() == false then return end

	-- plugin check
	if autoupdate.version == nil or autoupdate.font == nil then return end

	local version = moonlight.vars.get(autoupdate.version)

	-- get font
	local font = moonlight.vars.get(autoupdate.font)
	
	-- get color
	local color = {
		r =  moonlight.vars.get(autoupdate.color_r),
		g =  moonlight.vars.get(autoupdate.color_g),
		b =  moonlight.vars.get(autoupdate.color_b),
		a =  moonlight.vars.get(autoupdate.color_a),
	}

	-- get screen size
	local wx, wy = moonlight.visuals.get_screen_size()

	-- draw version number in middle of screen
	moonlight.visuals.draw_string(wx / 2, wy / 3, font, color, version)
end

return autoupdate