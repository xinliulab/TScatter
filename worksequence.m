function ws = worksequence(forzigbee, time, zigwake, zigsleep, wifiwake, wifitraffic)
    zigcycle = zigwake + zigsleep;
    wificycle = floor(wifiwake/wifitraffic);
    
    if time ~= 0
        if rem(time, zigcycle) > 0 && rem(time, zigcycle) <= zigwake
            zigenable = 1;
        else
            zigenable = 0;
        end
        if rem(time, wificycle) > 0 && rem(time, wificycle) <= wifiwake
            wifienable = 1;
        else
            wifienable = 0;
        end
        
        if forzigbee == 1
            if wifienable == 1
                ws = 0;
            else
                ws = zigenable;
            end
        else
            ws = wifienable;
        end
    else
        ws = 0;
    end
end