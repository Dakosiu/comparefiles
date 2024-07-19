local items = {31265, 10342, 21703, 26143, 28664}

for i = 1, #items do
    local m = MoveEvent()
    m:id(items[i])
    m:type("equip")
    m:slot("ammo")
    m:register()
    
    m = MoveEvent()
    m:id(items[i])
    m:type("deequip")
    m:slot("ammo")
    m:register()
end