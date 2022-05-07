Config = {}

Config.AttachedVehicle = nil

Config.AuthorizedIds = {
    "insertcitizenidhere",
}

Config.MaxStatusValues = {
    ["engine_damage"] = 1000.0,
    ["body_damage"] = 1000.0,
    ["radiator"] = 100,
    ["axle"] = 100,
    ["brakes"] = 100,
    ["clutch"] = 100,
    ["fuelinjector"] = 100,
	["tire"] = 100,
	["electronic"] = 100,
	["transmission"] = 100,
}

Config.ValuesLabels = {
    ["engine_damage"] = "Động cơ",
    ["body_damage"] = "Thân vỏ",
    ["radiator"] = "Tản nhiệt",
    ["axle"] = "Trục xe",
    ["brakes"] = "Phanh xe",
    ["clutch"] = "Ly hợp",
    ["fuelinjector"] = "Kim phun",
	["tire"] = "Lốp xe",
	["electronic"] = "Thiết bị điện tử",
	["transmission"] = "Hộp số",
}

Config.RepairCostAmount = {
    ["engine_damage"] = {
		A = {
		label = "Động cơ Hạng A",
        item = "engineparta",
        costs = 1,
		},
		
		B = {
		label = "Động cơ Hạng B",
        item = "enginepartb",
        costs = 1,
		},
		
		C = {
		label = "Động cơ Hạng C",
        item = "enginepartc",
        costs = 1,
		},
		
		D = {
		label = "Động cơ Hạng D",
        item = "enginepartd",
        costs = 1,
		},
		
		S = {
		label = "Động cơ Hạng S",
        item = "engineparts",
        costs = 1,
		}
		
    },
    ["body_damage"] = {
		A = {
		label = "Vỏ xe Hạng A",
        item = "bodypanela",
        costs = 1,
		},
		
		B = {
		label = "Vỏ xe Hạng B",
        item = "bodypanelb",
        costs = 1,
		},
		
		C = {
		label = "Vỏ xe Hạng C",
        item = "bodypanelc",
        costs = 1,
		},
		
		D = {
		label = "Vỏ xe Hạng D",
        item = "bodypaneld",
        costs = 1,
		},
		
		S = {
		label = "Vỏ xe Hạng S",
        item = "bodypanels",
        costs = 1,
		}
		
    },
    ["radiator"] = {
		A = {
		label = "Bộ làm mát Hạng A",
        item = "coolingparta",
        costs = 1,
		},
		
		B = {
		label = "Bộ làm mát Hạng B",
        item = "coolingpartb",
        costs = 1,
		},
		
		C = {
		label = "Bộ làm mát Hạng C",
        item = "coolingpartc",
        costs = 1,
		},
		
		D = {
		label = "Bộ làm mát Hạng D",
        item = "coolingpartd",
        costs = 1,
		},
		
		S = {
		label = "Bộ làm mát Hạng S",
        item = "coolingparts",
        costs = 1,
		}
    },
    ["axle"] = {
		A = {
		label = "Trục xe Hạng A",
        item = "axleparta",
        costs = 1,
		},
		
		B = {
		label = "Trục xe Hạng B",
        item = "axlepartb",
        costs = 1,
		},
		
		C = {
		label = "Trục xe Hạng C",
        item = "axlepartc",
        costs = 1,
		},
		
		D = {
		label = "Trục xe Hạng D",
        item = "axlepartd",
        costs = 1,
		},
		
		S = {
		label = "Trục xe Hạng S",
        item = "axleparts",
        costs = 1,
		}
    },
    ["brake"] = {
		A = {
		label = "Phanh xe Hạng A",
        item = "brakeparta",
        costs = 1,
		},
		
		B = {
		label = "Phanh xe Hạng B",
        item = "brakepartb",
        costs = 1,
		},
		
		C = {
		label = "Phanh xe Hạng C",
        item = "brakepartc",
        costs = 1,
		},
		
		D = {
		label = "Phanh xe Hạng D",
        item = "brakepartd",
        costs = 1,
		},
		
		S = {
		label = "Phanh xe Hạng S",
        item = "brakeparts",
        costs = 1,
		}
    },
    ["clutch"] = {
		A = {
		label = "Ly hợp Hạng A",
        item = "clutchparta",
        costs = 1,
		},
		
		B = {
		label = "Ly hợp Hạng B",
        item = "clutchpartb",
        costs = 1,
		},
		
		C = {
		label = "Ly hợp Hạng C",
        item = "clutchpartc",
        costs = 1,
		},
		
		D = {
		label = "Ly hợp Hạng D",
        item = "clutchpartd",
        costs = 1,
		},
		
		S = {
		label = "Ly hợp Hạng S",
        item = "clutchparts",
        costs = 1,
		}
    },
    ["injector"] = {
		A = {
		label = "Kim phun Hạng A",
        item = "fuelinjectora",
        costs = 1,
		},
		
		B = {
		label = "Kim phun Hạng B",
        item = "fuelinjectorb",
        costs = 1,
		},
		
		C = {
		label = "Kim phun Hạng C",
        item = "fuelinjectorc",
        costs = 1,
		},
		
		D = {
		label = "Kim phun Hạng D",
        item = "fuelinjectord",
        costs = 1,
		},
		
		S = {
		label = "Kim phun Hạng S",
        item = "fuelinjectors",
        costs = 1,
		}
    },
	
	["tire"] = {
		A = {
		label = "Bánh xe Hạng A",
        item = "tirekita",
        costs = 1,
		},
		
		B = {
		label = "Bánh xe Hạng B",
        item = "tirekitb",
        costs = 1,
		},
		
		C = {
		label = "Bánh xe Hạng C",
        item = "tirekitc",
        costs = 1,
		},
		
		D = {
		label = "Bánh xe Hạng D",
        item = "tirekitd",
        costs = 1,
		},
		
		S = {
		label = "Bánh xe Hạng S",
        item = "tirekits",
        costs = 1,
		}
		
    },
	
	
	["electronics"] = {
		A = {
		label = "Thiết bị điển tự Hạng A",
        item = "electronicparta",
        costs = 1,
		},
		
		B = {
		label = "Thiết bị điển tự Hạng B",
        item = "electronicpartb",
        costs = 1,
		},
		
		C = {
		label = "Thiết bị điển tự Hạng C",
        item = "electronicpartc",
        costs = 1,
		},
		
		D = {
		label = "Thiết bị điển tự Hạng D",
        item = "electronicpartd",
        costs = 1,
		},
		
		S = {
		label = "Thiết bị điển tự Hạng S",
        item = "electronicparts",
        costs = 1,
		}
		
    },
	
	["transmission"] = {
		A = {
		label = "Hộp số Hạng A",
        item = "transmissionparta",
        costs = 1,
		},
		
		B = {
		label = "Hộp số Hạng B",
        item = "transmissionpartb",
        costs = 1,
		},
		
		C = {
		label = "Hộp số Hạng C",
        item = "transmissionpartc",
        costs = 1,
		},
		
		D = {
		label = "Hộp số Hạng D",
        item = "transmissionpartd",
        costs = 1,
		},
		
		S = {
		label = "Hộp số Hạng S",
        item = "transmissionparts",
        costs = 1,
		}
		
    },
}

