local config = { 
                 ["Larvik"] = { x = 887, y = 1028, z = 7 },
                 ["Clock Master"] = { x = 200, y = 200, z = 7 },
				 ["Arena Leader"] = { x = 1012, y = 1022, z = 7 },
				 ["Azar"] = { x = 873, y = 1027, z = 6 },
				 ["Clock Master"] = { x = 962, y = 1110, z = 6 },
				 ["Discoverer"] = { x = 1081, y = 1177, z = 7 },
				 ["Dungeon Master"] = { x = 944, y = 885, z = 6 },
				 ["Fisherman"] = { x = 997, y = 1108, z = 7 },
				 ["Garik"] = { x = 912, y = 1136, z = 7 },
				 ["Golden Captain"] = { x = 1033, y = 1178, z = 6 },
				 ["Hattori"] = { x = 910, y = 1132, z = 7 },
				 ["Mount Seller"] = { x = 942, y = 1160, z = 7 },
				 ["Smaug"] = { x = 1307, y = 1526, z = 8},
				 ["Soul Hauler"] = { x = 889, y = 1119, z = 9 },
				 ["Witch"] = { x = 934, y = 1210, z = 6 },
				 ["Thel Gilius"] = { x = 934, y = 1118, z = 7 },
				 ["Wolf Hunter"] = { x = 956, y = 1090, z = 7 },
				 ["Naji"] = { x = 977, y = 1173, z = 7 },
				 ["Tokel"] = { x = 968, y = 1177, z = 7 },
				 ["Rashid"] = { x = 987, y = 1170, z = 7 },
				 ["Vincent"] = { x = 968, y = 1170, z = 6 },
				 ["Asima"] = { x = 986, y = 1177, z = 7 },
				 ["Yasir"] = { x = 967, y = 1170, z = 7 },
				 ["Lubo"] = { x = 986, y = 1169, z = 6 },
				 ["Kris"] = { x = 968, y = 1177, z = 6 },
				 ["Pat"] = { x = 946, y = 1110, z = 4 },
				 ["Flint"] = { x = 977, y = 1176, z = 6 },
				 ["Alesar"] = { x = 971, y = 1169, z = 5 },
				 ["Haroun"] = { x = 982, y = 1169, z = 5 },
				 ["Nah'Bob"] = { x = 972, y = 1177, z = 5 },
				 ["Yaman"] = { x = 982, y = 1177, z = 5 },
				 ["Asima"] = { x = 890, y = 1039, z = 6 },
				 ["Walter Jaeger"] = { x = 942, y = 1170, z = 7 },
			     ["Arena Leader"] = { x = 613, y = 1112, z = 7 },
				 ["Thel Gilius"] = { x = 935, y = 1118, z = 7 },
				 ["Aillika"] = { x = 825, y = 1165, z = 7 },
				 ["Hadrin"] = { x = 941, y = 1134, z = 7 },
				 ["Klaviels Bentmask"] = { x = 981, y = 716, z = 7 },
				 ["Magnam"] = { x = 690, y = 1124, z = 7 },
				 ["Trader"] = { x = 942, y = 1113, z = 7 },
				 ["Asima"] = { x = 986, y = 1177, z = 7 },
				 ["Boss"] = { x = 1024, y = 722, z = 6 },
				 ["Trader"] = { x = 694, y = 1129, z = 5 },
				 ["Felix Garmentmaker"] = { x = 959, y = 1117, z = 7 },
				 ["Uzuri"] = { x = 940, y = 1122, z = 6 },
               }
              

local globalevent = GlobalEvent("load_npc")
function globalevent.onStartup()
    
    for name, v in pairs(config) do
        local x = v.x
        local y = v.y
        local z = v.z
        local pos = Position(x, y, z)
        if pos then
           local npc = Game.createNpc(name, pos, false, true)
		   if npc then
		      npc:setMasterPos(pos)
		   end
        end
    end
end
globalevent:register()