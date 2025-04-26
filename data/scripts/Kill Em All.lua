if not SURVIVAL_EVENT_MONSTERS then
   SURVIVAL_EVENT_MONSTERS = {}
end


SURVIVAL_EVENT_MONSTERS.config = {
                                    ["Wave"] = {
									             [1] = {
												         ["Timer"] = { type = "seconds", value = 15 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 1, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 1, spawnSide = "right" },																		  
																		},
														 ["Rewards"] = { 
																		 { type = "item", itemid = 862, count = 2 },
																		 { type = "item", itemid = 863, count = 2 },
																		 { type = "item", itemid = 860, count = 1 },
																		 { type = "item", itemid = 861, count = 1 },
																		 --{ type = "Alpha Points", value = 1 },  ---remove later
																	   }
													   },		
									             [2] = {
												         ["Timer"] = { type = "seconds", value = 15 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 1, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 1, spawnSide = "right" },
																		  [3] = { name = "Drunken Gladiator", count = 1, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 1, spawnSide = "right"}																	  
																		},
														 ["Rewards"] = { 
																		 { type = "item", itemid = 862, count = 2 },
																		 { type = "item", itemid = 863, count = 2 },
																		 { type = "item", itemid = 860, count = 2 },
																		 { type = "item", itemid = 861, count = 2 },
																	   }
													   },	
									             [3] = {
												         ["Timer"] = { type = "seconds", value = 30 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 2, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 2, spawnSide = "right" },
																		  [3] = { name = "Drunken Gladiator", count = 1, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 1, spawnSide = "right"}																	  
																		},
														 ["Rewards"] = { 
																		 { type = "item", itemid = 862, count = 2 },
																		 { type = "item", itemid = 863, count = 2 },
																		 { type = "item", itemid = 860, count = 2 },
																		 { type = "item", itemid = 861, count = 2 },
																	   }
													   },	
									             [4] = {
												         ["Timer"] = { type = "seconds", value = 50 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 1, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 1, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 1, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 1, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 1, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 1, spawnSide = "right"}	  																	  
																		},
														 ["Rewards"] = { 
																		 { type = "item", itemid = 862, count = 3 },
																		 { type = "item", itemid = 863, count = 3 },
																		 { type = "item", itemid = 860, count = 3 },
																		 { type = "item", itemid = 861, count = 3 },
																	   }
													   },		
									             [5] = {
												         ["Timer"] = { type = "seconds", value = 50 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 2, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 2, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 1, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 1, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 1, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 1, spawnSide = "right"}	  																  
																		},
														 ["Rewards"] = { 
																		 { type = "item", itemid = 862, count = 4 },
																		 { type = "item", itemid = 863, count = 4 },
																		 { type = "item", itemid = 860, count = 3 },
																		 { type = "item", itemid = 861, count = 3 },
																	   }
													   },	
									             [6] = {
												         ["Timer"] = { type = "seconds", value = 60 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 1, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 1, spawnSide = "right" },
																		  [3] = { name = "Drunken Gladiator", count = 3, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 3, spawnSide = "right"}	  																	  
																		},
														 ["Rewards"] = { 
																		 { type = "item", itemid = 862, count = 4 },
																		 { type = "item", itemid = 863, count = 4 },
																		 { type = "item", itemid = 860, count = 3 },
																		 { type = "item", itemid = 861, count = 3 },
																	   }
													   },	
									             [7] = {
												         ["Timer"] = { type = "seconds", value = 90 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 2, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 2, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 2, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 2, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 1, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 1, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
																		 { type = "item", itemid = 862, count = 4 },
																		 { type = "item", itemid = 863, count = 4 },
																		 { type = "item", itemid = 860, count = 4 },
																		 { type = "item", itemid = 861, count = 4 },
																	   }
													   },			
									             [8] = {
												         ["Timer"] = { type = "seconds", value = 90 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 2, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 2, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 1, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 1, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 1, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 1, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 1, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 1, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
																		 { type = "item", itemid = 862, count = 4 },
																		 { type = "item", itemid = 863, count = 4 },
																		 { type = "item", itemid = 860, count = 4 },
																		 { type = "item", itemid = 861, count = 4 },
																	   }
													   },			
									             [9] = {
												         ["Timer"] = { type = "seconds", value = 90 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 2, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 2, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 1, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 1, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 2, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 2, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 1, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 1, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
																		 { type = "item", itemid = 862, count = 4 },
																		 { type = "item", itemid = 863, count = 4 },
																		 { type = "item", itemid = 860, count = 4 },
																		 { type = "item", itemid = 861, count = 4 },
																	   }
													   },
									             [10] = {
												         ["Timer"] = { type = "seconds", value = 100 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 2, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 2, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 2, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 2, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 2, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 2, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 1, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 1, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 1 },
																		 { type = "item", itemid = 862, count = 5 },
																		 { type = "item", itemid = 863, count = 5 },
																		 { type = "item", itemid = 860, count = 5 },
																		 { type = "item", itemid = 861, count = 5 },
																	   }
													   },	
									             [11] = {
												         ["Timer"] = { type = "seconds", value = 100 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 2, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 2, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 1, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 1, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 3, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 3, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 1, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 1, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 1 },
																		 { type = "item", itemid = 862, count = 5 },
																		 { type = "item", itemid = 863, count = 5 },
																		 { type = "item", itemid = 860, count = 5 },
																		 { type = "item", itemid = 861, count = 5 },
																	   }
													   },	
									             [12] = {
												         ["Timer"] = { type = "seconds", value = 100 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 2, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 2, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 2, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 2, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 3, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 3, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 1, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 1, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 1 },
																		 { type = "item", itemid = 862, count = 5 },
																		 { type = "item", itemid = 863, count = 5 },
																		 { type = "item", itemid = 860, count = 5 },
																		 { type = "item", itemid = 861, count = 5 },
																	   }
													   },	
									             [13] = {
												         ["Timer"] = { type = "seconds", value = 100 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 2, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 2, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 2, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 2, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 3, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 3, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 2, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 2, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 2 },
																		 { type = "item", itemid = 862, count = 5 },
																		 { type = "item", itemid = 863, count = 5 },
																		 { type = "item", itemid = 860, count = 5 },
																		 { type = "item", itemid = 861, count = 5 },
																	   }
													   },	
									             [14] = {
												         ["Timer"] = { type = "seconds", value = 120 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 3, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 3, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 3, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 3, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 3, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 3, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 2, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 2, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 2 },
																		 { type = "item", itemid = 862, count = 6 },
																		 { type = "item", itemid = 863, count = 6 },
																		 { type = "item", itemid = 860, count = 6 },
																		 { type = "item", itemid = 861, count = 6 },
																	   }
													   },		
									             [15] = {
												         ["Timer"] = { type = "seconds", value = 120 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 3, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 3, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 4, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 4, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 4, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 4, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 2, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 2, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 2 },
																		 { type = "item", itemid = 862, count = 6 },
																		 { type = "item", itemid = 863, count = 6 },
																		 { type = "item", itemid = 860, count = 6 },
																		 { type = "item", itemid = 861, count = 6 },
																	   }
													   },				
									             [16] = {
												         ["Timer"] = { type = "seconds", value = 100 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 3, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 3, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 4, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 4, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 4, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 4, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 3, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 3, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 5 },
																		 { type = "item", itemid = 862, count = 5 },
																		 { type = "item", itemid = 863, count = 5 },
																		 { type = "item", itemid = 860, count = 5 },
																		 { type = "item", itemid = 861, count = 5 },
																	   }
													   },		
									             [17] = {
												         ["Timer"] = { type = "seconds", value = 80 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 3, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 3, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 3, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 3, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 4, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 4, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 3, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 3, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 5 },
																		 { type = "item", itemid = 862, count = 4 },
																		 { type = "item", itemid = 863, count = 4 },
																		 { type = "item", itemid = 860, count = 4 },
																		 { type = "item", itemid = 861, count = 4 },
																	   }
													   },		
									             [18] = {
												         ["Timer"] = { type = "seconds", value = 60 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 3, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 3, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 4, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 4, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 5, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 5, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 3, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 3, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 5 },
																		 { type = "item", itemid = 862, count = 3 },
																		 { type = "item", itemid = 863, count = 3 },
																		 { type = "item", itemid = 860, count = 3 },
																		 { type = "item", itemid = 861, count = 3 },
																	   }
													   },	
									             [19] = {
												         ["Timer"] = { type = "seconds", value = 50 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 3, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 3, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 4, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 4, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 4, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 4, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 3, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 3, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 5 },
																		 { type = "item", itemid = 862, count = 2 },
																		 { type = "item", itemid = 863, count = 2 },
																		 { type = "item", itemid = 860, count = 2 },
																		 { type = "item", itemid = 861, count = 2 },
																	   }
													   },	
									             [20] = {
												         ["Timer"] = { type = "seconds", value = 40 },
												         ["Monsters"] = {
														                  [1] = { name = "Helmet Gladiator", count = 3, spawnSide = "left" },
																		  [2] = { name = "Helmet Gladiator", count = 3, spawnSide = "right" },
																		  [3] = { name = "Gladiator Fisherman", count = 4, spawnSide = "left" },
																		  [4] = { name = "Gladiator Fisherman", count = 4, spawnSide = "right"},
																		  [3] = { name = "Drunken Gladiator", count = 4, spawnSide = "left" },
																		  [4] = { name = "Drunken Gladiator", count = 4, spawnSide = "right"},	  	
																		  [5] = { name = "Bully Gladiator", count = 3, spawnSide = "left" },
																		  [6] = { name = "Bully Gladiator", count = 3, spawnSide = "right"},																			  
																		},
														 ["Rewards"] = { 
														                 { type = "Alpha Points", value = 25 },
																	   }
													   },													   
											   },
                                    ["Avaible Maps"] = {
									                      ["Map 1"] = {
														                [1] = { startPosition = { x = 128, y = 673, z = 6} },      
																		[2] = { startPosition = { x = 18,  y = 672, z = 6} },
																		[3] = { startPosition = { x = 125, y = 674, z = 6} },  
																		[4] = { startPosition = { x = 185, y = 675, z = 6} }, 
																		[5] = { startPosition = { x = 185, y = 711, z = 6} },  
																		[6] = { startPosition = { x = 125, y = 710, z = 6} },  
																		[7] = { startPosition = { x = 74,  y = 709, z = 6} },
																		[8] = { startPosition = { x = 18,  y = 708, z = 6} },
																		[9] = { startPosition = { x = 18,  y = 745, z = 6} },
																		[10] = { startPosition = { x = 74,  y = 746, z = 6} },
																		[11] = { startPosition = { x = 125, y = 747, z = 6} }, 
																		[12] = { startPosition = { x = 185, y = 748, z = 6} },  
																		[13] = { startPosition = { x = 185, y = 783, z = 6} },
																		[14] = { startPosition = { x = 125, y = 782, z = 6} },  
																		[15] = { startPosition = { x = 74, y = 781, z = 6} },  
																		[16] = { startPosition = { x = 18, y = 780, z = 6} }, 
																		[17] = { startPosition = { x = 18, y = 817, z = 6} },  
																		[18] = { startPosition = { x = 186, y = 856, z = 6} },
																		[19] = { startPosition = { x = 126, y = 855, z = 6} }, 
																		[20] = { startPosition = { x = 75, y = 854, z = 6} }, 
																		[21] = { startPosition = { x = 19, y = 853, z = 6} },
																		[22] = { startPosition = { x = 19, y = 890, z = 6} },  
																		[23] = { startPosition = { x = 75, y = 891, z = 6} },
																		[24] = { startPosition = { x = 126, y = 892, z = 6} }, 
																		[25] = { startPosition = { x = 186, y = 893, z = 6} }, 
																		[26] = { startPosition = { x = 186, y = 928, z = 6} }, 
																		[27] = { startPosition = { x = 126, y = 927, z = 6} }, 
																		[28] = { startPosition = { x = 75, y = 926, z = 6} }, 
																		[29] = { startPosition = { x = 19, y = 925, z = 6} },
																		[30] = { startPosition = { x = 19, y = 962, z = 6} },
																		[31] = { startPosition = { x = 75, y = 963, z = 6} }, 
																		[32] = { startPosition = { x = 126, y = 964, z = 6} }, 
																		[33] = { startPosition = { x = 186, y = 965, z = 6} },
																		[34] = { startPosition = { x = 187, y = 1002, z = 6} },
																		[35] = { startPosition = { x = 127, y = 1001, z = 6} },
																		[36] = { startPosition = { x = 76, y = 1000, z = 6} }, 
																		[37] = { startPosition = { x = 20, y = 999, z = 6} },
																		[38] = { startPosition = { x = 20, y = 1036, z = 6} }, 
																		[39] = { startPosition = { x = 76, y = 1037, z = 6} }, 
																		[40] = { startPosition = { x = 127, y = 1038, z = 6} }, 
																		[41] = { startPosition = { x = 187, y = 1039, z = 6} }, 
																		[42] = { startPosition = { x = 187, y = 1074, z = 6} },
																		[43] = { startPosition = { x = 127, y = 1073, z = 6} },
																		[44] = { startPosition = { x = 76, y = 1072, z = 6} }, 
																		[45] = { startPosition = { x = 20, y = 1071, z = 6} }, 
																		[46] = { startPosition = {x = 20, y = 1108, z = 6} },
																		[47] = { startPosition = {x = 76, y = 1109, z = 6} },
																		[48] = { startPosition = {x = 127, y = 1110, z = 6} },
																		[49] = { startPosition = {x = 187, y = 1111, z = 6} }, 
																		[50] = { startPosition = {x = 74, y = 818, z = 6} },
																		[51] = { startPosition = {x = 125, y = 819, z = 6} },
																		[52] = { startPosition = {x = 185, y = 820, z = 6} }																		
															          },
					                                }
								 }


