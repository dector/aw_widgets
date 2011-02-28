    --[[
        Volume State Widget for Awesome WM
        Developed by dector, Feb 2011
        Contibuted on GPL3 Licence
    ]]--

volume_widget = widget({ type = "textbox", name = "tb_volume", align = "right" })

function update_volume(widget)
    local fd = io.popen("amixer sget Master")
    local status = fd:read("*all")
    fd:close()
        
    local level = tonumber(string.match(status, "(%d?%d?%d)%%"))
	local volume = level / 100

    if string.find(status, "on", 1, true) then
        volume = " <span>Vol. " .. level .. "%</span>"
    else
        volume = " <span><b>Mut.</b> " .. level .. "%</span>"
    end
        widget.text = volume
end

    update_volume(volume_widget)
    awful.hooks.timer.register(1, function () update_volume(volume_widget) end)
