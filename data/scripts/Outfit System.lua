if not OUTFIT_SYSTEM then
   OUTFIT_SYSTEM = {}
end


OUTFIT_SYSTEM.config = {
                          ["Kokao Warrior"] = {
						                        ["Basic Attack"] = {
												                     [18] = { outfit={lookType=21}, animationDuration = 500 },
												                     [47] = { outfit={lookType=51}, animationDuration = 500 },
																	 [48] = { outfit={lookType=52}, animationDuration = 500 },
																	 [49] = { outfit={lookType=53}, animationDuration = 500 },
																	 [50] = { outfit={lookType=54}, animationDuration = 500 },
																	 [259] = { outfit={lookType=51}, animationDuration = 500 },
																	 [262] = { outfit={lookType=263}, animationDuration = 500 },
																   }  
											  },
                          ["Kaer Disciple"] = {
						                        ["Basic Attack"] = {
												                     [19] = { outfit={lookType=31}, animationDuration = 500 },
												                     [63] = { outfit={lookType=67}, animationDuration = 500 },
																	 [64] = { outfit={lookType=68}, animationDuration = 500 },
																	 [65] = { outfit={lookType=69}, animationDuration = 500 },
																	 [66] = { outfit={lookType=70}, animationDuration = 500 }
																   }  
											  },
                          ["Jade Mystic"] = {
						                        ["Basic Attack"] = {
												                     [16] = { outfit={lookType=32}, animationDuration = 900 },
																	 [17] = { outfit={lookType=32}, animationDuration = 900 },
																	 [257] = { outfit={lookType=75}, animationDuration = 900 },
												                     [71] = { outfit={lookType=75}, animationDuration = 900 },
																	 [72] = { outfit={lookType=76}, animationDuration = 900 },
																	 [73] = { outfit={lookType=77}, animationDuration = 900 },
																	 [74] = { outfit={lookType=78}, animationDuration = 900 }
																   }  
											  },	
                          ["Shepherd of Aureh"] = {
						                        ["Basic Attack"] = {
												                     [15] = { outfit={lookType=33}, animationDuration = 600 },
												                     [55] = { outfit={lookType=59}, animationDuration = 600 },
																	 [56] = { outfit={lookType=60}, animationDuration = 600 },
																	 [57] = { outfit={lookType=61}, animationDuration = 600 },
																	 [58] = { outfit={lookType=62}, animationDuration = 600 }
																   }  
											  },											  
					  }
					  
					
function OUTFIT_SYSTEM:getBasicAttackAnimation(vocation, lookType)
    local t = self.config[vocation]
    if not t then
       return false
    end
    
    local t2 = t["Basic Attack"]
    if not t2 then
       return false
    end
    return t2[lookType]
end

-- function OUTFIT_SYSTEM:getBaseOutfit(vocation, lookType)
    -- local t = self.config[vocation]
    -- if not t then
       -- return false
    -- end
    
    -- local t2 = t["Basic Attack"]
    -- if not t2 then
       -- return false
    -- end
    -- return t2[lookType]
-- end