SURVIVAL_EVENT_MONSTERS.templePosition = { x = 88, y = 251, z = 7 }



-- SURVIVAL_EVENT_MONSTERS.spawnPositions = { 
                                            -- ["Map 1"] = {
											              -- [1] = { x = -2 },
														  -- [2] = { x = 2 },
														  -- [3] = { x = -4 },
														  -- [4] = { x = 4 },
														  -- [5] = { y = 3 },
														  -- [6] = { y = -3 },
														  -- [7] = { y = -2, x = 3 },
														  -- [8] = { y = -2, x = -3 },
														  -- [9] = { y = 3, x = -3 },
														  -- [10] = { y = 3, x = 3 },
														  -- [11] = { x = 4, y = 2 },
														  -- [12] = { y = -2, x = -5 },
														  -- [13] = { y = -3, x = -6 },
														  -- [14] = { y = -2, x = 5 },
														  -- [15] = { y = -3, x = 6 },		
														  -- [16] = { x = 6 },
														  -- [17] = { y = 3, x = 6 },	
														  -- [18] = { y = 2, x = 6 },
														  -- [19] = { y = 4, x = 7 },
														  -- [20] = { y = 4, x = -6 },
														-- }
										 -- }
										 
										 
										 

function SURVIVAL_EVENT_MONSTERS:getSpawnPositions(mapName)
    return self.spawnPositions
