--local EffectTile = GlobalEvent("TimeEffect")
--local Cooldown = 3000 -- in milliseconds

--local Tiles = {
  -- [1] = { x = 835, y = 862, z = 5, Effect = 455 },
   --[2] = { x = 939, y = 1057, z = 0, Effect = 454 },
   --[3] = { x = 938, y = 1057, z = 0, Effect = 454 },
   --[4] = { x = 939, y = 1056, z = 0, Effect = 454 },
   --[5] = { x = 898, y = 887, z = 4, Effect = 456 },
 --]] Text = "Blessings"  Position(897, 887, 4)
}

--function EffectTile.onThink(interval, lastExecution)
  -- for i in pairs(Tiles) do
    --  Position(Tiles[i].x, Tiles[i].y, Tiles[i].z):sendMagicEffect(Tiles[i].Effect)
      --Position(Tiles[i].x, Tiles[i].y, Tiles[i].z):sendAnimatedText(Tiles[i].Text, Tiles[i].color)
   --end
--end

--EffectTile:interval(Cooldown)
--EffectTile:register()