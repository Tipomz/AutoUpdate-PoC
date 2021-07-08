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
    moonlight.vars.add(autoupdate.version, 1, false, true)
	
	-- create font
	moonlight.vars.add(autoupdate.font, moonlight.visuals.add_font("Consolas", 8))
	
	-- create color
    moonlight.vars.add(autoupdate.color_r, 255.0, true)
    moonlight.vars.add(autoupdate.color_g, 0.0, true)
    moonlight.vars.add(autoupdate.color_b, 0.0, true)
    moonlight.vars.add(autoupdate.color_a, 255.0, true)
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