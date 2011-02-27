    volume_widget = widget({ type = "textbox", name = "tb_volume",
                             align = "right" })

    function update_volume(widget)
        local fd = io.popen("amixer sget Master")
        local status = fd:read("*all")
        fd:close()
        
        local level = tonumber(string.match(status, "(%d?%d?%d)%%"))
	local volume = level / 100
        -- volume = string.format("% 3d", volume)

        status = string.match(status, "%[(o[^%]]*)%]")

        -- starting colour
        local sr, sg, sb = 0x00, 0x00, 0x00
        -- ending colour
        local er, eg, eb = 0xFF, 0xFF, 0xFF

        local ir = volume * (er - sr) + sr
        local ig = volume * (eg - sg) + sg
        local ib = volume * (eb - sb) + sb
        interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)
        if string.find(status, "on", 1, true) then
            volume = " <span>Vol. " .. level .. "%</span>"
        else
            volume = " <span><b>Mut.</b> " .. level .. "%</span>"
        end
        widget.text = volume
     end

    update_volume(volume_widget)
    awful.hooks.timer.register(1, function () update_volume(volume_widget) end)