Config.Businesses = {
    "Auto Repair",
}

Config.Plates = {
    [1] = {
        coords = {x = 548.59448, y = -198.6144, z = 54.069728, h = 180.90824, r = 1.0},
        AttachedVehicle = nil,
    },
    [2] = {
        coords = {x = 541.38464, y = -189.2236, z = 54.069728, h = 90.910232, r = 1.0}, 
        AttachedVehicle = nil,
    },
    [3] = {
        coords = {x = 541.76208, y = -179.0891, z = 54.069728, h = 90.912063, r = 1.0}, 
        AttachedVehicle = nil,
    },
}


Config.Locations = {
    --[[ ["exit"] = {x = 945.13, y = -975.84, z = 39.49, h = 181.5, r = 1.0}, ]]
    ["blip"] = {x = 545.58117, y = -185.6654, z = 54.477371, h = 6.1376714, r = 1.0},
    ["craft"] = {x = 546.38812, y = -166.7559, z = 54.493217, h = 6.1376714, r = 1.0},
    ["stash"] = {x = 549.289, y = -168.8657, z = 54.493202, h = 303.12374, r = 1.0},
	["duty"] = {x = 550.24755, y = -182.2433, z = 54.493213, h = 356.65, r = 1.0},
    ["vehicle"] = {x = 542.17059, y = -208.7623, z = 53.803546, h = 178.25463, r = 1.0}, 
	["boss"] = {x = 544.07586, y = -200.2357, z = 54.493202, h = 137.32397, r = 1.0},
}

Config.Vehicles = {
    ["flatbed"] = "Flatbed",
    ["towtruck"] = "Towtruck"
}

Config.MinimalMetersForDamage = {
    [1] = {
        min = 30,
        max = 90,
        multiplier = {
            min = 1,
            max = 8,
        }
    },
    [2] = {
        min = 90,
        max = 140,
        multiplier = {
            min = 8,
            max = 16,
        }
    },
    [3] = {
        min = 140,
        max = 170,
        multiplier = {
            min = 16,
            max = 24,
        }
    },
	[4] = {
        min = 100,
        max = 120,
        multiplier = {
            min = 50,
            max = 70,
        }
    },
	[5] = {
        min = 120,
        max = 200,
        multiplier = {
            min = 50,
            max = 70,
        }
    },
}

Config.Damages = {
    ["radiator"] = "Radiator",
    ["axle"] = "Drive Shaft",
    ["brakes"] = "Brakes",
    ["clutch"] = "Clutch",
    ["fuelinjector"] = "Fuel Tank",
	["tire"] = "Tire",
	["electronic"] = "Electornic",
	["transmission"] = "Rransmission",
}