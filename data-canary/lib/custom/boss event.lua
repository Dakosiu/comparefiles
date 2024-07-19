BOSS_EVENT_SYSTEM = {
              ["Configuration"] = {
			                        time = 1, -- w godzinach
									requiredLevel = 50,
								  },
			  ["Rooms"] = { 
                             ["Knight Room"] = {
							                     ["Teleport"] = { id = 25057,
												                  position = { x = 607, y = 1109, z = 7},
																},
												 ["Teleport Kick"] = { id = 25058,
												                       position = { x = 671, y = 1108, z = 7 },
																     },
							                     ["Boss"] = { name = "Venom Scarab",
												              position = { x = 680, y = 1092, z = 7 }
														    },
							                     destination = { x = 672, y = 1108, z = 7 },
			                                     kickPos = { x = 613, y = 1115, z = 7 },
							                     minPlayers = 1,
							                     rewards = { 
							                                 backpack = { enabled = true, backpack_id = 2854, name = "Reward Backpack", description = "This is a backpack obtained by participating boss event." },
							                                 ["First Place"] = { 
										                                         { type = "experience", value = 1 },
															                     { type = "item", item_id = 40424, count = 1, chance = 70 },
																				 --{ type = "points", value = 30 },
														   },
										                    ["Second Place"] = { 
                                                                                 { type = "experience", value = 2 },
																				 --{ type = "points", value = 15 },
                                                           },
                                                            ["Third Place"] = { 
                                                                                 { type = "experience", value = 3 },
																				-- { type = "points", value = 5 },
                                                                              },
															["Normal"] = {
															                     { type = "experience", value = 666 },
																				 --{ type = "points", value = 1 }, 
																				},
                                                           },													   
						                        },
                             ["Paladin Room"] = {
							                     ["Teleport"] = { id = 25055,
												                  position  = { x = 615, y = 1108, z = 7},
																},
												 ["Teleport Kick"] = { id = 25055,
												                       position = { x = 570, y = 1087, z = 7 },
																     },
							                     ["Boss"] = { name = "Venom Scarab",
												              position = { x = 580, y = 1066, z = 7 }
														    },
							                     destination = { x = 570, y = 1086, z = 7 },
			                                     kickPos = { x = 613, y = 1115, z = 7 },
							                     minPlayers = 1,
							                     rewards = { 
							                                 backpack = { enabled = true, backpack_id = 2854, name = "Reward Backpack", description = "This is a backpack obtained by participating boss event." },
							                                 ["First Place"] = { 
										                                         { type = "experience", value = 1 },
                                                                                 { type = "item", item_id = 3366, count = 1, chance = 90 },
																				 { type = "points", value = 30 },
														   },
										                    ["Second Place"] = { 
                                                                                 { type = "experience", value = 2 },
																				 --{ type = "points", value = 15 },
                                                           },
                                                            ["Third Place"] = { 
                                                                                 { type = "experience", value = 3 },
																				 --{ type = "points", value = 5 },
                                                                              },
                                                           },
															["Normal"] = {
															                     { type = "experience", value = 666 },
																				 --{ type = "points", value = 1 }, 
															},														   
						                        },
                             ["Druid Room"] = {
							                     ["Teleport"] = { id = 25049,
												                  position = { x = 611, y = 1108, z = 7},
																},
												 ["Teleport Kick"] = { id = 25050,
												                       position = { x = 599, y = 1091, z = 7 },
																     },
							                     ["Boss"] = { name = "Venom Scarab",
												              position = { x = 618, y = 1065, z = 7 }
														    },
							                     destination = { x = 600, y = 1091, z = 7 },
			                                     kickPos = { x = 613, y = 1115, z = 7 },
							                     minPlayers = 1,
							                     rewards = { 
							                                 backpack = { enabled = true, backpack_id = 2854, name = "Reward Backpack", description = "This is a backpack obtained by participating boss event." },
							                                 ["First Place"] = { 
										                                         { type = "experience", value = 1 },
																				 { type = "item", item_id = 40426, count = 1, chance = 70 },
																				 { type = "points", value = 30 },

														   },
										                    ["Second Place"] = { 
                                                                                 { type = "experience", value = 2 },
																				 { type = "points", value = 15 },
                                                           },
                                                            ["Third Place"] = { 
                                                                                 { type = "experience", value = 3 },
																				 { type = "points", value = 5 },
                                                                              },
															["Normal"] = {
															                     { type = "experience", value = 10 },
																				 { type = "points", value = 500 }, 
																				},
                                                           },													   
						                        },
                             ["Sorcerer Room"] = {
							                     ["Teleport"] = { id = 25051,
												                  position = { x = 619, y = 1108, z = 7 },
																},
												 ["Teleport Kick"] = { id = 25052,
												                       position = { x = 661, y = 1067, z = 7},
																     },
							                     ["Boss"] = { name = "Venom Scarab",
												              position = { x = 664, y = 1047, z = 7 }
														    },
							                     destination = { x = 662, y = 1067, z = 7 },
			                                     kickPos = { x = 613, y = 1115, z = 7 },
							                     minPlayers = 1,
							                     rewards = { 
							                                 backpack = { enabled = true, backpack_id = 2854, name = "Reward Backpack", description = "This is a backpack obtained by participating boss event." },
							                                 ["First Place"] = { 
										                                         { type = "experience", value = 1 },
																				 { type = "item", item_id = 40427, count = 1, chance = 70 },
																				 { type = "points", value = 30 },

														   },
										                    ["Second Place"] = { 
                                                                                 { type = "experience", value = 2 },
																				 { type = "points", value = 15 },
                                                           },
                                                            ["Third Place"] = { 
                                                                                 { type = "experience", value = 3 },
																				 { type = "points", value = 5 },
                                                                              },
															["Normal"] = {
															                     { type = "experience", value = 666 },
																				 { type = "points", value = 500 }, 
																				},
                                                           },													   
						                        },
			              }
			}