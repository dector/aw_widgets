--[[
    Music Player Daemon (MPD) Widget State for Awesome WM
    Developed by dector, Feb 2011
    Contributed on GPL3 Licence
--]]

mpd_widget = widget({ type = "textbox", name = "tb_mpd", align = "right" })

function update_mpd_state(widget)
    local fd = io.popen("mpc -f 'Title: %title%\nArtist: %artist%'")
    local status = fd:read("*all")
    fd:close()

    local state = string.match(status, "%[(%w+)%]")
    local artist = string.match(status, "Artist: ([%w '\"\-]+)")
    local title = string.match(status, "Title: ([%w '\"\-]+)")

    local state_str

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