end

function SURVIVAL_EVENT_MONSTERS:getSpawnRoom(startPosition, method)
   
   local pos = nil
   local x = nil
   local y = nil
   local z = nil
   if method == "left" then
      x = startPosition.x - 10
	  y = startPosition.y
	  z = startPosition.z
	  local min_y = -4
	  local max_y = 3
	  local min_x = -1
	  local max_x = 0
	  
	  new_x = math.random(min_x, max_x)
	  new_y = math.random(min_y, max_y)
	  return Position(x + new_x, y + new_y, z)
   end
   x = startPosition.x + 9
   y = startPosition.y
   z = startPosition.z
  
   local min_y = -3
   local max_y = 3
   local min_x = 0
   local max_x = 1
   new_x = math.random(min_x, max_x)
   new_y = math.random(min_y, max_y)
   return Position(x + new_x, y + new_y, z)
   --return Position(startPosition.x + 9, startPosition.y, startPosition.z)
end
	
function SURVIVAL_EVENT_MONSTERS:canTakeMap(id)
    if not self.maps then
	   return true
	end
	
	local t = self.config["Avaible Maps"]
	for i, v in pairs(t) do
	    if self.maps and self.maps[i] and self.maps[i][v] then
		   return false
		end
	end
end

function SURVIVAL_EVENT_MONSTERS:selectMap(player, selectedVocation)
   if not self.maps then
      self.maps = {}
   end
   
   local MAP_AVAIBLE_1 = self.maps[1]
   local MAP_AVAIBLE_2 = self.maps[2]
   local MAP_USED_1 = false
   local MAP_USED_2 = true
   
   local avaibleMaps = {}
   if MAP_AVAIBLE_1 and #MAP_AVAIBLE_1 == self.config["Avaible Maps"]["Map 1"] then
      MAP_USED_1 = true
   else
      avaibleMaps[1] = 1
   end
   
   -- if MAP_AVAIBLE_2 and #MAP_AVAIBLE_2 == self.config["Avaible Maps"]["Map 2"] then
      -- MAP_USED_2 = true
   -- else
      -- avaibleMaps[2] = 2
   -- end
   
   if MAP_USED_1 and MAP_USED_2 then
      player:sendCancelMessage("Sorry, All rooms has been take, you have to wait.")
      return false ---no more avaible maps
   end
   
   local selected_map = avaibleMaps[math.random(1, #avaibleMaps)]
   local id = math.random(1, #self.config["Avaible Maps"]["Map " .. selected_map])
   local attempts = 500
   while self.maps[selected_map] and self.maps[selected_map][id] and attempts ~= 0 do
	     selected_map = avaibleMaps[math.random(1, #avaibleMaps)]
	     id = math.random(1, #self.config["Avaible Maps"]["Map " .. selected_map])
		 attempts = attempts - 1
   end
		 

   
   if not self.maps[selected_map] then
      self.maps[selected_map] = {}
   end
   
   if self.maps[selected_map][id] then
      player:sendCancelMessage("Sorry, All rooms has been take, you have to wait.")
      return false
   end
   
   self.maps[selected_map][id] = {}
   self.maps[selected_map][id].wave = 1
   self.maps[selected_map][id].maxWave = #self.config["Wave"]
   self.maps[selected_map][id]["Player"] = {}
   self.maps[selected_map][id]["Player"].id = player:getId()
   self.maps[selected_map][id]["Player"].name = player:getName()
   


   if not self.players then
      self.players = {}
   end
   self.players[player:getId()] = { ["mapName"] = selected_map, ["mapId"] = id, ["vocation"] = player:getVocation():getName() }
   
   --print(dump(self.players))
   
   local config = self.config["Avaible Maps"]["Map " .. selected_map][id]
   local positionTable = config.startPosition
   
   player:prepareEventCharacter(selectedVocation)
   local pos = Position(positionTable.x, positionTable.y, positionTable.z)
   
   
   local tile = Tile(pos)
   if not tile then
      print("[Kill Em All] - Error, tile not found: " .. dump(pos))
      return true
   end
   
   
   
   player:registerEvent("SURVIVAL_EVENT_MONSTERS_onPrepareDeath")
   player:teleportTo(pos, true)  
   
   player:sendTextMessage(MESSAGE_STATUS_WARNING, "Attention, You have to Survive, Monsters will appear in few seconds!")
   self:displayBattleWindow(player, true)
   addEvent(function(player_id) 
      local participant = Player(player_id)
	  if not participant then
	     ---clear event, player logout
	     return true
	  end

      self:processWave(participant, selected_map, id)
	  self:setTimer(player, selected_map, id, 1)
	     
   end, 3000, player:getId())
      
end

function SURVIVAL_EVENT_MONSTERS:sendKilledMessage(player, mapName, mapId, wave)
   local t = self.maps[mapName][mapId]   
   player:sendTextMessage(MESSAGE_STATUS_WARNING, "[Wave " .. wave .. "]" .. " - Monsters Left: " .. t.monstersLeft .. "/" .. t.monstersCount)
end 
   
function SURVIVAL_EVENT_MONSTERS:startEvent(player, selectedVocation)
   
   SURVIVAL_EVENT_MONSTERS:selectMap(player, selectedVocation)
   
   
   --print("Mieloned: ")
end


function SURVIVAL_EVENT_MONSTERS:getMonsterWave(mapName, mapId, monster)
   if not self.waveMonsters then
	  return false
   end
			 
   if not self.waveMonsters[mapName] then
	  return false
   end
			 
   if not self.waveMonsters[mapName][mapId] then
	  return false
   end   
   
   local wave = self.waveMonsters[mapName][mapId][monster:getId()]
   return wave
end

function SURVIVAL_EVENT_MONSTERS:getMonstersLeftInWave(mapName, mapId, monster)
   if not self.waveMonsters then
	  return false
   end
			 
   if not self.waveMonsters[mapName] then
	  return false
   end
			 
   if not self.waveMonsters[mapName][mapId] then
	  return false
   end   
   
   local wave = self.waveMonsters[mapName][mapId][monster:getId()]
   
   local monsterTable = self.maps[mapName][mapId]["Wave Monsters"][wave]
   
   return monsterTable
end
   
function SURVIVAL_EVENT_MONSTERS:removeMonsterFromWave(mapName, mapId, monster, wave)
   if not self.waveMonsters then
	  return false
   end
			 
   if not self.waveMonsters[mapName] then
	  return false
   end
			 
   if not self.waveMonsters[mapName][mapId] then
	  return false
   end   
   
   local wave = self.waveMonsters[mapName][mapId][monster:getId()]
   
   local monsterTable = self.maps[mapName][mapId]["Wave Monsters"][wave]
   
   self.maps[mapName][mapId]["Wave Monsters"][wave][monster:getId()] = nil
end
   
   

function SURVIVAL_EVENT_MONSTERS:processWave(player, mapName, mapId)
   local mapConfig = self.config["Avaible Maps"]["Map " .. mapName][mapId]
   local mainPosition = mapConfig.startPosition
   local mapTable = self.maps[mapName][mapId]
   local currentWave = mapTable.wave
   local waveConfig = self.config["Wave"][currentWave]
   
   --local spawnTable = self:getSpawnPositions(mapName)["Map 1"]
   --print(dump(spawnTable))
	   
   local count = 0
   for i, monsterTable in pairs(waveConfig["Monsters"]) do
       local countSpawn = monsterTable.count
	   local name = monsterTable.name
	   
       --print("Spawn Side: " .. v.spawnSide)
       --local spawnSide = self:getSpawnRoom(mainPosition, v.spawnSide)
       -- local x = mainPosition.x
       -- local y = mainPosition.y
       -- local z = mainPosition.z  
       -- local spawn_x = spawnTable[i].x
	   -- local spawn_y = spawnTable[i].y
	   -- if spawn_x then
		  -- x = x + spawn_x
	   -- end
	   -- if spawn_y then
	      -- y = y + spawn_y
	   -- end
	   
	   -- print("Pos.x: " .. x)
	   -- print("Pos.y: " .. y)
	   -- print("Pos.z: " .. z)
	   
	   -- local pos = Position(x, y, z)
	   
       --local pos = Position(mainPosition.x + 2, mainPosition.y, mainPosition.z)
	   
       --local monstersTable = mapConfig.monstersPosition[i]
	   --local pos = Position(monstersTable.x, monstersTable.y, monstersTable.z)
	   
	   
	   
	   
	   for z = 1, countSpawn do
	      local spawnSide = self:getSpawnRoom(mainPosition, monsterTable.spawnSide)
		  local customName = "[Wave " .. currentWave .. "] " .. name
	      local monster = Game.createCustomMonster(name, spawnSide, true, true, customName)
	      if monster then
	         count = count + 1
			 
			 
			 if not self.maps[mapName][mapId]["Monsters"] then
			    self.maps[mapName][mapId]["Monsters"] = {}
		     end
			 
			 self.maps[mapName][mapId]["Monsters"][monster:getId()] = true
			 
			 
			 if not self.maps[mapName][mapId]["Wave Monsters"] then
			    self.maps[mapName][mapId]["Wave Monsters"] = {}
			 end
			 
			 if not self.maps[mapName][mapId]["Wave Monsters"][currentWave] then
			    self.maps[mapName][mapId]["Wave Monsters"][currentWave] = {}
			 end
			 
			 self.maps[mapName][mapId]["Wave Monsters"][currentWave][monster:getId()] = true
			 
			 if not self.waveMonsters then
			    self.waveMonsters = {}
			 end
			 
			 if not self.waveMonsters[mapName] then
			    self.waveMonsters[mapName] = {}
			 end
			 
			 if not self.waveMonsters[mapName][mapId] then
			    self.waveMonsters[mapName][mapId] = {}
			 end
			 
			 self.waveMonsters[mapName][mapId][monster:getId()] = currentWave
			 
			 
			 
			 
			 
			 
			 
	         -- if not self.maps[mapName][mapId]["Monsters"] then
		        -- self.maps[mapName][mapId]["Monsters"] = {}
		     -- end
		     --self.maps[mapName][mapId]["Monsters"][monster:getId()] = true
		  
		     if not self.monsters then
		        self.monsters = {}
		     end
		  
		     if not self.maps[mapName][mapId].totalMonsters then
		        self.maps[mapName][mapId].totalMonsters = 0
		     end
		     self.maps[mapName][mapId].totalMonsters = self.maps[mapName][mapId].totalMonsters + 1
		     self.monsters[monster:getId()] = { ["mapName"] = mapName, ["mapId"] = mapId }
	         monster:registerEvent("SURVIVAL_EVENT_MONSTERS_onDeath")
	      end
       end
   end
   -- if self.maps[mapName][mapId].monstersCount then
      -- self.maps[mapName][mapId].monstersCount = self.maps[mapName][mapId].monstersCount + count
   -- else
      -- self.maps[mapName][mapId].monstersCount = count
   -- end
   
   -- if self.maps[mapName][mapId].monstersLeft then
      -- self.maps[mapName][mapId].monstersLeft = self.maps[mapName][mapId].monstersLeft + count
	  
	  -- print("Monsters count: " .. self.maps[mapName][mapId].monstersCount)
	  -- print("Monsters Left: " .. self.maps[mapName][mapId].monstersLeft)
	  -- --self.maps[mapName][mapId].monstersLeft = self.maps[mapName][mapId].monstersLeft + count
	  -- self.maps[mapName][mapId].monstersCount = count - self.maps[mapName][mapId].monstersLeft

	  
	 if self.maps[mapName][mapId].monstersLeft then
        self.maps[mapName][mapId].monstersLeft = self.maps[mapName][mapId].monstersLeft + count
		self.maps[mapName][mapId].monstersCount = self.maps[mapName][mapId].monstersLeft
	 else
	    self.maps[mapName][mapId].monstersLeft = count
	    self.maps[mapName][mapId].monstersCount = count
	 end
	  
	  
   -- else
      --self.maps[mapName][mapId].monstersLeft = count
	  --self.maps[mapName][mapId].monstersCount = count
   --end
   --self.maps[mapName][mapId].monstersLeft = count
   self:sendKilledMessage(player, mapName, mapId, currentWave)
   
   
   --print(dump(SURVIVAL_EVENT_MONSTERS.maps))
end

function SURVIVAL_EVENT_MONSTERS:setNextWave(mapName, mapId)
   self.maps[mapName][mapId].wave = self.maps[mapName][mapId].wave + 1
end

function SURVIVAL_EVENT_MONSTERS:getWave(mapName, mapId)
   return self.maps[mapName][mapId].wave
end

function SURVIVAL_EVENT_MONSTERS:hasNextWave(mapName, mapId)
   local wave = self:getWave(mapName, mapId)
   if not self.config["Wave"][wave + 1] then
      return false
   end
   return true
end

function SURVIVAL_EVENT_MONSTERS:finishEvent(mapName, mapId, finished, displayRewards)


    if not self.maps then
	   return 
	end
	
	if not self.maps[mapName] then
	   return
	end
	
	if not self.maps[mapName][mapId] then
	   return
	end

	
	local mapConfig = self.maps[mapName][mapId]
	local playerConfig = mapConfig["Player"]
	local player_id = playerConfig["id"]
	local player = Player(player_id)
	local alphaToken = mapConfig.alphaToken

	
	if player then
	   --self:addRewards()
	   --self:sendRewards()
	   local posTable = self.templePosition
	   local pos = Position(posTable.x, posTable.y, posTable.z)
	   --player:getTown():getTemplePosition()
	   local voc = self.players[player_id]["vocation"]
	   player:prepareEventCharacter(voc)
	   player:teleportTo(pos)
	   self:displayBattleWindow(player, false)
	   
	   if finished or displayRewards then
	      if alphaToken then
		      player:addAlphaPoints(alphaToken)
			  -- local t = POINTS_SYSTEM.earnPoints[player:getVocation():getName()]
	          -- POINTS_SYSTEM:generatePoints(player, alphaToken, t)
		  end
		  
	      self:displayRewards(player, mapName, mapId)
	   end
	end
	
	--if not finished then
	local monsterTable = self.maps[mapName][mapId]["Monsters"]
	if monsterTable then	 
	  for i, v in pairs(monsterTable) do
	    local monster = Creature(i)
		if monster then
		   monster:remove()
		   self.monsters[i] = nil
		end
	  end
	end
	   
	self.maps[mapName][mapId] = nil
	self.players[player_id] = nil	
	self.waveMonsters[mapName][mapId] = nil
end

function SURVIVAL_EVENT_MONSTERS:sendOpCode(player, request) 
	local packet = NetworkMessage()
	packet:addByte(0x32)
    packet:addByte(0xF3)
	packet:addString(request)
	packet:sendToPlayer(player)
	packet:delete()
    return true
end

function SURVIVAL_EVENT_MONSTERS:displayRewards(player, mapName, mapId)
   local t = self.maps[mapName][mapId]
   local request = {}
   request.buffer = "monsterArena_display"
   request.data = {}
   request.data.totalWaves = t.maxWave
   request.data.clearedWaves = t.wave
   request.data.totalMonsters = t.totalMonsters
   local killedMonsters = t.killedMonsters
   if not killedMonsters then
      killedMonsters = 0
   end
   request.data.killedMonsters = killedMonsters
   request.data.alphaToken = t.alphaToken
   request.data.alphaToken = t.alphaToken
   request = json.encode(request)
   self:sendOpCode(player, request) 
end

function SURVIVAL_EVENT_MONSTERS:displayBattleWindow(player, boolean)
   local request = {}
   request.buffer = "monsterArena_displayBattleWindow"
   request.boolean = boolean
   request = json.encode(request)
   self:sendOpCode(player, request) 
end
  

function SURVIVAL_EVENT_MONSTERS:setTimer(player, mapName, mapId, wave)

    local t = self.config["Wave"][wave]["Timer"]
	
   	local method = t.type
	local duration = t.value
    local interval = 0
	
	if string.find(method, "msecond") then
       interval = duration
    elseif string.find(method, "second") then
	   interval = duration * 1000
    elseif string.find(method, "minute") then
	   interval = duration * 60
    elseif string.find(method, "hour") then 
	   interval = duration * 60 * 60
    end 

    self.maps[mapName][mapId].finishTime = interval + os.time()
	
	
	addEvent(function(player_id)
	   local participant = Player(player_id)
	   if not participant then
	      self:finishEvent(mapName, mapId, true)
		  return
	   end
	   
	   if not self.maps then
	      --print("Return 2")
	      return
	   end
	   
	   if not self.maps[mapName] then
	      --print("Return 3")
	      return
	   end
	   
	   if not self.maps[mapName][mapId] then
	     -- print("Return 4")
	      return
       end
	   
	   if self.maps[mapName][mapId].wave ~= wave then
	     -- print("Return 5")
	      return
	   end
	   
	  -- print("Tu chce byc?")
	   if self:hasNextWave(mapName, mapId) then		     
		  self:setNextWave(mapName, mapId)
		  participant:sendTextMessage(MESSAGE_STATUS_WARNING, "Timeout!, Next Wave will begin..")
		  self:processWave(participant, mapName, mapId)
		  self:setTimer(player, mapName, mapId, self.maps[mapName][mapId].wave)
	   else
		  participant:sendTextMessage(MESSAGE_STATUS_WARNING, "Timeout, Event has ended.")
		  self:finishEvent(mapName, mapId, true)
	   end
	 end, interval, player:getId())
			 
	
end
   

function SURVIVAL_EVENT_MONSTERS:addRewards(player, rewardsTable, mapName, mapId)
    --print(dump(rewardsTable))
	
	local items = {}
	local hasItems = false
	for i, v in pairs(rewardsTable) do
		if v.type == "Alpha Token" or v.type == "Alpha Points" then
		   if not self.maps[mapName][mapId].alphaToken then
			  self.maps[mapName][mapId].alphaToken = 0
		   end
		   self.maps[mapName][mapId].alphaToken = SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].alphaToken + v.value
        elseif v.type == "item" then
		   hasItems = true
		   if not items[v.itemid] then
		      items[v.itemid] = 0
		   end
		   items[v.itemid] = items[v.itemid] + v.count
		   player:addItem(v.itemid, v.count)
		end
	end
	
	if hasItems then
	   hotkeys:sendUpdate(player)
	   local str = "You have received "
	   local index = 1
	   for i, v in pairs(items) do
	       str = str .. v .. "x " .. getItemName(i)
		   if index == tablelength(items) then
		      str = str .. "."
		   else
		      str = str .. ", "
		   end
		   index = index + 1
	   end
	   player:sendTextMessage(MESSAGE_INFO_DESCR, str)
	end
end

		  

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

creatureevent = CreatureEvent("SURVIVAL_EVENT_MONSTERS_onPrepareDeath")
function creatureevent.onPrepareDeath(player)
	   ---SURVIVAL_EVENT_MONSTERS:finishEvent(mapName, mapId, finished) 
   if not SURVIVAL_EVENT_MONSTERS.players then
	  return true
   end
	   
   local t = SURVIVAL_EVENT_MONSTERS.players[player:getId()]
   if not t then
	  return true
   end
	   
   local mapName = t["mapName"]
   local mapId = t["mapId"]
   SURVIVAL_EVENT_MONSTERS:finishEvent(mapName, mapId, false, true)
   return true
end
creatureevent:register()

creatureevent = CreatureEvent("SURVIVAL_EVENT_MONSTERS_onLogout")
function creatureevent.onLogout(player)
	   ---SURVIVAL_EVENT_MONSTERS:finishEvent(mapName, mapId, finished) 
	   
	SURVIVAL_EVENT_MONSTERS:displayBattleWindow(player, false)
   if not SURVIVAL_EVENT_MONSTERS.players then
	  return true
   end
	   
   local t = SURVIVAL_EVENT_MONSTERS.players[player:getId()]
   if not t then
	  return true
   end
	   
   local mapName = t["mapName"]
   local mapId = t["mapId"]
   SURVIVAL_EVENT_MONSTERS:finishEvent(mapName, mapId, false, true)
   return true
end
creatureevent:register()


local creatureevent = CreatureEvent("SURVIVAL_EVENT_MONSTERS_onDeath")
function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)

	   

	if creature:isMonster() then
	   local pos = creature:getPosition()
	   addEvent(function()
	      local tile = Tile(pos)
		  local items = tile:getItems()
		  for _, item in pairs(items) do
		      if item and item:getId() == 889 then
			     item:remove()
			  end
		  end
	   end, 5000)
	   
	   
	   local id = creature:getId()
	   local monsterTable = SURVIVAL_EVENT_MONSTERS.monsters[id]
	   local mapName = monsterTable.mapName
	   local mapId = monsterTable.mapId
	   local currentWave = SURVIVAL_EVENT_MONSTERS:getWave(mapName, mapId)
	   if not SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].killedMonsters then
	      SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].killedMonsters = 0
	   end
	   SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].killedMonsters = SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].killedMonsters + 1
	   SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId]["Monsters"][id] = nil
	   SURVIVAL_EVENT_MONSTERS.monsters[id] = nil
	   
	   if SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].monstersLeft > 0 then
	      SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].monstersLeft = SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].monstersLeft - 1
		  --SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].monstersCount = SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].monstersCount - 1
		  SURVIVAL_EVENT_MONSTERS:sendKilledMessage(killer, mapName, mapId, currentWave)
	   end
       
	   
	   local monsterWave = SURVIVAL_EVENT_MONSTERS:getMonsterWave(mapName, mapId, creature)
	   SURVIVAL_EVENT_MONSTERS:removeMonsterFromWave(mapName, mapId, creature, monsterWave)
	   local monsterWaveLeft = SURVIVAL_EVENT_MONSTERS:getMonstersLeftInWave(mapName, mapId, creature)
	   if tablelength(monsterWaveLeft) == 0 then
	      local waveTable = SURVIVAL_EVENT_MONSTERS.config["Wave"][monsterWave]
		  local rewardsTable = waveTable["Rewards"]
		  SURVIVAL_EVENT_MONSTERS:addRewards(killer, rewardsTable, mapName, mapId)
	   end
	   
	   
	   if SURVIVAL_EVENT_MONSTERS.maps[mapName][mapId].monstersLeft == 0 then
	      -- local waveTable = SURVIVAL_EVENT_MONSTERS.config["Wave"][currentWave]
		  -- local rewardsTable = waveTable["Rewards"]
		  -- SURVIVAL_EVENT_MONSTERS:addRewards(killer, rewardsTable, mapName, mapId)
	      if SURVIVAL_EVENT_MONSTERS:hasNextWave(mapName, mapId) then		     
			 SURVIVAL_EVENT_MONSTERS:setNextWave(mapName, mapId)
			 
			 killer:sendTextMessage(MESSAGE_STATUS_WARNING, "Attention, Next Wave will begin in few seconds..")
			 
			 addEvent(function(player_id)
			    local participant = Player(player_id)
				if not participant then
				   -- clear event
				   return true
				end
			    SURVIVAL_EVENT_MONSTERS:processWave(participant, mapName, mapId)
				SURVIVAL_EVENT_MONSTERS:setTimer(killer, mapName, mapId, SURVIVAL_EVENT_MONSTERS:getWave(mapName, mapId))
			 end, 3000, killer:getId())
		  else
		     killer:sendTextMessage(MESSAGE_STATUS_WARNING, "Congratulations, you have finished all waves..")
			 SURVIVAL_EVENT_MONSTERS:finishEvent(mapName, mapId, true)
		  end		  
	   end
	   return true
	end
    return true
end
creatureevent:register()

creatureevent = CreatureEvent("SURVIVAL_EVENT_MONSTERS_onLogin33")
function creatureevent.onLogin(player)
   SURVIVAL_EVENT_MONSTERS:displayBattleWindow(player, false)
   return true
end
creatureevent:register()


   
   
   
   
   
   
   
   
	
	
	
	
	
	
									

