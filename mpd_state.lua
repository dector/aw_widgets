    mpd_widget = widget({ type = "textbox", name = "tb_mpd",
                             align = "right" })

    function update_mpd_state(widget)
        local fd = io.popen("mpc status -f 'Title: %title%\nArtist: %artist%'")
        local status = fd:read("*all")
        fd:close()

	state = string.match(status, "%[(%w+)%]")
	artist = string.match(status, "Artist: ([%w\ ]+)")
	title = string.match(status, "Title: ([%w\ ]+)")

	if state == nil then
	    state_str = "<b>MPD</b>: Stopped"
	elseif state == "paused" then
	    state_str = "<b>MPD</b>: Paused"
	else
	    state_str = artist .. " - " .. title
	end
	widget.text = state_str
    end

    update_mpd_state(mpd_widget)
    awful.hooks.timer.register(1, function () update_mpd_state(mpd_widget) end)

