function onSay(player, words, param)
    local text = ""
    local spells = {}
    for _, spell in ipairs(player:getInstantSpells()) do
        if spell.level ~= 0 then
            if spell.manapercent > 0 then
                spell.mana = spell.manapercent .. "%"
            end
            spells[#spells + 1] = spell
        end
    end

    table.sort(spells, function(a, b) return a.level < b.level end)

    local prevLevel = -1
    for i, spell in ipairs(spells) do
        local line = ""
        if prevLevel ~= spell.level then
            if i ~= 1 then
                line = "\n"
            end
            line = line .. "Spells for level:  " .. spell.level .. "\n"
            prevLevel = spell.level
        end
        text = text .. line .. "  " .. spell.words .. " : " .. spell.mana .. "\n"
    end

    player:showTextDialog(22424, text)
    return true
end