let itemList	= {}

// weapons

// Flamethrower
itemList['728397530'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower',
  price: 0,
  craft: [[
    { itemid: 'aluminium', amount: 10 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  weight: 35,
  nonStack: true,
  model: '',
  image: 'np_flamethrower.png',
  weapon: true,
};

itemList['pdevidencebag'] = {
  fullyDegrades: false,
  decayrate: 0,
  displayname: 'Evidence Bag',
  price: 10,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_evidence_bag.png',
};


itemList['detcord'] = {
  fullyDegrades: true,
  decayrate: 0.001385,
  displayname: 'Det. Cord',
  price: 50,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_detcord.png',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

itemList['agenericmechanicpart'] = {
  decayrate: 1.0,
  displayname: 'Mechanical Part (A)',
  price: 0,
  weight: 0,
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_generic_mechanical_A.png',
  craft: [
    [{ itemid: 'aluminium', amount: 3 }],
    [{ itemid: 'refinedaluminium', amount: 1 }],
    [{ itemid: 'copper', amount: 3 },
    { itemid: 'refinedcopper', amount: 1 }],
    [{ itemid: 'plastic', amount: 3 }],
    [{ itemid: 'refinedplastic', amount: 1 }],
    [{ itemid: 'rubber', amount: 3 }],
    [{ itemid: 'refinedrubber', amount: 1 }],
    [{ itemid: 'steel', amount: 3 }],
    [{ itemid: 'refinedsteel', amount: 1 }],
    [{ itemid: 'scrapmetal', amount: 3 }],
    [{ itemid: 'refinedscrap', amount: 1 }],
    [{ itemid: 'glass', amount: 3 }],
    [{ itemid: 'refinedglass', amount: 1 }],
    [{ itemid: 'electronics', amount: 3 }],
  ],
  information: '',
};

itemList['mobilewatervendor'] = {
  fullyDegrades: true,
  decayrate: 0.001385,
  displayname: 'Mobile Water Vendor',
  price: 50,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_vending_soda_01.png',
  craft: [
    [
      { itemid: 'aluminium', amount: 125 },
      { itemid: 'steel', amount: 125 },
      { itemid: 'plastic', amount: 125 },
      { itemid: 'rubber', amount: 125 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 40 },
      { itemid: 'refinedsteel', amount: 40 },
      { itemid: 'refinedplastic', amount: 40 },
      { itemid: 'refinedrubber', amount: 40 },
    ],
	[
      { itemid: 'water', amount: 40 },
    ]
  ],
  information: 'Place it down anywhere and have a drink!',
};


itemList['refinedaluminium'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Aluminium",
  craft: [[
    { itemid: 'aluminium', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_aluminium.png',
  information: 'Refined Aluminium.',
};

itemList['refinedcopper'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Copper",
  craft: [[
    { itemid: 'copper', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_copper.png',
  information: 'Refined Copper.',
};

itemList['refinedglass'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Glass",
  craft: [[
    { itemid: 'glass', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_glass.png',
  information: 'Refined Glass.',
};

itemList['refinedplastic'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Plastic",
  craft: [[
    { itemid: 'plastic', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_plastic.png',
  information: 'Refined Plastic.',
};

itemList['refinedrubber'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Rubber",
  craft: [[
    { itemid: 'rubber', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_rubber.png',
  information: 'Refined Rubber.',
};

itemList['refinedscrap'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Scrap",
  craft: [[
    { itemid: 'scrapmetal', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_scrap.png',
  information: 'Refined Scrap.',
};

itemList['refinedsteel'] = {
  fullyDegrades: true,
  decayrate: 2.0,
  displayname: "Refined Steel",
  craft: [[
    { itemid: 'steel', amount: 3 },
  ]],
  price: 1,
  weight: 0.0,
  nonStack: false,
  model: '',
  image: 'np_refined_steel.png',
  information: 'Refined Steel.',
};

itemList['flamethrowerammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Flamethrower Canister',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_flamethrower_ammo.png',
};



itemList['flamethrowerpart1'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part1.png',
};

itemList['flamethrowerpart2'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part2.png',
};

itemList['flamethrowerpart3'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part3.png',
};

itemList['flamethrowerpart4'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part4.png',
};

itemList['flamethrowerpart5'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part5.png',
};

itemList['flamethrowerpart6'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Flamethrower Part',
  craft: [[
    { itemid: 'aluminium', amount: 20 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 100,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_flamethrower_part6.png',
};

// Paintball Gun
itemList['-2009644972'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Paintball Gun',
  price: 0,
  craft: [[
    { itemid: 'aluminium', amount: 10 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_paintballgun.png',
  weapon: true,
};

// Paintball Gun
itemList['727643628'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Tranquilizer Gun',
  price: 0,
  craft: [[
    { itemid: 'aluminium', amount: 10 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_tranq.png',
  weapon: true,
};

// Rail Gun
itemList['1834241177'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'EMP Gun',
  price: 1000,
  weight: 51,
  nonStack: true,
  model: '',
  image: 'np_empgun.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};

itemList['1064738331'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Brick',
  craft: [[
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 250,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_brick.png',
  weapon: true,
};

itemList['-691061592'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Book',
  craft: [[
    { itemid: 'rollingpaper', amount: 10 },
  ]],
  price: 250,
  weight: 2,
  nonStack: false,
  model: '',
  image: 'np_book_w.png',
  weapon: true,
};

itemList['571920712'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cash',
  price: 100,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_cash.png',
  weapon: true,
};

itemList['-828058162'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Stolen Shoes',
  price: 1,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_stolenshoes.png',
  information: 'These are not yours, bro.',
};

itemList['-1953168119'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Staff of Regeneration',
  price: 1,
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_staff01.png',
  information: 'Is that a big staff in your pocket or are you just happy to see me?',
};

itemList['-1024456158'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Bat',
  craft: [[
    { itemid: 'refinedaluminium', amount: 25 },
    { itemid: 'refinedrubber', amount: 25 },
  ]],
  price: 250,
  weight: 14,
  nonStack: true,
  model: '',
  image: 'np_baseball-bat.png',
  weapon: true,
  contraband: true,
};

// weapon_ltl
itemList['218362403'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Rubber Slug Shotgun',
  price: 10,
  weight: 25,
  craft: [[
    { itemid: 'aluminium', amount: 70 },
    { itemid: 'steel', amount: 70 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_lessthanlethal.png',
  weapon: true,
  information: 'PD and DOC Issued LTL Weapon',
};


itemList['rubberslugpd'] = {
  fullyDegrades: true,
  decayrate: 0.002,
  displayname: 'Rubber Slug Shotgun (Short Life)',
  price: 10,
  weight: 25,
  craft: [[
    { itemid: 'aluminium', amount: 70 },
    { itemid: 'steel', amount: 70 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_lessthanlethal.png',
  weapon: true,
  information: 'PD and DOC Issued LTL Weapon',
};

itemList['vineyardbarrel'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Grape Barrel',
  price: 1000,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_grape_barrel.png',
  information: "Throw your grapes in here.",
};

itemList['784503678'] = {
  _name: '784503678',
  fullyDegrades: false,
  decayrate: 0,
  displayname: 'Karambit',
  craft: [[
    { itemid: 'bclubtoken', amount: 10 },
  ]],
  price: 250,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_karambit.png',
  weapon: true,
  contraband: false,
};

// weapon_shiv
itemList['-262696221'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Prison Shiv',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'scrapmetal', amount: 1 },
  ]],
  price: 250,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_shiv.png',
  weapon: true,
  contraband: true,
};

// weapon_pistol

// weapon_browning
itemList['148457251'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Browning Hi-Power',
  price: 250,
  weight: 6,
  craft: [
    [
      { itemid: 'aluminium', amount: 15 },
      { itemid: 'steel', amount: 15 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 5 },
      { itemid: 'refinedsteel', amount: 5 },
    ]
  ],
  nonStack: true,
  model: '',
  image: 'np_browning.png',
  weapon: true,
};

// weapon_dp9 (it's called dp9, just rock with it)
itemList['-2012211169'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Diamondback DB9',
  price: 250,
  weight: 6,
  craft: [
    [
      { itemid: 'aluminium', amount: 15 },
      { itemid: 'steel', amount: 15 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 5 },
      { itemid: 'refinedsteel', amount: 5 },
    ]
  ],
  nonStack: true,
  model: '',
  image: 'np_DB9.png',
  weapon: true,
};

itemList['-1746263880'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Colt Python',
  price: 250,
  weight: 11,
  craft: [
    [
      { itemid: 'aluminium', amount: 150 },
      { itemid: 'plastic', amount: 150 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 45 },
      { itemid: 'refinedplastic', amount: 45 },
    ],
  ],
  nonStack: true,
  model: '',
  image: 'np_colt.png',
  weapon: true,
};


// weapon_xxxxxx
itemList['453432689'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'colt 1911',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 6,
  nonStack: true,
  model: '',
  image: 'np_pistol.png',
  weapon: true,
};

// weapon_pistol_mk2
itemList['-1075685676'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Beretta M9',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_pistol2.png',
  weapon: true,
};

// weapon_combatpistol
itemList['1593441988'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'FN FNX-45',
  price: 250,
  craft: [[
    { itemid: 'steel', amount: 65 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 5,
  nonStack: true,
  blockScrap: true,
  model: '',
  image: 'np_combat-pistol.png',
  weapon: true,
};

// weapon_heavypistol
itemList['-771403250'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Entreprise Wide Body 1911a',
  price: 250,
  craft: [[
    { itemid: 'steel', amount: 65 },
    { itemid: 'plastic', amount: 65 },
    { itemid: 'rubber', amount: 65 },
  ]],
  weight: 7,
  nonStack: true,
  blockScrap: true,
  model: '',
  image: 'np_heavy-pistol.png',
  weapon: true,
};


// weapon_taser
itemList['-820634585'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'PD Taser',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_stun-gun.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};


// weapon_pistol50
itemList['-1716589765'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Desert Eagle',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 130 },
      { itemid: 'plastic', amount: 130 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 43 },
      { itemid: 'refinedplastic', amount: 43 },
    ],
  ],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_pistol-50.png',
  weapon: true,
};

// weapon_microsmg3
itemList['-134995899'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Mac-10',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 30 },
      { itemid: 'plastic', amount: 60 },
      { itemid: 'rubber', amount: 30 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedplastic', amount: 20 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_micro-smg.png',
  weapon: true,
};

// weapon_microsmg2
itemList['-942620673'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Uzi',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 30 },
      { itemid: 'plastic', amount: 60 },
      { itemid: 'rubber', amount: 30 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 10 },
      { itemid: 'refinedplastic', amount: 20 },
      { itemid: 'refinedrubber', amount: 10 },
    ]
  ],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_micro-smg2.png',
  weapon: true,
};

itemList["-1121678507"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Skorpion Mk2", price: 250, weight: 11, craft: [ {itemid: "aluminium", amount: 100 }, {itemid: "steel", amount: 100 } ], nonStack: true, model: "", image: "np_mini-smg.png", weapon: true , deg: true}
itemList["-1045183535"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Revolver", price: 250, weight: 11, craft: [ {itemid: "scrapmetal", amount: 150 } ], nonStack: true, model: "", image: "np_revolver.png", weapon: true , deg: false}

itemList["-879347409"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Violence", price: 250, weight: 11, craft: [ {itemid: "aluminium", amount: 70 }, {itemid: "steel", amount: 70 } ], nonStack: true, model: "", image: "np_revolvermk2.png", weapon: true , deg: false}

itemList["-1746263880"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Colt M1892", price: 250, weight: 11, craft: [ {itemid: "aluminium", amount: 70 }, {itemid: "steel", amount: 70 } ], nonStack: true, model: "", image: "np_marston-revolver.png", weapon: true , deg: false}
// Parachute

// Parachute
itemList['-72657034'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Parachute',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  weight: 30,
  nonStack: true,
  model: '',
  image: 'np_parachute.png',
  weapon: false,
};


itemList['airxchute'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Parachute',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 500 },
    { itemid: 'plastic', amount: 1500 },
    { itemid: 'rubber', amount: 2500 },
  ]],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_parachute.png',
  weapon: false,
};
itemList['navychute'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Parachute',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 500 },
    { itemid: 'plastic', amount: 1500 },
    { itemid: 'rubber', amount: 2500 },
  ]],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_parachute.png',
  weapon: false,
};

itemList['airbornechute'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Parachute',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 500 },
    { itemid: 'plastic', amount: 1500 },
    { itemid: 'rubber', amount: 2500 },
  ]],
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_parachute.png',
  weapon: false,
};

// weapon_assaultrifle
itemList['-1074790547'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'AK 47',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_assault-rifle.png',
  weapon: true,
};

itemList["-1075685676"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "9mm Pistol", price: 10, craft: [ {itemid: "copper", amount: 50 }, {itemid: "glass", amount: 80 }, {itemid: "steel", amount: 10 } ], weight: 11, nonStack: true, model: "", image: "np_pistol.png", weapon: true , deg: true} //'Pistol'

// koil gun
itemList['-1355376991'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'koils gun :) hehe ',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 155 },
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 0,
  nonStack: true,
  model: '',
  image: 'np_pistol-50.png',
  weapon: true,
};
// weapon_advancedrifle
itemList['-1357824103'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'OTs-14 Groza',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_groza.png',
  weapon: true,
};

// weapon_assaultrifle2
itemList['497969164'] = {
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'M70',
  price: 250,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_m70.png',
  weapon: true,
};

// weapon_dbshotgun
itemList['-275439685'] = {
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'Sawn-off Shotgun',
  price: 250,
  craft: [
    [
      { itemid: 'steel', amount: 200 },
      { itemid: 'copper', amount: 100 },
      { itemid: 'scrapmetal', amount: 100 },
    ],
    [
      { itemid: 'refinedsteel', amount: 50 },
      { itemid: 'refinedcopper', amount: 25 },
      { itemid: 'refinedscrap', amount: 25 },
    ]
  ],
  weight: 14,
  nonStack: true,
  model: '',
  image: 'np_db-shotgun.png',
  weapon: true,
};

// sharp weapons

itemList['-1239161099'] = {
  fullyDegrades: false,
  decayrate: 5.0,
  displayname: 'Katana',
  price: 1,
  craft: [[
    { itemid: 'refinedsteel', amount: 650 },
  ]],
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_katana.png',
  information: 'When you were partying, I studied the blade.',
  weapon: true,
  contraband: true,
};

itemList['1692590063'] = {
  fullyDegrades: false,
  decayrate: 5.0,
  displayname: 'Katana',
  price: 1,
  craft: [[
    { itemid: 'refinedsteel', amount: 650 },
    { itemid: 'refinedaluminium', amount: 250 },
  ]],
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_katana.png',
  information: 'When you were partying, I studied the blade.',
  weapon: true,
  contraband: true,
};

itemList['cursedkatanaweapon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Cursed Katana',
  price: 1,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_cursed-katana.png',
  information: 'Infused with the blood of a Dragon; a normal human mind cannot control such power.',
  weapon: true,
  contraband: true,
};

itemList['talonweapon'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Talon Sword',
  price: 1,
  weight: 5,
  nonStack: true,
  model: '',
  image: 'np_talonsword.png',
  information: 'We are everywhere, we are everyone, fear us for we lurk in the shadows. We are Talon.',
  weapon: false,
  contraband: true,
};

itemList['heistduffelbag'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Duffel Bag',
  price: 350,
  weight: 11,
  nonStack: false,
  model: '',
  image: 'np_duffel.png',
  whitelist: [
    "heist_loot"
  ],
  information: 'Can hold a considerable amount of cash. Marked for Police Seizure. <br><br><i>"We are just supposed to walk out of there with millions of dollars in cash on us without getting stopped?"</i>',
};

itemList['-538741184'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Shank',
  craft: [[
    { itemid: 'steel', amount: 25 },
    { itemid: 'aluminium', amount: 100 },
  ]],
  price: 250,
  weight: 3,
  nonStack: true,
  model: '',
  image: 'np_switchblade.png',
  weapon: true,
};

itemList["-1654528753"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "BP Shotgun Mk2", price: 250, craft: [ {itemid: "aluminium", amount: 80 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_assault-shotgun.png", weapon: true, deg: true} //'Bullpup Shotgun'
itemList["-1810795771"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Pool Cue", price: 0, weight: 150, nonStack: true, model: "", image: "np_poolcue.png", weapon: true, information: "-5 Jail <br> +3 Strength <br> -3 Intelligence <br> Its marked -DO NOT TAKE FROM CELLS- <br> Outside Jail this is considered Police Property <br> If it has roleplay stats, it must be roleplay.", deg: true } //'Heavy Shotgun'
itemList["-2066285827"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "BP Rifle Mk2", price: 250, craft: [ {itemid: "riflebody", amount: 1 },{itemid: "aluminium", amount: 80 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_bullpup-rifle.png", weapon: true, deg: true} //'Bullpup Rifle'
itemList["-2084633992"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "PD 556", price: 10, craft: [{itemid: "aluminium", amount: 50 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 1 }], weight: 11, nonStack: true, model: "", image: "np_carbine-rifle.png", weapon: true , deg: true} //'Carbine Rifle'
itemList["-270015777"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "ASMG Mk2", price: 250, craft: [ {itemid: "aluminium", amount: 155 }, {itemid: "plastic", amount: 100 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_assault-smg.png", weapon: true, deg: true} //'Assault SMG'
itemList["-538741184"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Shank", craft: [ {itemid: "methbag", amount: 25 }, {itemid: "ciggy", amount: 100 } ], price: 250, weight: 11, nonStack: true, model: "", image: "np_switchblade.png", weapon: true , deg: true}
itemList["-619010992"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Tec 9 Mk2", price: 250, weight: 11, craft: [ {itemid: "aluminium", amount: 50 }, {itemid: "plastic", amount: 20 } ], nonStack: true, model: "", image: "np_machine-pistol.png", weapon: true , deg: true}
itemList["-771403250"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Heavy Pistol", price: 250, craft: [ {itemid: "goldbar", amount: 7 } ], weight: 11, nonStack: true, model:  "", image: "np_heavy-pistol.png", weapon: true, deg: true}
itemList["-86904375"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "PD 762", price: 10, craft: [{itemid: "aluminium", amount: 50 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 1 }], weight: 11, nonStack: true, model: "", image: "np_762saltmaker.png", weapon: true , deg: true} //'Carbine Rifle Mk2'
// weapon_m24
itemList['100416529'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'm24',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_m24.png',
  weapon: true,
};
// weapon_g22
itemList['-1536150836'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'AWM',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_awm.png',
  weapon: true,
};

// weapon_mg
itemList['-1660422300'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'PK machine gun',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_pkm.png',
  weapon: true,
};

// weapon_dragunov
itemList['-90637530'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Dragunov',
  price: 500,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 43,
  nonStack: true,
  model: '',
  image: 'np_dragunov.png',
  weapon: true,
};

// Fire Extinguisher
itemList['101631238'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Fire Ext',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'scrapmetal', amount: 40 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_fire-extinguisher.png',
  weapon: true,
};

itemList['-1786099057'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Model M Keyboard',
  price: 250,
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_keyboard.png',
  weapon: true,
};

itemList["1141786504"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Golfclub", price: 250, weight: 11, nonStack: true, model: "", image: "np_golfclub.png", weapon: true , deg: false}
itemList["1198879012"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Flaregun", price: 250, weight: 11, nonStack: true, model: "", image: "np_flaregun.png", weapon: true , deg: false}
itemList['1233104067'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Flare',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 350 },
    { itemid: 'scrapmetal', amount: 350 },
    { itemid: 'rubber', amount: 300 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_flare.png',
  information: '',
  weapon: true,
  contraband: true,
};
itemList['-1600701090'] = {
  fullyDegrades: false,
  decayrate: 0.5,
  displayname: 'M67 grenade',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 110 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'rubber', amount: 100 },
  ], [
    { itemid: 'refinedaluminium', amount: 35 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'refinedrubber', amount: 35 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_grenade.png',
  information: '',
  weapon: true,
  contraband: true,
};

itemList['-37975472'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Smoke Grenade',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 150 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'rubber', amount: 150 },
  ], [
    { itemid: 'refinedaluminium', amount: 45 },
    { itemid: 'refinedscrap', amount: 45 },
    { itemid: 'refinedrubber', amount: 45 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_stungrenade.png',
  information: '',
  weapon: true,
  contraband: true,
};

itemList['smokegrenadeswat'] = {
  fullyDegrades: false,
  decayrate: 0.01,
  displayname: 'Smoke Grenade (SWAT)',
  price: 100,
  weight: 25,
  craft: [[
    { itemid: 'aluminium', amount: 150 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'rubber', amount: 150 },
  ], [
    { itemid: 'refinedaluminium', amount: 45 },
    { itemid: 'refinedscrap', amount: 45 },
    { itemid: 'refinedrubber', amount: 45 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_stungrenade.png',
  information: 'Mil-Spec. High price, low quality. If you are not SWAT certified do not buy this.',
  contraband: true,
};

itemList['smokegrenadenpa'] = {
  fullyDegrades: false,
  decayrate: 0.01,
  displayname: 'Smoke Grenade',
  price: 100,
  weight: 25,
  craft: [[
    { itemid: 'aluminium', amount: 150 },
    { itemid: 'scrapmetal', amount: 150 },
    { itemid: 'rubber', amount: 150 },
  ], [
    { itemid: 'refinedaluminium', amount: 45 },
    { itemid: 'refinedscrap', amount: 45 },
    { itemid: 'refinedrubber', amount: 45 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_stungrenade.png',
  information: 'NPA Edition.',
  contraband: true,
};

// Pipebomb pipe bomb
itemList['-1169823560'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Pipebomb',
  price: 250,
  weight: 7,
  craft: [[
    { itemid: 'aluminium', amount: 310 },
    { itemid: 'scrapmetal', amount: 350 },
    { itemid: 'rubber', amount: 300 },
  ], [
    { itemid: 'refinedaluminium', amount: 100 },
    { itemid: 'refinedscrap', amount: 100 },
    { itemid: 'refinedrubber', amount: 100 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_pipe-bomb.png',
  weapon: true,
  contraband: true,
};


itemList["125959754"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Cmp Launcher", price: 250, weight: 11, nonStack: true, model: "", image: "np_cmp-launcher.png", weapon: true , deg: true}
itemList["126349499"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Snowball", price: 250, weight: 11, nonStack: true, model: "", image: "np_snowball.png", weapon: true , deg: false}
itemList["1305664598"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "GND Launcher SMK", price: 250, weight: 11, nonStack: true, model: "", image: "np_grenade-launcher.png", weapon: true , deg: false}
itemList["1317494643"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Hammer", price: 250, weight: 11, nonStack: true, model: "", image: "np_hammer.png", weapon: true , deg: false}
itemList["137902532"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Vintage Pistol", price: 250,  craft: [ {itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 } ], weight: 11, nonStack: true, model:  "", image: "np_vintage-pistol.png", weapon: true , deg: true} //'Vintage Pistol'
// weapon_pumpshotgun_mk2
itemList['1432025498'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Remington 870',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 21,
  nonStack: true,
  model: '',
  image: 'np_remington.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};
itemList["1593441988"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Combat Pistol", price: 250,  craft: [ {itemid: "steel", amount: 65 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 } ], weight: 11, nonStack: true, model:  "", image: "np_combat-pistol.png", weapon: true , deg: true} //'Combat Pistol'
itemList["1627465347"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Gusenberg Mk2", price: 250, craft: [ {itemid: "aluminium", amount: 55 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_gusenberg.png", weapon: true, deg: true} //'Gusenberg'
// WEAPON_COMPACTRIFLE
itemList['1649403952'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Draco NAK9',
  price: 10,
  craft: [
    [
      { itemid: 'aluminium', amount: 300 },
      { itemid: 'steel', amount: 300 },
      { itemid: 'rubber', amount: 300 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 70 },
      { itemid: 'refinedsteel', amount: 70 },
      { itemid: 'refinedrubber', amount: 70 },
    ]
  ],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_draco.png',
  weapon: true,
};
itemList["1672152130"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Homing Launcher", price: 250, weight: 11, nonStack: true, model: "", image: "np_homing-launcher.png", weapon: true , deg: true}
// WEAPON_COMBATPDW
itemList['171789620'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'SIG MPX',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_mpx.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment',
};
// weapon_gepard used to apply skin and still generate data for the weapon
itemList['-1518444656'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Gepard',
  price: 10,
  craft: [
    [
      { itemid: 'aluminium', amount: 300 },
      { itemid: 'steel', amount: 300 },
      { itemid: 'rubber', amount: 300 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 70 },
      { itemid: 'refinedsteel', amount: 70 },
      { itemid: 'refinedrubber', amount: 70 },
    ]
  ],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_gepard.png',
  weapon: true,
};
//WEAPON_MINISMG2
itemList['-1472189665'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Skorpion',
  price: 10,
  craft: [
    [
      { itemid: 'aluminium', amount: 100 },
      { itemid: 'steel', amount: 100 },
      { itemid: 'rubber', amount: 100 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 20 },
      { itemid: 'refinedsteel', amount: 20 },
      { itemid: 'refinedrubber', amount: 20 },
    ]
  ],
  weight: 7,
  nonStack: true,
  model: '',
  image: 'np_skorpion.png',
  weapon: true,
};

// explosive type shit

itemList['-1813897027'] = {
  fullyDegrades: false,
  decayrate: 0.01,
  displayname: 'Stun Grenade (SWAT)',
  price: 100,
  weight: 5,
  craft: [[
    { itemid: 'aluminium', amount: 350 },
    { itemid: 'scrapmetal', amount: 350 },
    { itemid: 'rubber', amount: 300 },
  ]],
  nonStack: true,
  model: '',
  image: 'np_stungrenade.png',
  information: 'So police can breach a building without feeling like a ______! If you are not SWAT certified do not buy this.',
  weapon: true,
  contraband: true,
};

itemList['600439132'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'Lime',
  craft: [[
    { itemid: 'refinedaluminium', amount: 25 },
    { itemid: 'refinedrubber', amount: 25 },
  ]],
  price: 250,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_lime.png',
  weapon: true,
  contraband: true,
};

itemList['-2000187721'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Secure Briefcase',
  price: 250,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_securitycase.png',
  weapon: true,
  contraband: true,
};

itemList['28811031'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Briefcase',
  price: 250,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_suitcase.png',
  weapon: true,
  contraband: true,
};



itemList["1737195953"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Dùi cui", price: 0, weight: 11, nonStack: true, model: "", image: "np_nightstick.png", weapon: true , deg: false}
itemList["2017895192"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Sawnoff", price: 250, craft: [ {itemid: "steel", amount: 50 }, {itemid: "aluminium", amount: 30 } ], weight: 11, nonStack: true, model:  "", image: "np_sawnoff-shotgun.png ", weapon: true, deg: true} //'Sawnoff Shotgun'
itemList["2024373456"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "PD MP5 2", price: 250, craft: [ {itemid: "aluminium", amount: 155 }, {itemid: "plastic", amount: 100 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_smg.png", weapon: true , deg: true} //'SMG'
itemList["2132975508"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Bullpup Rifle", price: 250, craft: [ {itemid: "riflebody", amount: 1 },{itemid: "aluminium", amount: 80 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_bullpup-rifle.png", weapon: true, deg: true} //'Bullpup Rifle'
itemList["2138347493"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Firework Launcher", price: 250, craft: [ {itemid: "aluminium", amount: 100 }, {itemid: "scrapmetal", amount: 40 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_firework-launcher.png", weapon: true, deg: true} //'Firework Launcher'
itemList["2144741730"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Combat MG Mk2", price: 250, craft: [ {itemid: "aluminium", amount: 90 }, {itemid: "scrapmetal", amount: 40 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_mg.png", weapon: true, deg: true} //'Combat MG'
itemList["2210333304"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "PD 556 Rifle", price: 10, craft: [{itemid: "riflebody", amount: 1 }, {itemid: "aluminium", amount: 50 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 1 }], weight: 11, nonStack: true, model: "", image: "np_carbine-rifle.png", weapon: true , deg: true} //'Carbine Rifle'
itemList["2227010557"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Crowbar", price: 250, weight: 11, craft: [ {itemid: "steel", amount: 300 }, {itemid: "goldbar", amount: 50 } ], nonStack: true, model: "", image: "np_crowbar.png", weapon: true , deg: false}
itemList["2343591895"]	= {fullyDegrades: true, decayrate: 0.7, displayname: "Đèn Pin", price: 250, weight: 11, nonStack: true, craft: [ {itemid: "scrapmetal", amount: 100 }, {itemid: "electronics", amount: 300 }, {itemid: "goldbar", amount: 50 }, {itemid: "rubber", amount: 50 } ] ,model: "", image: "np_flashlight.png", weapon: true , deg: false, esxuse: true}

itemList["-1951375401"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Đèn Pin", price: 250, weight: 11, nonStack: true, model: "", image: "np_flashlight.png", weapon: true , deg: false}
itemList["2460120199"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Dagger", price: 250, weight: 11, nonStack: true, model: "", image: "np_dagger.png", weapon: true , deg: false}
itemList["2484171525"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Cue", price: 250, weight: 11, nonStack: true, model: "", image: "np_pool-cue.png", weapon: true , deg: false}
itemList["2508868239"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Bat", craft: [ {itemid: "steel", amount: 300 } ], price: 250, weight: 11, nonStack: true, model: "", image: "np_baseball-bat.png", weapon: true , deg: false}
itemList["2578377531"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Pistol 50", price: 250, craft: [ {itemid: "aluminium", amount: 155 }, {itemid: "plastic", amount: 100 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_pistol-50.png", weapon: true, deg: true} //'Pistol 50'
itemList["2578778090"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Knife", price: 250, weight: 11, nonStack: true, model: "", image: "np_knife.png", weapon: true , deg: false}
itemList["2640438543"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Bullpup Shotgun", price: 250, craft: [ {itemid: "aluminium", amount: 80 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_assault-shotgun.png", weapon: true, deg: true} //'Bullpup Shotgun'
itemList["2726580491"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Grenade Launcher", price: 250, craft: [ {itemid: "aluminium", amount: 100 }, {itemid: "scrapmetal", amount: 40 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_grenade-launcher.png", weapon: true, deg: true}//"Grenade Launcher"
itemList["2828843422"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Musket", price: 250, weight: 11, nonStack: true, model: "", image: "np_musket.png", weapon: true , deg: true}
itemList["2874559379"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Proxi Mine", price: 250, weight: 11, nonStack: true, model: "", image: "np_proximity-mine.png", weapon: true , deg: false}
itemList["2937143193"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Advanced Rifle", price: 250, craft: [ {itemid: "riflebody", amount: 1 }, {itemid: "aluminium", amount: 140 }, {itemid: "scrapmetal", amount: 40 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_advanced-rifle.png", weapon: true, deg: true} //'Advanced Rifle'
itemList["2982836145"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "RPG", price: 250, craft: [ {itemid: "aluminium", amount: 100 }, {itemid: "scrapmetal", amount: 40 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_rpg.png", weapon: true, deg: true} //'RPG'
itemList["3125143736"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Pipebomb", price: 250, weight: 11, nonStack: true, model: "", image: "np_pipe-bomb.png", weapon: true , deg: false}
itemList["317205821"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Autoshotgun", price: 250, craft: [ {itemid: "aluminium", amount: 80 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_sweeper-shotgun.png", weapon: true, deg: true} //'Autoshotgun'
itemList["3173288789"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Skorpion", price: 250, weight: 11, craft: [ {itemid: "valuablegoods", amount: 1 }, {itemid: "goldbar", amount: 4 } ], nonStack: true, model: "", image: "np_mini-smg.png", weapon: true , deg: true}
itemList["3218215474"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "SNS Pistol", price: 250,  craft: [ {itemid: "scrapmetal", amount: 8 } ],  weight: 11, nonStack: true, model:  "", image: "np_sns-pistol.png", weapon: true, deg: true}
itemList["3219281620"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "PD Pistol", price: 100, craft: [{itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], weight: 11, nonStack: true, model: "", image: "np_pistol.png", weapon: true , deg: true} //'Pistol'
itemList["3220176749"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Assault Rifle", price: 250, craft: [ {itemid: "riflebody", amount: 1 }, {itemid: "aluminium", amount: 50 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_assault-shotgun.png", weapon: true, deg: true} //'Assault Rifle'
itemList['-1768145561'] = {
  fullyDegrades: false,
  decayrate: 0.75,
  displayname: 'FN SCAR-L',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_scar.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment - Subject to change',
}; //ScarL

// weapon_m14
itemList['-1719357158'] = {
  fullyDegrades: false,
  decayrate: 1.0,
  displayname: 'mk14',
  price: 550,
  craft: [
    [
      { itemid: 'aluminium', amount: 500 },
      { itemid: 'plastic', amount: 500 },
      { itemid: 'rubber', amount: 500 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 150 },
      { itemid: 'refinedplastic', amount: 150 },
      { itemid: 'refinedrubber', amount: 150 },
    ]
  ],
  weight: 43,
  nonStack: true,
  model: '',
  image: 'np_mk14.png',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  weapon: true,
};


itemList["3231910285"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Special Carbine", price: 250, weight: 11, nonStack: true, model: "", image: "np_special-carbine.png", weapon: true , deg: true}
itemList["324215364"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Micro SMG MK2", price: 250, craft: [ {itemid: "valuablegoods", amount: 1 }, {itemid: "goldbar", amount: 4 } ], weight: 11, nonStack: true, model:  "", image: "np_micro-smg.png", weapon: true, deg: true} //'Micro SMG'
itemList["3342088282"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Mark Rifle", price: 250, weight: 11, nonStack: true, model: "", image: "np_marksman-rifle.png", weapon: true , deg: true}
itemList["3441901897"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Metal Hatchet", price: 250, craft: [{itemid: "metal", amount: 4 }, {itemid: "stick", amount: 1 }, {itemid: "string", amount: 1 }], weight: 11, nonStack: true, model: "", image: "np_hatchet.png", weapon: true , deg: true} //'Heavy Shotgun'
itemList["3523564046"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Heavy Pistol", price: 250, craft: [ {itemid: "goldbar", amount: 7 } ], weight: 11, nonStack: true, model:  "", image: "np_heavy-pistol.png", weapon: true, deg: true}
itemList["3638508604"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Knuckle", craft: [ {itemid: "steel", amount: 250 }, {itemid: "scrapmetal", amount: 150 } ], price: 250, weight: 11, nonStack: true, model: "", image: "np_knuckle-dusters.png", weapon: true , deg: false}
itemList['knuckle_chain'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Chain Dusters',
  craft: [[
    { itemid: 'refinedscrap', amount: 20 },
    { itemid: 'refinedsteel', amount: 15 },
  ]],
  price: 250,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_chain_dusters.png',
  weapon: false,
  contraband: true,
};
itemList['gavel'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Gavel',
  price: 250,
  weight: 2,
  nonStack: true,
  model: '',
  image: 'np_gavel.png',
  weapon: false,
};

itemList["3675956304"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Tec 9", price: 250, weight: 11, craft: [ {itemid: "valuablegoods", amount: 1 }, {itemid: "goldbar", amount: 4 } ], nonStack: true, model: "", image: "np_machine-pistol.png", weapon: true , deg: true}
itemList["3696079510"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Mrk Pistol", price: 250, weight: 11, nonStack: true, model: "", image: "np_pistol.png", weapon: true , deg: true}
itemList["3713923289"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Machete", price: 250, weight: 11, craft: [ {itemid: "steel", amount: 300 }, {itemid: "goldbar", amount: 50 }, {itemid: "plastic", amount: 100 }, {itemid: "rubber", amount: 100 } ] ,nonStack: true, model: "", image: "np_machete.png", weapon: true , deg: false}
itemList["3800352039"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Assault Shotgun", price: 250, craft: [ {itemid: "aluminium", amount: 80 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_assault-shotgun.png", weapon: true, deg: true} //'Assault Shotgun'
itemList["4019527611"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "DB Shotgun", price: 250, weight: 11, nonStack: true, model: "", image: "np_db-shotgun.png", weapon: true , deg: true}
itemList["4024951519"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Assault SMG", price: 250, craft: [ {itemid: "aluminium", amount: 155 }, {itemid: "plastic", amount: 100 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_assault-smg.png", weapon: true, deg: true} //'Assault SMG'
itemList["4191993645"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Hatchet", price: 250, weight: 11, nonStack: true, model: "", image: "np_hatchet.png", weapon: true , deg: false}
itemList["4192643659"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Bottle", price: 250, weight: 11, nonStack: true, model: "", image: "np_glass-bottle.png", weapon: true , deg: false}
itemList["419712736"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Wrench", price: 250, weight: 11, nonStack: true, model: "", image: "np_wrench.png", weapon: true , deg: false}
itemList["453432689"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Colt 1911", price: 250, craft: [{itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], weight: 11, nonStack: true, model: "", image: "np_pistol.png", weapon: true , deg: true} //'Pistol'
// weapon_pumpshotgun
itemList['487013001'] = {
  fullyDegrades: false,
  decayrate: 3.0,
  displayname: 'IZh-81',
  price: 250,
  craft: [
    [
      { itemid: 'steel', amount: 150 },
      { itemid: 'copper', amount: 150 },
      { itemid: 'scrapmetal', amount: 150 },
    ],
    [
      { itemid: 'refinedsteel', amount: 30 },
      { itemid: 'refinedcopper', amount: 30 },
      { itemid: 'refinedscrap', amount: 30 },
    ]
  ],
  weight: 21,
  nonStack: true,
  model: '',
  image: 'np_izh81.png',
  weapon: true,
};
itemList["584646201"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "AP Pistol", price: 250, craft: [ {itemid: "valuablegoods", amount: 1 }, {itemid: "goldbar", amount: 1 } ], weight: 11, nonStack: true, model:  "", image: "np_ap-pistol.png", weapon: true, deg: true} //'AP Pistol'
// Molotov (Molly)
itemList['615608432'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Molly',
  craft: [
    [
      { itemid: 'aluminium', amount: 75 },
      { itemid: 'whiskey', amount: 3 },
    ],
    [
      { itemid: 'refinedaluminium', amount: 12 },
      { itemid: 'whiskey', amount: 3 },
    ]
  ],
  price: 250,
  weight: 35,
  nonStack: false,
  model: '',
  image: 'np_molotov.png',
  weapon: true,
  contraband: true,
};
itemList["736523883"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "PD MP5", price: 250, craft: [ {itemid: "aluminium", amount: 155 }, {itemid: "plastic", amount: 100 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_smg.png", weapon: true , deg: true} //'SMG'

itemList['1192676223'] = {
  fullyDegrades: false,
  decayrate: 0.75,
  displayname: 'M4',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 50 },
    { itemid: 'plastic', amount: 10 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_m4.png',
  weapon: true,
  information: 'Government (PD/EMS/DOC) Issued Equipment', //M4
};

// Sticky Bomb C4
itemList['741814745'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Sticky Bomb',
  price: 250,
  craft: [[
    { itemid: 'aluminium', amount: 1250 },
    { itemid: 'scrapmetal', amount: 1250 },
    { itemid: 'rubber', amount: 1250 },
  ], [
    { itemid: 'refinedaluminium', amount: 415 },
    { itemid: 'scrapmetal', amount: 1250 },
    { itemid: 'refinedrubber', amount: 415 },
  ]],
  weight: 22,
  nonStack: true,
  model: '',
  image: 'np_sticky-bomb.png',
  weapon: true,
  contraband: true,
};
// Petrol can
itemList['883325847'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Petrol Can',
  price: 250,
  weight: 50,
  nonStack: true,
  model: '',
  image: 'np_petrol-can.png',
  weapon: true,
};
// blunt weapons
//WEAPON_SLEDGEHAM
itemList['1923739240'] = {
  fullyDegrades: false,
  decayrate: 2.0,
  displayname: 'Sledge Hammer',
  craft: [
    [
      { itemid: 'steel', amount: 75 },
      { itemid: 'scrapmetal', amount: 75 },
    ],
    [
      { itemid: 'refinedsteel', amount: 25 },
      { itemid: 'refinedscrap', amount: 25 },
    ],
  ],
  price: 1,
  weight: 25,
  nonStack: true,
  model: '',
  image: 'np_sledgehammer.png',
  information: 'Big and girthy.',
  weapon: true,
  contraband: true,
};

itemList["911657153"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Súng điện", price: 250,  craft: [ {itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 } ], weight: 11, nonStack: true, model:  "", image: "np_stun-gun.png", weapon: true , deg: false} //'Stun Gun'
itemList["940833800"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Homemade Weapon", price: 250, craft: [{itemid: "stick", amount: 1 }, {itemid: "string", amount: 1 }], weight: 11, nonStack: true, model: "", image: "np_homemade.png", weapon: true , deg: true} //'Heavy Shotgun'
itemList["984333226"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Heavy SG", price: 250, craft: [ {itemid: "aluminium", amount: 80 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_heavy-shotgun.png", weapon: true, deg: true} //'Heavy Shotgun'

itemList["extended_ap"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "Ext AP Mag", price: 250, craft: [ {itemid: "aluminium", amount: 30 }, {itemid: "goldbar", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_ap-pistol-clip.png", deg: false} //'Heavy Sniper'
itemList["extended_micro"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "Ext Micro Mag", price: 210, craft: [ {itemid: "copper", amount: 40 }, {itemid: "goldbar", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_micro-smg-clip.png", deg: false} //'Heavy Sniper'
itemList["extended_sns"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "Ext SNS Mag", price: 250, craft: [ {itemid: "scrapmetal", amount: 6 } ],  weight: 11, nonStack: true, model:  "", image: "np_sns-pistol-clip.png", deg: false} //'Heavy Sniper',
itemList["extended_tec9"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "Ext Tec 9 Mag", price: 250, craft: [ {itemid: "copper", amount: 60 }, {itemid: "goldbar", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_micro-smg-clip.png", deg: false} //'Heavy Sniper'

itemList["silencer_l"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "L Silencer", price: 510, craft: [ {itemid: "goldbar", amount: 3 }, {itemid: "aluminium", amount: 10 }, {itemid: "goldbar", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_lsilencer.png", deg: false} //'Heavy Sniper'
itemList["silencer_l2"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "L Silencer MkII", price: 510, craft: [ {itemid: "goldbar", amount: 3 }, {itemid: "copper", amount: 10 }, {itemid: "goldbar", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_lsilencer.png", deg: false} //'Heavy Sniper'
itemList["silencer_s"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "S Silencer", price: 510, craft: [ {itemid: "goldbar", amount: 3 }, {itemid: "copper", amount: 20 }, {itemid: "goldbar", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_ssilencer.png", deg: false} //'Heavy Sniper'
itemList["silencer_s2"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "S Silencer MKII", price: 510, craft: [ {itemid: "goldbar", amount: 3 }, {itemid: "scrapmetal", amount: 20 }, {itemid: "goldbar", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_ssilencer.png", deg: false} //'Heavy Sniper'

itemList["SmallScope"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "2x Medium Scope", price: 550, craft: [ {itemid: "goldbar", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_sscope.png", deg: false} //'Heavy Sniper'

itemList["sniperammo"]	= {fullyDegrades: true, decayrate: 1.0, displayname: "Sniper Ammo x5", craft: [{itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_rifle-ammo.png" , deg: false}

itemList["subammo"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Sub Ammo x50", craft: [{itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 100, weight: 5, nonStack: false, model: "", image: "np_sub-ammo.png" , deg: false}

itemList['nails'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Nails',
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_nails.png',
};

itemList['paintballs'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Paintballs',
  craft: [[
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 3,
  nonStack: false,
  model: '',
  image: 'np_paintball_ammo.png',
};

itemList['rubberslugs'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: '12-Gauge Rubber Slugs',
  craft: [[
    { itemid: 'rubber', amount: 1 },
  ]],
  price: 10,
  weight: 3,
  nonStack: false,
  model: '',
  information: 'Government (PD/EMS/DOC) Issued Equipment',
  image: 'np_rubberslugs.png',
};

// weapon_rayminigun
itemList['-1238556825'] = {
  fullyDegrades: false,
  decayrate: 1,
  displayname: 'Widowmaker',
  price: 1000,
  craft: [],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_rayminigun.png',
  weapon: true,
};

itemList['widowmakerammo'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Widow Maker Ammo',
  price: 100,
  weight: 7,
  nonStack: false,
  model: '',
  image: 'np_223ammo.png',
};

itemList["TinyScope"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "2x S Scope", price: 550, craft: [ {itemid: "goldbar", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_tscope.png", deg: false} //'Heavy Sniper'


itemList["heavyammo"]	= {fullyDegrades: true, decayrate: 1.0, displayname: "Heavy Ammo x50", craft: [{itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_rifle-ammo.png" , deg: false}

// LMG ammo is not actually being used for anything and has no "use function". It's the same as Heavy Ammo.
itemList["lmgammo"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "LMG Ammo x50", craft: [{itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 300, weight: 5, nonStack: false, model: "", image: "np_lmg-ammo.png" , deg: false}

itemList["shotgunammo"]	= {fullyDegrades: true, decayrate: 1.0, displayname: "SG Ammo x50", craft: [{itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_shotgun-ammo.png" , deg: false}

itemList["MediumScope"]	= {illegal: true, fullyDegrades: true, decayrate: 1.0, displayname: "2x L Scope", price: 550, craft: [ {itemid: "goldbar", amount: 1 } ],  weight: 11, nonStack: true, model:  "", image: "np_lscope.png", deg: false} //'Heavy Sniper'

itemList["pistolammo"]	= {fullyDegrades: true, decayrate: 1.0, displayname: "Đạn súng lục x50", craft: [{itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 10, weight: 3, nonStack: false, model: "", image: "np_pistol-ammo.png" , deg: false}

itemList["rifleammo"]	= {fullyDegrades: true, decayrate: 1.0, displayname: "Đạn súng trường x50", craft: [{itemid: "aluminium", amount: 1 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_rifle-ammo.png" , deg: false}




// custom items with decay



itemList["repairkit"]	= {fullyDegrades: true, decayrate: 0.25, displayname: "Repair Kit", craft: [{itemid: "electronics", amount: 25 }], price: 400, weight: 1, nonStack: false, model: "", image: "np_basic_repair-kit.png" , deg: false}



// drugs

itemList["1gcocaine"]	= {fullyDegrades: true, illegal: true, decayrate: 0.5, displayname: "5g 35% Coke",    craft: [ {itemid: "glucose", amount: 0.01 }, {itemid: "coke5g", amount: 0.1 } ], price: 100, weight: 0,   nonStack: false, model: "", image: "np_cocaine-baggy.png", information: "35% Cut Cocaine. ", deg: false}
itemList["1gcrack"]	    = {fullyDegrades: true, illegal: true, decayrate: 0.5, displayname: "5g Crack",  craft: [ {itemid: "bakingsoda", amount: 0.01 } , {itemid: "coke5g", amount: 0.1 } ], price: 100, weight: 0,   nonStack: false, model: "", image: "np_crack.png", information: "Crack... ", deg: false}


itemList["coke50g"]	    = {fullyDegrades: true, illegal: true, decayrate: 0.5, displayname: "Coke Brick (50g)", price: 1000, weight: 5, nonStack: false, model: "", image: "np_cocaine-brick.png", information: "Increases your Stamina and Movement Speed <br> Breaks down into product." , deg: false}
itemList["coke5g"]	    = {fullyDegrades: true, illegal: true, decayrate: 0.5, displayname: "Coke Baggy (5g)", craft: [{itemid: "coke50g", amount: 0.1 }], price: 150, weight: 0, nonStack: false, model: "", image: "np_cocaine-baggy.png", information: "Increases your Stamina and Movement Speed" , deg: false}


itemList["joint"]	    = {fullyDegrades: true, illegal: true, decayrate: 0.75, displayname: "Cuốn 3g",    craft: [ {itemid: "weedq", amount: 5 }, {itemid: "rollingpaper", amount: 1 } ], price: 20, weight: 1,   nonStack: false, model: "", image: "np_joint.png", information: "Đây là một cuốn cần!. ", deg: false}

itemList["whiteseed"]	= {fullyDegrades: true, decayrate: 1.0, displayname: "hạt giống White Widow", price: 100, weight: 0,   nonStack: false, model: "", image: "np_weed-seed.png", information: "Plant near females to make them produce seeds. ", deg: false, esxuse: true, removuse: true}
itemList["kushseed"]	= {fullyDegrades: true, decayrate: 1.0, displayname: "hạt giống OG Kush", price: 100, weight: 0,   nonStack: false, model: "", image: "np_weed-seed.png", information: "Thank you." , deg: false}

itemList["golf"]	    = {fullyDegrades: true, decayrate: 0.2, displayname: "Bóng golf (trắng)", craft: [{itemid: "electronics", amount: 10 }], price: 100, weight: 5, nonStack: false, model: "", image: "pw-golfwhite.png" , deg: false, esxuse: true, removuse: true}

itemList["golf_yellow"]	    = {fullyDegrades: true, decayrate: 0.2, displayname: "Bóng golf (vàng)", craft: [{itemid: "electronics", amount: 10 }], price: 100, weight: 5, nonStack: false, model: "", image: "pw-golfyellow.png" , deg: false, esxuse: true, removuse: true}

itemList["golf_green"]	    = {fullyDegrades: true, decayrate: 0.2, displayname: "Bóng golf (xanh)", craft: [{itemid: "electronics", amount: 10 }], price: 100, weight: 5, nonStack: false, model: "", image: "pw-golfnew.png" , deg: false, esxuse: true, removuse: true}


itemList["golf_pink"]	    = {fullyDegrades: true, decayrate: 0.2, displayname: "Bóng golf (hồng)", craft: [{itemid: "electronics", amount: 10 }], price: 100, weight: 5, nonStack: false, model: "", image: "pw-golfpink.png" , deg: false, esxuse: true, removuse: true}


itemList["smallscales"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Cân tiểu li", craft: [{itemid: "steel", amount: 25 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 10 }], price: 3000, weight: 2, nonStack: false, model: "", image: "np_small-scale.png", information: "Cân không mất trọng lượng" , deg: false}

itemList["emptymethbag"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Túi không", craft: [{itemid: "rubber", amount: 2 }, {itemid: "plastic", amount: 2 }], price: 10, weight: 0, nonStack: false, model: "", image: "np_meth_empty_baggy.png", information: "Để bỏ gì đó vào trong" , deg: false}

itemList["curedmeth"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Cocain Thô", craft: [{itemid: "steel", amount: 25 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 10 }], price: 3000, weight: 2, nonStack: false, model: "", image: "np_meth_cured.png", information: "" , deg: false}

itemList["methbagged"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Cocain đã đóng gói", craft: [{itemid: "steel", amount: 25 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 10 }], price: 3000, weight: 2, nonStack: false, model: "", image: "np_meth_batch.png", information: "" , deg: false}


itemList["methbag"]	    = {fullyDegrades: true, illegal: true, decayrate: 2.0, displayname: "Ass Meth (1g)", price: 500, weight: 0, nonStack: false, model: "", image: "np_meth-baggy.png", information: "-7 Jail <br> +5 Stink <br> Increases your Stamina and Movement Speed - smells funny though <br> If it has roleplay stats, it must be roleplay." , deg: false}

itemList["oxy"]	        = {fullyDegrades: true, illegal: true, decayrate: 0.75, displayname: "Thuốc đau đầu", price: 25, weight: 0, nonStack: false, model: "", image: "np_Oxy.png", information: "Thuốc giảm đau đầu" , deg: false}
itemList["oxynew"]	        = {fullyDegrades: true, illegal: true, decayrate: 0.75, displayname: "Thuốc 100mg", price: 25, weight: 2, nonStack: false, model: "", image: "np_Oxy.png", information: "Giảm stress ngay lập tức" , deg: false}


itemList["weed12oz"]	= {fullyDegrades: true, illegal: true, decayrate: 0.0025, displayname: "Weed 250 Oz", price: 250, weight: 35, nonStack: false, model: "", image: "np_box-of-weed-12-18-oz.png", information: "Lowers Stress <br> Breaks Down into other Product" , deg: false}
itemList["weed5oz"]	    = {fullyDegrades: true, illegal: true, decayrate: 0.5, displayname: "Weed 5 Oz", price: 500,   weight: 5, nonStack: false, model:  "", image: "np_weed-brick-40-Oz.png", information: "Lowers Stress <br> Breaks Down into other Product" , deg: false}
itemList["weedoz"]	    = {fullyDegrades: true, illegal: true, decayrate: 0.3, displayname: "Weed Oz", price: 200, weight: 4, nonStack: false, model:  "", image: "np_weed-4-Oz.png", information: "Lowers Stress" , deg: false}
itemList["weedq"]	    = {fullyDegrades: true, illegal: true, decayrate: 0.3, displayname: "Weed Q", craft: [{itemid: "weedoz", amount: 0.25 }], price: 65, weight: 2, nonStack: false, model: "", image: "np_weed-oz.png", information: "Lowers Stress" , deg: false}


itemList["wetbud"] = {fullyDegrades: true, illegal: true, decayrate: 0.3, displayname: "Cây cần tươi (5 Grams)", price: 30, weight: 5, nonStack: false, model: "", image: "wet.png", information: "Cần phải phơi khô?" , deg: false}

itemList["driedbud"] = {fullyDegrades: true, illegal: true, decayrate: 0.3, displayname: "Lá cần khô (2 Grams)", price: 30, weight: 3.5, nonStack: false, model: "", image: "buddry2.png", information: "Làm gì nữa?" , deg: false}

itemList["smallbud"] = {fullyDegrades: true, illegal: true, decayrate: 0.3, displayname: "Cần đóng gói (2 Grams)", price: 30, weight: 3.5, nonStack: false, model: "", image: "buddry.png", information: "Đem bán?" , deg: false}


itemList["joint2"]	    = {fullyDegrades: true, illegal: true, decayrate: 0.75, displayname: "Cuốn 2g", craft: [ {itemid: "smallbud", amount: 1.0 }, {itemid: "rollingpaper", amount: 1 } ], price: 20, weight: 0,   nonStack: false, model: "", image: "np_joint.png", information: "Đây là cuốn cần. ", deg: false}



itemList["lsdtab"] = {fullyDegrades: true, illegal: true, decayrate: 0.3, displayname: "LSD Tab", price: 500, weight: 1, nonStack: false, model:  "", image: "np_lsdtab.png", information: "For spectacular trips, or whatever." , deg: true}
itemList["badlsdtab"] = {fullyDegrades: true, illegal: true, decayrate: 0.3, displayname: "LSD Tab", price: 200, weight: 1, nonStack: false, model:  "", image: "np_badlsdtab.png", information: "For spectacular trips, or whatever." , deg: true}


// other drugy shit

itemList["aspirin"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Aspirin", price: 250, weight: 0, nonStack: false, model:  "", image: "np_aspirin.png", information: "Giảm liền các cơn đau nguy kịch", deg: false}

itemList["cabsinthe"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Cannabis Absinthe", price: 150, weight: 0, nonStack: false, model: "", image: "np_cannabis-absinthe.png", information: "Duuude..bro...", deg: false, esxuse: true }

itemList["redwine"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Red Wine", price: 500, weight: 1, nonStack: false, model:  "", image: "np_red-wine-bottle.png", information: "No crime just wine", deg: false, esxuse: true }
itemList["rum"]	        = {fullyDegrades: false, decayrate: 0.0, displayname: "Rum", price: 250, weight: 0, nonStack: false, model:  "", image: "np_rum.png", information: "Why is it gone?", deg: false, esxuse: true }
itemList["tequila"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Tequila", price: 200, weight: 0, nonStack: false, model: "", image: "np_tequila.png", information: "Tequilya brand", deg: false, esxuse: true }
itemList["tequilashot"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Shot of Tequila", price: 50, weight: 1, nonStack: false, model: "", image: "np_tequila-shot.png", information: "Uno mas por favor", deg: false, esxuse: true }
itemList["vodka"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Vodka", price: 25, weight: 1, nonStack: false, model: "", image: "np_vodka.png", information: "Sates Thirst" , deg: false}

itemList["whiskey"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Whiskey", price: 200, weight: 1, nonStack: false, model: "", image: "np_whiskey.png", information: "Sates Thirst" , deg: false, esxuse: true}

itemList["420bar"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "420 Bar", price: 1, weight: 0, nonStack: false, model: "", image: "np_420-bar.png", information: "Duuuude brah...", deg: false }
itemList["69box"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "69 Cigar Box", price: 1, weight: 0, nonStack: false, model: "", image: "np_69-cigar-box.png", information: "A taste of Cuba", deg: false }
itemList["69pack"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "69 Brand Pack", price: 1, weight: 0, nonStack: false, model: "", image: "np_69-brand-pack.png", information: "Just one more", deg: false }

itemList["champagne"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Champagne", price: 1000, weight: 0, nonStack: false, model: "", image: "np_champagne.png", information: "Time to celebrate", deg: false, esxuse: true }

itemList["cgummies"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Cannabis Gummies", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cannabis-gummies.png", information: "Duuude...", deg: false }

itemList["chloroform"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Chloroform", price: 1, weight: 0, nonStack: false, model: "", image: "np_chloroform.png", information: "Special Cross recipe", deg: false }
itemList["ibuprofen"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Ibuprofen", price: 150, weight: 0, nonStack: false, model:  "", image: "np_ibuprofen.png", information: "Cures all. Right?" , deg: false}
itemList["drugx"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Drug X", price: 1, weight: 0, nonStack: false, model:  "", image: "np_drug-x.png", information: "Now in testing by Humane Labs", deg: false }

itemList['cgchain'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Chang Gang Chain',
  craft: [[
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'aluminium', amount: 100 },
    { itemid: 'copper', amount: 100 },
  ], [
    { itemid: 'goldbar', amount: 2 },
    { itemid: 'refinedaluminium', amount: 32 },
    { itemid: 'refinedcopper', amount: 32 },
  ]],
  price: 10,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_cg_chain.png',
  information: 'Represent!',
  cgChainCraft: true,
};

// food

itemList["beer"]    	= {fullyDegrades: false, decayrate: 0.0, displayname: "Beer", price: 10, weight: 1, nonStack: false, model: "", image: "np_beer.png", information: "Sates Thirst" , deg: false}

itemList["bfsandwich"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Breakfast Sandwich", price: 1, weight: 0, nonStack: false, model: "", image: "np_breakfast-sandwich.png", information: "Rise and shine", deg: false }

itemList["cbballs"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Cluckin Balls", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cluckin-balls.png", information: "Ooh..salty. 440Cal", deg: false }
itemList["cbbucket"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Chicken Bucket", price: 1, weight: 0, nonStack: false, model: "", image: "np_chicken-bucket.png", information: "I like chicken! 2350Cal", deg: false }
itemList["cbclucker"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Little Clucker", price: 1, weight: 0, nonStack: false, model:  "", image: "np_little-clucker.png", information: "Cluckin toy not included", deg: false }
itemList["cbdrink"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Cluckin Drink", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cluckin-drink.png", information: "Hell Cluckin Yeah", deg: false }
itemList["cbfarmers"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Farmer's Surprise", price: 1, weight: 0, nonStack: false, model:  "", image: "np_farmers-surprise.png", information: "The chewy bits arent harmful", deg: false }
itemList["cbfowl"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Fowl Burger", price: 1, weight: 0, nonStack: false, model:  "", image: "np_fowl-burger.png", information: "If you enjoyed it, the chicken didnt die in vain! 900Cal", deg: false }
itemList["cbfries"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Cluckin Fries", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cluckin-fries.png", information: "Cluckinsize included. 680Cal", deg: false }
itemList["cbrings"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Cluckin Rings", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cluckin-rings.png", information: "Suffering never tasted so good! 850Cal", deg: false }
itemList["cbrownie"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Cannabis Brownie", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cannabis-brownie.png", information: "Dude...", deg: false }
itemList["cbveggy"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Veggy Salad", price: 1, weight: 0, nonStack: false, model:  "", image: "np_veggy-salad.png", information: "Mystery chewy bits included. 750Cal", deg: false }

itemList["cocoab"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Cocoa Butter", price: 1, weight: 0, nonStack: false, model: "", image: "np_cocoa-butter.png", information: "Hecho en Guatemala", deg: false }

itemList["cookie"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Cookie", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cookie.png", information: "Baked with love", deg: false }
itemList["crabcakes"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Crab Cakes", price: 1, weight: 0, nonStack: false, model: "", image: "np_crab-cakes.png", information: "Scrumptious", deg: false }

itemList["energybar"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Energy Bar", price: 1, weight: 0, nonStack: false, model:  "", image: "np_energy-bar.png", information: "Ego Chaser bars for chads", deg: false }


itemList["pizza"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Pizza Slice", price: 1, weight: 0, nonStack: false, model:  "", image: "np_pizza-slice.png", information: "Check for pineapple", deg: false }

itemList["sushiplate"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Sushi Plate", price: 1, weight: 0, nonStack: false, model:  "", image: "np_sushi-plate.png", information: "Dip fish-side first", deg: false }
itemList["sushiroll"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Sushi Rolls", price: 1, weight: 0, nonStack: false, model:  "", image: "np_sushi-rolls.png", information: "Made fresh", deg: false }


itemList["wings"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Wings", price: 1, weight: 0, nonStack: false, model: "", image: "np_wings.png", information: "Dont lick your fingers", deg: false }

itemList["chips"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Chips", price: 1, weight: 0, nonStack: false, model:  "", image: "np_chips.png", information: "Phat Chips yeeeaaah.", deg: false }

itemList["chocobar"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Chocolate Bar", price: 1, weight: 0, nonStack: false, model:  "", image: "np_chocolate-bar.png", information: "Mmm...Meteorite Bar", deg: false }


itemList["maccheese"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Mac & Cheese", price: 1, weight: 0, nonStack: false, model: "", image: "np_macn-cheese.png", information: "Sapid", deg: false }



itemList["meteorite"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Fukang Meteorite", price: 1, weight: 0, nonStack: false, model:  "", image: "np_fukang-meteorite.png", information: "Out of this world", deg: false }



itemList["pancakes"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Pancakes", price: 150, weight: 0, nonStack: false, model:  "", image: "np_pancakes.png", information: "Flat but tasty" , deg: false}
itemList["panini"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Panini Sandwich", price: 1, weight: 0, nonStack: false, model: "", image: "np_panini-sandwich.png", information: "Piquant", deg: false }

itemList["pinacolada"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Pina Colada", price: 150, weight: 1, nonStack: false, model: "", image: "np_pina-colada.png", information: "And getting caught in the rain", deg: false, esxuse: true }
itemList["polarbear"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Polar Bear", price: 150, weight: 1, nonStack: false, model: "", image: "np_polarbear.png", information: "", deg: false, esxuse: true }
itemList["rumcoke"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Rum Coca", price: 150, weight: 1, nonStack: false, model: "", image: "np_rumcoke.png", information: "", deg: false, esxuse: true }

itemList["planterpunch"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Planter's punch", price: 150, weight: 1, nonStack: false, model: "", image: "np_drink1.png", information: "", deg: false, esxuse: true }

itemList["aperolspritz"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Aperol spritz", price: 150, weight: 1, nonStack: false, model: "", image: "np_drink2.png", information: "", deg: false, esxuse: true }
itemList["sazerac"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Sazerac", price: 150, weight: 1, nonStack: false, model: "", image: "np_drink3.png", information: "", deg: false, esxuse: true }
itemList["penicillin"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Penicillin", price: 150, weight: 1, nonStack: false, model: "", image: "np_drink4.png", information: "", deg: false, esxuse: true }
itemList["vieuxcarre"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Vieux carré", price: 150, weight: 1, nonStack: false, model: "", image: "np_drink5.png", information: "", deg: false, esxuse: true }
itemList["magarita"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Magarita lựu", price: 150, weight: 1, nonStack: false, model: "", image: "np_drink6.png", information: "", deg: false, esxuse: true }

itemList["popcorn"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Popcorn", price: 1, weight: 0, nonStack: false, model:  "", image: "np_popcorn.png", information: "Dis gon b gud", deg: false }

itemList["ramen"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Ramen", price: 150, weight: 0, nonStack: false, model:  "", image: "np_ramen.png", information: "Itadakimasu!" , deg: false}


itemList["bubblelasagna"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "'Lasagna'", price: 150, weight: 0, nonStack: false, model:  "", image: "np_bubblelasagna.png", information: "Cooked.. somehow.." , deg: false}
itemList["spaghetti"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Spaghetti", price: 150, weight: 0, nonStack: false, model:  "", image: "np_spaghetti.png", information: "Knees weak..." , deg: false}
itemList["spaghettican"] = {fullyDegrades: false, decayrate: 0.0, displayname: "Can of Spaghetti", price: 1, weight: 0, nonStack: false, model: "", image: "np_spaghetti-can.png", information: "Fresh from the trunk, awight?", deg: false }

itemList["torta"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Torta", price: 1, weight: 0, nonStack: false, model: "", image: "np_torta.png", information: "El mejor jamon", deg: false }



// dayz food



itemList["coffee"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Coffee", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_coffee.png", information: "Wow, its strong." , deg: false}

itemList["cola"]	    = {fullyDegrades: true, decayrate: 0.05, displayname: "Cola", price: 5, weight: 1, nonStack: false, model: "", image: "np_coke.png", information: "Sates Thirst" , deg: false}

itemList["burrito"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Burrito", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model:  "", image: "np_burrito.png", information: "Burrito" , deg: false}

itemList["eggsbacon"]	= {fullyDegrades: true, decayrate: 0.01, displayname: "Eggs and Bacon", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model:  "", image: "np_eggs-and-bacon.png", information: "Great start to your morning" , deg: false}

itemList["donut"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Donut", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_donut.png", information: "Powered by Francis™", deg: false}

itemList["foodgoods"]	= {fullyDegrades: true, decayrate: 0.01, displayname: "Food goods", price: 500, weight: 3, nonStack: false, model: "", image: "np_food-goods.png" , deg: false}

itemList["foodingredient"]	= {fullyDegrades: true, decayrate: 0.01, displayname: "Gia vị", price: 15, weight: 1, nonStack: false, model: "", image: "np_ingredients.png", information: "Dùng để nêm nếm thức ăn!", deg: false}

itemList["fries"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Fries", price: 50, weight: 1,   nonStack: false, model: "", image: "np_fries.png", information: "Sates Hunger and reduces stress." , deg: false}

itemList["greencow"]	= {fullyDegrades: true, decayrate: 0.01, displayname: "Green Cow", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_green-cow.png", information: "Slightly Increases Stamina and Speed" , deg: false}

itemList["churro"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Churro", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_churro.png", information: "Basically a long donut.", deg: false}

itemList["bakingsoda"]	= {fullyDegrades: true, decayrate: 0.01, displayname: "Baking Soda", price: 50,  weight: 0,   nonStack: false, model: "", image: "np_bakingsoda.png", information: "Its Baking Soda..? Mix with 10g Cocaine Bags to make Crack Cocaine. ", deg: false}

itemList["bleederburger"]	= {fullyDegrades: true, decayrate: 0.01, displayname: "The Bleeder", price: 50,      weight: 1,   nonStack: false, model: "", image: "np_the-bleeder.png", information: "Sates Hunger and reduces stress." , deg: false}

itemList["water"]	    = {fullyDegrades: true, decayrate: 0.05, displayname: "Nước", price: 5, weight: 1, craft: [{itemid: "foodingredient", amount: 1 } ], nonStack: false, model: "", image: "water.png", information: "Sates Thirst" , deg: false}




itemList["hotdog"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Hot Dog", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model:  "", image: "np_hotdog.png", information: "Dont ask what is in it" , deg: false}

itemList["icecream"]	= {fullyDegrades: true, decayrate: 0.01, displayname: "Ice Cream", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_icecream.png", information: "Made from real human titty milk.", deg: false}

itemList["jailfood"]	= {fullyDegrades: true, decayrate: 0.001, displayname: "Jail Food", price: 0, weight: 50, nonStack: false, model: "", image: "np_jailfood.png", information: "+5 fat <br> Looks as bad as the Sheriff's aim." , deg: false}

itemList["sandwich"]	= {fullyDegrades: true, decayrate: 0.05,craft: [{itemid: "foodingredient", amount: 1 } ],displayname: "Sandwich", price: 5, weight: 1, nonStack: false, model: "", image: "np_sandwich.png", information: "Sates Hunger" , deg: false}

itemList["torpedo"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Torpedo", price: 50,      weight: 1,   nonStack: false, model: "", image: "np_torpedo.png", information: "Sates Hunger and reduces stress." , deg: false}

itemList["treat"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Dog Treat", price: 69, weight: 0, nonStack: false, model:  "", image: "np_treat.png", information: "Feed to dog", deg: false }

itemList["hamburger"]	= {fullyDegrades: true, decayrate: 0.05, displayname: "Hamburger", price: 5, weight: 1, nonStack: false, model: "", image: "np_hamburger.png", information: "Sates Hunger" , deg: false}

itemList["weedtaco"]	    = {fullyDegrades: true, decayrate: 0.00012, displayname: "Delivery", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 5, nonStack: false, model: "", image: "np_paperbag.png", information: "This aint free taco.", deg: false}

itemList["fishtaco"]	= {fullyDegrades: true, decayrate: 0.01, displayname: "Fish Taco", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_fishtaco.png", information: "Make like the fishes.", deg: false}

itemList["heartstopper"] = {fullyDegrades: true, decayrate: 0.01, displayname: "The Heart Stopper", price: 50,      weight: 1,   nonStack: false, model: "", image: "np_the-heart-stopper.png", information: "Sates Hunger and reduces stress." , deg: false}

itemList["moneyshot"]	= {fullyDegrades: true, decayrate: 0.01, displayname: "Money Shot", price: 50,      weight: 1,   nonStack: false, model: "", image: "np_money-shot.png", information: "Sates Hunger and reduces stress." , deg: false}

itemList["meatfree"]	= {fullyDegrades: true, decayrate: 0.01, displayname: "Meat Free", price: 50,      weight: 1,   nonStack: false, model: "", image: "np_meat-free.png", information: "Sates Hunger and reduces stress." , deg: false}

itemList["mshake"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Milkshake", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model:  "", image: "np_milkshake.png", information: "Hand-scooped for you" , deg: false}
itemList["taco"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Taco", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_taco.png", information: "This aint free taco.", deg: false}

itemList["freshmeat"]	    = {fullyDegrades: true, decayrate: 0.01, displayname: "Fresh Meat", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_rawmeat.png", information: "Meat, Wow..", deg: false}



// materials

itemList["aluminium"]	    = { craft: [{itemid: "recyclablematerial", amount: 40 },{itemid: "aluminiumoxide", amount: 1 } ], fullyDegrades: true, decayrate: 0.5, displayname: "Nhôm", price: 10, weight: 0.01, nonStack: false, model: "", image: "np_aluminum.png" , deg: false}


itemList["plastic"]	    = { craft: [{itemid: "recyclablematerial", amount: 5 } ], fullyDegrades: true, decayrate: 1.0, displayname: "Nhựa", price: 11, weight: 0.01, nonStack: false, model: "", image: "np_plastic.png" , deg: false}
itemList["copper"]	    = { craft: [{itemid: "recyclablematerial", amount: 10 } ], fullyDegrades: true, decayrate: 1.0, displayname: "Đồng", price: 10, weight: 0.01, nonStack: false, model: "", image: "np_copper.png" , deg: false}

itemList["electronics"]	= { craft: [{itemid: "recyclablematerial", amount: 5 } ], fullyDegrades: true, decayrate: 1.0, displayname: "Đồ điện tử", price: 15, weight: 0.01, nonStack: false, model: "", image: "np_electronics.png" , deg: false}
itemList["rubber"]	    = { craft: [{itemid: "recyclablematerial", amount: 5 } ], fullyDegrades: true, decayrate: 1.0, displayname: "Cao su", price: 10, weight: 0.01, nonStack: false, model: "", image: "np_rubber.png" , deg: false}
itemList["scrapmetal"]	= { craft: [{itemid: "recyclablematerial", amount: 5 } ], fullyDegrades: true, decayrate: 1.0, displayname: "Sắt vụn", price: 15, weight: 0.01, nonStack: false, model: "", image: "np_scrap-metal.png" , deg: false}
itemList["steel"]	    = { craft: [{itemid: "recyclablematerial", amount: 20 } ], fullyDegrades: true, decayrate: 1.0, displayname: "Thép", price: 15, weight: 0.01, nonStack: false, model: "", image: "np_steel.png" , deg: false}

itemList["glass"]	    = { craft: [{itemid: "recyclablematerial", amount: 10 } ], fullyDegrades: true, decayrate: 1.0, displayname: "Thuỷ tinh", price: 12, weight: 0.01, nonStack: false, model: "", image: "np_glass.png" , deg: false}






itemList["advlockpick"]	= {fullyDegrades: true, decayrate: 0.25, displayname: "Adv Lock Pick", craft: [{itemid: "aluminium", amount: 15 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 500, weight: 3, nonStack: false, model: "", image: "np_advanced-lockpick.png" , deg: false}
itemList["armor"]	    = {fullyDegrades: true, decayrate: 0.25, displayname: "Áo chống đạn", craft: [{itemid: "aluminium", amount: 5 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 250, weight: 0, nonStack: false, model: "", image: "np_chest-armor.png", information: "Bảo vệ khỏi bị đạn bắn." , deg: false}
itemList['bikearmor'] = {
  fullyDegrades: true,
  decayrate: 0.5,
  displayname: 'Bike Armor',
  price: 500,
  weight: 50,
  craft: [
    [
      { itemid: 'refinedaluminium', amount: 8 },
      { itemid: 'refinedcopper', amount: 8 },
      { itemid: 'refinedrubber', amount: 8 },
      { itemid: 'refinedplastic', amount: 8 },
    ]
  ],
  nonStack: false,
  blockScrap: true,
  model: '',
  image: 'np_bikearmor.png',
  information: 'Protects you from motorbike accidents.',
};

itemList["bandage"]	    = {fullyDegrades: true, decayrate: 0.25, displayname: "Băng gạc", price: 15, weight: 1, nonStack: false, model: "prop_ld_health_pack", image: "np_bandage.png", information: "Heals Wounds and Reduces Bleeding" , deg: false}




// general items

itemList["aluminiumoxide"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Aluminium Oxide", price: 55, weight: 1, nonStack: false, model: "", image: "np_aluminum-oxide.png" , deg: false}
itemList["advrepairkit"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Adv Repair Kit",  craft: [ {itemid: "electronics", amount: 10 } ], price: 100,   weight: 5, nonStack: false, model: "", image: "np_repair-toolkit.png", information: "1 Time use - degrades engine parts more than basic tool kits, repairs engine to full.", deg: false}
itemList["assphone"]	= {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Ass Phone", price: 500, weight: 5, nonStack: false, model: "", image: "np_poophone.png", information: "-7 Jail <br> +5 Vibrate <br> You cant seem to work out the lock code? <br> If it has roleplay stats, it must be roleplay." , deg: false}







// custom items

itemList["ace"]	        = {fullyDegrades: false, decayrate: 0.0, displayname: "Ace of Spades", price: 1, weight: 0, nonStack: false, model:  "", image: "np_ace-of-spades.png", information: "Up your sleeve", deg: false }
itemList["action"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Action Figure", price: 1, weight: 0, nonStack: false, model:  "", image: "np_action-figure.png", information: "Superhero: Impotent Rage", deg: false }

itemList["armxray"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Arm X-Ray", price: 1, weight: 0, nonStack: false, model:  "", image: "np_arm-xray.png", information: "Ouch...", deg: false }
itemList["atacos"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Tacos de Asada", price: 1, weight: 0, nonStack: false, model: "", image: "np_tacos-de-asada.png", information: "I could eat ten", deg: false }
itemList["azpapers"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Aztecas Papers", price: 1, weight: 0, nonStack: false, model: "", image: "np_aztecas-papers.png", information: "Orale", deg: false }

itemList["anime"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Anime Poster", price: 1, weight: 0, nonStack: false, model:  "", image: "np_anime-poster.png", information: "Weebs in uwu", deg: false }

itemList["aodcut"]      = {fullyDegrades: false, decayrate: 0.0, displayname: "AoD MC Cut", price: 1, weight: 0, nonStack: false, model: "", image: "np_aod-cut.png", information: "The fruits of Lester Arnold's labor", deg: false }

itemList["bluebelt"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Blue 622 Belt", price: 1, weight: 0, nonStack: false, model:  "", image: "np_blue-belt.png", information: "Blue 622 - Sensei", deg: false }
itemList["blackbelt"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Black Belt", price: 1, weight: 0, nonStack: false, model:  "", image: "np_black-belt.png", information: "Master Rank 4/4", deg: false }
itemList["blackchip"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Black Chip", price: 1, weight: 0, nonStack: false, model: "", image: "np_black-chip.png", information: "Feel nice in your hand", deg: false }
itemList["bglass"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Beer Glass", price: 70, weight: 1, nonStack: false, model: "", image: "np_glass-of-beer.png", information: "Wait for this all to blow over", deg: false, esxuse: true }
itemList["bobross"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bob Ross Photo", price: 1, weight: 0, nonStack: false, model:  "", image: "np_bob-ross-photo.png", information: "Happy little loose ends...", deg: false }
itemList["bondicut"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bondi Boys Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_bondi-cut.png", information: "And an old rocking chair", deg: false }


itemList["bspapers"]	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Ballas Papers", price: 1, weight: 0, nonStack: false, model: "", image: "np_ballas-papers.png", information: "You good?", deg: false }
itemList["bucket"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bucket", price: 10, weight: 1, nonStack: false, model: "", image: "np_bucket.png" , deg: false}
itemList["burialmask"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Burial Mask", price: 1, weight: 0, nonStack: false, model:  "", image: "np_burial-mask.png", information: "Mask of Tutankhamun", deg: false }

itemList["braab"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Braab Shirt", price: 150, weight: 0, nonStack: false, model:  "", image: "np_braab-tshirt.png", information: "Yikes" , deg: false}
itemList["brain"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Brain MRI", price: 1, weight: 0, nonStack: false, model:  "", image: "np_brain-mri.png", information: "Ow...", deg: false }

itemList["bonsai"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Bonsai Tree", price: 1, weight: 0, nonStack: false, model: "", image: "np_bonsai-tree.png", information: "Be one with nature", deg: false }

itemList["cactus"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Cactus", price: 1, weight: 0, nonStack: false, model: "", image: "np_cactus.png", information: "For the lazy", deg: false }

itemList["cathat"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Children's Book", price: 1, weight: 0, nonStack: false, model: "", image: "np_childrens-book.png", information: "Its story time...", deg: false }

itemList["camille"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Camille", price: 1, weight: 0, nonStack: false, model: "", image: "np_camille.png", information: "Monet 1866", deg: false }

itemList["carbattery"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Car Battery", price: 150, weight: 0, nonStack: false, model:  "", image: "np_car-battery.png", information: "Car Battery" , deg: false}
itemList["carhood"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Car Hood", price: 150, weight: 0, nonStack: false, model:  "", image: "np_car-hood.png", information: "Car Hood" , deg: false}
itemList["cashroll"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Cuộn tiền", price: 1, weight: 0.1, nonStack: false, model:  "", image: "np_cash-roll.png", information: "", deg: false }

itemList["cashstack"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Sấp tiền", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cash-stack.png", information: "All nice and sequential.", deg: false }

itemList["bdiamond"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Blue Diamond", price: 1, weight: 0, nonStack: false, model:  "", image: "np_blue-diamond.png", information: "Bavaria 1918.", deg: false }


itemList["band"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Band of Notes", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cash-stack.png", information: "Lots of low denominators - Indicates drug sales.", deg: false }
itemList["rollcash"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Cuộn tiền nhỏ", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cash-roll.png", information: "Nhiều mẫu số thấp - Cho biết doanh số bán thuốc.", deg: false }












itemList["battery"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Battery", price: 10, weight: 1, nonStack: false, model: "", image: "np_battery.png" , deg: false}
itemList["bazooka"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bazooka Suppressor", price: 1, weight: 0, nonStack: false, model:  "", image: "np_bazooka-suppressor.png", information: "Good for a single shot.", deg: false }

itemList["binoculars"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Binoculars", craft: [{itemid: "aluminium", amount: 5 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 300, weight: 10, nonStack: false, model: "", image: "np_binoculars.png" , deg: false}
itemList["bloodbag"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Blood Bag", price: 1, weight: 0, nonStack: false, model: "", image: "np_blood-bag.png", information: "Just my type", deg: false }
itemList["bloodvial"]       = {fullyDegrades: false, decayrate: 0.0, displayname: "Blood Vial", price: 1, weight: 0, nonStack: false, model: "", image: "np_blood-tube.png", information: "Simon ese", deg: false }
itemList["blueb"]       = {fullyDegrades: false, decayrate: 0.0, displayname: "Blue Bandana", price: 1, weight: 0, nonStack: false, model: "", image: "np_blue-bandana.png", information: "Simon ese", deg: false }
itemList["bluechip"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Blue Chip", price: 1, weight: 0, nonStack: false, model: "", image: "np_blue-chip.png", information: "Double or nothing", deg: false }
itemList["bmary"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Bloody Mary", price: 120, weight: 1, nonStack: false, model: "", image: "np_bloody-mary.png", information: "With a hint of lemon", deg: false, esxuse: true }
itemList["Boombox"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Boombox", price: 350, weight: 0, nonStack: false, model: "", image: "np_boombox.png", information: "Its a prop, wow?" , deg: false}
itemList["Box"]	        = {fullyDegrades: false, decayrate: 0.0, displayname: "Box", price: 350, weight: 0, nonStack: false, model: "", image: "np_box.png", information: "Its a prop, wow?" , deg: false}
itemList["breadboard"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Breadboard", price: 60, weight: 1, nonStack: false, model: "", image: "np_breadboard.png" , deg: false}


itemList["camera"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Nikea NP1000", price: 2000, weight: 1, nonStack: false, model: "", image: "np_camera.png", information: "Works 100% of the time 60% of the time.", deg: false}

itemList["casing"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bullet Casing", price: 10, weight: 0, nonStack: true, model: "", image: "np_pistol-ammo.png" , deg: false}

itemList["certificate"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Certificate", price: 1, weight: 0, nonStack: false, model:  "", image: "np_certificate.png", information: "You made it!", deg: false }
itemList["cgpapers"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "CG Papers", price: 1, weight: 0, nonStack: false, model: "", image: "np_cg-papers.png", information: "Wata woozers", deg: false }

itemList["chalice"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Pimp Chalice", price: 100, weight: 0,   nonStack: false, model: "", image: "np_pimp-chalice.png", information: "Morgan Freidmans Legendary Pimp Chalice.", deg: false}

itemList["champion"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Championship Belt", price: 1, weight: 0, nonStack: false, model:  "", image: "np_champion-belt.png", information: "Money is in the rematch.", deg: false }
itemList["chestxray"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Chest X-Ray", price: 1, weight: 0, nonStack: false, model:  "", image: "np_chest-xray.png", information: "Argh...", deg: false }
itemList["chglass"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Champagne Glass", price: 1, weight: 0, nonStack: false, model: "", image: "np_champagne-glass.png", information: "To us", deg: false }
itemList["cigar"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Cigar", price: 30, weight: 0, nonStack: false, model: "", image: "np_cigar.png" , deg: false}
itemList["ciggy"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Thuốc lá", price: 10, weight: 0, nonStack: false, model: "", image: "np_cigarette.png" , deg: false}
itemList["civtrophy"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Civilian of the Year", price: 1, weight: 0, nonStack: false, model: "", image: "np_civ-trophy.png", information: "The greatest law-abiding citizen", deg: false }
itemList["ckatana"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Cursed Katana", price: 1, weight: 0, nonStack: false, model: "", image: "np_cursed-katana.png", information: "Very honorable katana to slay Gojira", deg: false }
itemList["cleaninggoods"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Cleaning goods", price: 500, weight: 3, nonStack: false, model: "", image: "np_cleaning-goods.png" , deg: false}
itemList["clotion"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Cannabis Lotion", price: 1, weight: 0, nonStack: false, model: "", image: "np_cannabis-lotion.png", information: "Bro..duuudee..", deg: false }
itemList["clover"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Four-leaf Clover", price: 1, weight: 0, nonStack: false, model:  "", image: "np_clover.png", information: "+255 Luck", deg: false }
itemList["clutch"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Clutch", price: 30, weight: 5, nonStack: false, model: "", image: "np_clutch.png" , deg: false}

itemList["comp"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Composition", price: 1, weight: 0, nonStack: false, model:  "", image: "np_composition.png", information: "What do you think it means?", deg: false }

itemList["corpsefeet"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Feet", price: 50, weight: 0, nonStack: false, model:  "", image: "feet2.png", information: "Wheres the rest of the body?" , deg: false}
itemList["corpsehands"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Hands", price: 50, weight: 0, nonStack: false, model:  "", image: "hands.png", information: "Wheres the rest of the body?" , deg: false}
itemList["coupon10"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "10% Off Coupon", price: 1, weight: 0, nonStack: false, model:  "", image: "np_coupon-ten.png", information: "Limit only one per sale!", deg: false }
itemList["coupon15"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "15% Off Coupon", price: 1, weight: 0, nonStack: false, model:  "", image: "np_coupon-fifteen.png", information: "Does not include jail time", deg: false }
itemList["coupon25"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "25% Off Coupon", price: 1, weight: 0, nonStack: false, model:  "", image: "np_coupon-25.png", information: "Expires 01/2045", deg: false }


itemList["crane"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Origami Crane", price: 1, weight: 0, nonStack: false, model:  "", image: "np_origami-crane.png", information: "Gaff approved", deg: false }
itemList["csuey"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Chop Suey", price: 1, weight: 0, nonStack: false, model: "", image: "np_chop-suey.png", information: "Hopper 1929", deg: false }

itemList["ctrophy"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Cooking Trophy", price: 1, weight: 0, nonStack: false, model: "", image: "np_cooking-trophy.png", information: "Shokugeki victory", deg: false }
itemList["cuffs"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Hand Cuffs", craft: [{itemid: "scrapmetal", amount: 100 }], price: 250, weight: 1, nonStack: false, model: "", image: "np_hand-cuffs.png" , deg: false}
itemList["cultneck"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Cult Necklace", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cult-necklace.png", information: "One of us...", deg: false }
itemList["dcboard"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Diamond Chessboard", price: 1, weight: 0, nonStack: false, model: "", image: "np_diamond-chessboard.png", information: "Deep Blue cant appreciate this", deg: false }
itemList["dcert"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Death Certificate", price: 1, weight: 0, nonStack: false, model: "", image: "np_d-certificate.png", information: "In memoriam", deg: false }
itemList["decrypterenzo"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Decrypter Enzo", price: 300, weight: 5, nonStack: false, model: "", image: "np_decrypter-enzo.png" , deg: false}
itemList["decrypterfv2"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Decrypter Fv2", price: 300, weight: 5, nonStack: false, model: "", image: "np_decrypter-fv2.png" , deg: false}
itemList["decryptersess"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Decrypter Sess", price: 300, weight: 5, nonStack: false, model: "", image: "np_decrypter-sess.png" , deg: false}

itemList["diamondrec"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Diamond Record", price: 1, weight: 0, nonStack: false, model: "", image: "np_diamond-record.png", information: "10 Million units sold!!", deg: false }
itemList["dice"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Pair of Dice", price: 1, weight: 0, nonStack: false, model:  "", image: "np_dice.png", information: "Just takin out the trash", deg: false }
itemList["dodo"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Dodo Statue", price: 1, weight: 0, nonStack: false, model: "", image: "np_dodo-statue.png", information: "Arent these extinct?", deg: false }
itemList["dodospit"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Dodo Spit", price: 1, weight: 0, nonStack: false, model: "", image: "np_dodo-spit.png", information: "What the..why?!", deg: false }

itemList["dragon"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Dragon", price: 150, weight: 0, nonStack: false, model:  "", image: "np_dragon.png", information: "Hopefully its not useless like in GOT" , deg: false}
itemList["dream"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Dreamcatcher", price: 1, weight: 0, nonStack: false, model:  "", image: "np_dreamcatcher.png", information: "Sleep well", deg: false }

itemList["drill"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Drill", craft: [{itemid: "aluminium", amount: 25 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 150, weight: 80, nonStack: false, model: "", image: "np_drill.png" , deg: false}
itemList["drillbit"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Drill Bit", price: 100, weight: 2, nonStack: false, model: "", image: "np_drill-bit.png" , deg: false}

itemList["drivingtest"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Driving Test", price: 10, weight: 1, nonStack: true, model: "", image: "np_driving-test.png" , deg: false}
itemList["dskull"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Diamond Skull", price: 1, weight: 0, nonStack: false, model: "", image: "np_diamond-skull.png", information: "For the Love of God - Hirst 2007", deg: false }
itemList["DuffelBag"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Black Duffel Bag", price: 350, weight: 0, nonStack: false, model: "", image: "np_duffel.png", information: "Its a prop, wow?" , deg: false}
itemList["dusche"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Dusche Gold", price: 1, weight: 0, nonStack: false, model: "", image: "np_dusche-gold.png", information: "Let it pour", deg: false }
itemList["dye"]	        = {fullyDegrades: false, decayrate: 0.0, displayname: "Dye", price: 10, weight: 0, nonStack: false, model: "", image: "np_dye.png" , deg: false}


itemList["electronickit"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Electronic Kit", craft: [{itemid: "electronics", amount: 230 }], price: 900, weight: 15, nonStack: false, model: "", image: "np_electronic-kit.png" , deg: false}
itemList["emptybaggies"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Túi zip (x10)", craft: [{itemid: "plastic", amount: 10 }] ,price: 50, weight: 1, nonStack: false, model: "", image: "np_pack-of-empty-baggies.png" , deg: false}
itemList["enchiladas"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Enchiladas", price: 1, weight: 0, nonStack: false, model: "", image: "np_enchiladas.png", information: "Mas chile por favor", deg: false }
itemList["ering"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Engagement Ring", price: 150, weight: 0, nonStack: false, model:  "", image: "np_engagement-ring.png", information: "Hope its a yes..." , deg: false}
itemList["erpring"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Gold Band Ring.", price: 1, weight: 0, nonStack: false, model:  "", image: "np_engagement-ring.png", information: "Its a Sapphire Diamond & Gold ring. You look upon the ring and it reads 'Isaacs Dearest'..." , deg: false}
itemList["evidence"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Evidence", price: 0, weight: 1, nonStack: true, model: "", image: "np_evidence.png" , deg: false}
itemList["evidencebag"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Túi lưu trữ", price: 0, weight: 0, nonStack: true, model: "", image: "np_evidence-bag.png" , deg: false}
itemList["faberge"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Faberge Egg", price: 150, weight: 0, nonStack: false, model:  "", image: "np_faberge-egg.png", information: "Rockford Hills easter egg" , deg: false}
itemList["failtest"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Failed Test", price: 1, weight: 0, nonStack: false, model:  "", image: "np_failed-test.png", information: "Try again later", deg: false }
itemList["fakeplate"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Fake Plate Kit", craft: [ {itemid: "electronics", amount: 10 } ], price: 50, weight: 0,   nonStack: false, model: "", image: "np_plate.png", information: "Use on a vehicle to alter its plate or change it back - 1 time use..", deg: false}
itemList["fbumper"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Front Bumper", price: 1, weight: 0, nonStack: false, model: "", image: "np_front-bumper.png", information: "Ill have the tuna, no crust", deg: false }
itemList["feathers"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Feathers", price: 1, weight: 0, nonStack: false, model: "", image: "np_feathers.png", information: "Get plucked", deg: false }
itemList["femmes"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Les Femmes d'Alger", price: 1, weight: 0, nonStack: false, model: "", image: "np_les-femmes-dalger.png", information: "Picasso 1955", deg: false }

itemList["filetm"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Filet Mignon", price: 1, weight: 0, nonStack: false, model: "", image: "np_filet-mignon.png", information: "Succulent", deg: false }
itemList["flowers"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Flowers", price: 50, weight: 10, nonStack: false, model:  "", image: "np_flowers.png", information: "Wow, so beautiful." , deg: false}
itemList["flyer"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Flyer", price: 1, weight: 0, nonStack: false, model:  "", image: "np_flyer.png", information: "Invite people to your business or event!", deg: false }
itemList["flyer"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Flyer", price: 150, weight: 0, nonStack: false, model:  "", image: "np_flyer.png", information: "Invite people to your business or event!" , deg: false}
itemList["frappuccino"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Frappuccino", price: 1, weight: 0, nonStack: false, model:  "", image: "np_frappuccino.png", information: "Its like I have ESPN or something", deg: false }
itemList["frisbee"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Frisbee", price: 1, weight: 0, nonStack: false, model:  "", image: "np_frisbee.png", information: "And she would throw it back to me", deg: false }
itemList["ftartlet"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Fruit Tartlet", price: 1, weight: 0, nonStack: false, model: "", image: "np_fruit-tartlet.png", information: "Flavorsome", deg: false }
itemList["ftoast"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "French Toast", price: 1, weight: 0, nonStack: false, model: "", image: "np_french-toast.png", information: "Delectable", deg: false }
itemList["fuse"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Fuse", price: 30, weight: 1, nonStack: false, model: "", image: "np_fuse.png" , deg: false}

itemList["glowing"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Glowing Substance", price: 1, weight: 0, nonStack: false, model:  "", image: "np_glowing-substance.png", information: "May cause unexpected mutations", deg: false }
itemList["glucose"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "500g Glucose", price: 50,  weight: 0,   nonStack: false, model: "", image: "np_glucose.png", information: "Mmmm Glucose. Mix with 10g Cocaine Bags to make street cocaine.", deg: false}
itemList["goldchip"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Gold Chip", price: 1, weight: 0, nonStack: false, model: "", image: "np_gold-chip.png", information: "All in", deg: false }
itemList["goldcoin"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Gold Coin", price: 1, weight: 0, nonStack: false, model:  "", image: "np_gold-coin.png", information: "Check inside for chocolate", deg: false }
itemList["goldrec"]     = {fullyDegrades: false, decayrate: 0.0, displayname: "Gold Record", price: 1, weight: 0, nonStack: false, model: "", image: "np_gold-record.png", information: "500, 000 units sold", deg: false }
itemList["grandtete"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Grand Tete Mince", price: 1, weight: 0, nonStack: false, model: "", image: "np_grand-tete-mince.png", information: "Giacometti 1954", deg: false }
itemList["greekbust"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Greek Bust", price: 150, weight: 0, nonStack: false, model:  "", image: "np_greek-bust.png", information: "You sure its Greek?" , deg: false}
itemList["greenb"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Green Bandana", price: 1, weight: 0, nonStack: false, model:  "", image: "np_green-bandana.png", information: "Ay yo my mans", deg: false }
itemList["greenbelt"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Green Belt", price: 1, weight: 0, nonStack: false, model:  "", image: "np_green-belt.png", information: "Adept Rank 2/4", deg: false }
itemList["greenchip"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Green Chip", price: 1, weight: 0, nonStack: false, model: "", image: "np_green-chip.png", information: "Fold em", deg: false }



itemList["Gruppe6Card"]	= {fullyDegrades: true, illegal: true, craft: [ {itemid: "ciggy", amount: 30 } ], decayrate: 0.003, displayname: "G6 C Card", price: 3500, weight: 0, nonStack: false, model: "", image: "gruppe6.png", information: "Looks handy" , deg: false}
itemList["Gruppe6Card2"] = {fullyDegrades: false, illegal: true, craft: [ {itemid: "assphone", amount: 5 }, {itemid: "methbag", amount: 35 }, {itemid: "ciggy", amount: 150 } ], decayrate: 0.0, displayname: "G6 HS Card", price: 3500, weight: 0, nonStack: false, model: "", image: "gruppe62.png", information: "Looks handy" , deg: false}
itemList["Gruppe6Card22"] = {fullyDegrades: false, illegal: true, craft: [  {itemid: "assphone", amount: 5 }, {itemid: "methbag", amount: 55 }, {itemid: "ciggy", amount: 1000 }  ], decayrate: 0.0, displayname: "G6 V Card", price: 3500, weight: 0, nonStack: false, model: "", image: "gruppe622.png", information: "Looks handy" , deg: false}

itemList["Gruppe6Card222"] = {fullyDegrades: false, illegal: true, craft: [  {itemid: "assphone", amount: 5 }, {itemid: "methbag", amount: 55 }, {itemid: "ciggy", amount: 1000 }  ], decayrate: 0.0, displayname: "G6 V2 Card", price: 3500, weight: 0, nonStack: false, model: "", image: "Gruppe6222.png", information: "Looks handy" , deg: false}


itemList["Gruppe6Card3"] = {fullyDegrades: false, illegal: true, craft: [ {itemid: "assphone", amount: 5 }, {itemid: "methbag", amount: 15 }, {itemid: "ciggy", amount: 30 } ], decayrate: 0.0, displayname: "G6 P Card", price: 3500, weight: 0, nonStack: false, model: "", image: "gruppe63.png", information: "Looks handy" , deg: false}


itemList["gsfpapers"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "GSF Papers", price: 1, weight: 0, nonStack: false, model: "", image: "np_gsf-papers.png", information: "Triple OG approved", deg: false }
itemList["gticket"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Golden Ticket", price: 1, weight: 0, nonStack: false, model: "", image: "np_golden-ticket.png", information: "Ask Coop", deg: false }
itemList["gum"]	        = {fullyDegrades: false, decayrate: 0.0, displayname: "Gum", price: 1, weight: 0, nonStack: false, model:  "", image: "np_gum.png", information: "Release Gum. You chew, you suck then POW", deg: false }
itemList["hairtonic"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Hair Tonic", price: 1, weight: 0, nonStack: false, model: "", image: "np_hair-tonic.png", information: "If youre malding try this", deg: false }
itemList["harness"]     = {fullyDegrades: false, decayrate: 0.0, displayname: "Racing Harness", craft: [{itemid: "rubber", amount: 10 }], price: 10000, weight: 1, nonStack: true, model: "", image: "np_harness.png", information: "Stops you from being YEETED" , deg: false}
itemList["heavycutters"] = {fullyDegrades: false, decayrate: 0.0, displayname: "Heavy Cutters", price: 700, weight: 9, nonStack: false, model: "", image: "np_heavy-cutters.png" , deg: false}
itemList["heavydutydrill"] = {fullyDegrades: false, decayrate: 0.0, displayname: "Heavy Duty Drill", craft: [{itemid: "aluminium", amount: 85 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 300, weight: 5, nonStack: false, model: "", image: "np_heavy-duty-drill.png" , deg: false}
itemList["hlights"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Headlights", price: 1, weight: 0, nonStack: false, model: "", image: "np_headlights.png", information: "Cant detail a car with the cover on", deg: false }
itemList["holybook"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Holy Book", price: 1, weight: 0, nonStack: false, model:  "", image: "np_holy-book.png", information: "For followers only...", deg: false }

itemList["holyhum"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Holy Hummus", price: 1, weight: 0, nonStack: false, model: "", image: "np_holy-hummus.png", information: "Praise be", deg: false }
itemList["homme"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "L'Homme Qui Marche", price: 1, weight: 0, nonStack: false, model: "", image: "np_lhomme-qui-marche.png", information: "Giacometti 1960", deg: false }
itemList["horchata"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Horchata", price: 1, weight: 0, nonStack: false, model: "", image: "np_horchata.png", information: "A la gran puchica!", deg: false }
itemList["icbelt"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Intercontinental Belt", price: 1, weight: 0, nonStack: false, model: "", image: "np_intercontinental-belt.png", information: "Bah gawd!", deg: false }
itemList["idcard"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Căn cước công dân", price: 150, weight: 0, nonStack: true, model: "", image: "np_citizen-card.png" , deg: false}
itemList["IFAK"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "IFAK", price: 100, weight: 0, nonStack: false, model: "", image: "ifak.png", information: "Cầm máu và giảm đau tạm thời." , deg: false}
itemList["inkedmoneybag"] = {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Inked Money Bag", price: 100000, weight: 35, nonStack: false, model: "", image: "np_inked-money-bag.png", information: "This belongs to the Vault Bank" , deg: false}
itemList["inkset"]	    = {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Inked Set", price: 500, weight: 15, nonStack: false, model: "", image: "np_inked-money-bag.png" , deg: false}
itemList["ironoxide"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Iron Oxide", price: 50, weight: 1, nonStack: false, model: "", image: "np_iron-oxide.png" , deg: false}
itemList["jadeite"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Jadeite Stone", price: 1, weight: 0, nonStack: false, model:  "", image: "np_jadeite-stone.png", information: "With envy", deg: false }
itemList["joker"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Joker Card", price: 1, weight: 0, nonStack: false, model:  "", image: "np_joker.png", information: "How bout a magic trick?", deg: false }
itemList["katana"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Katana", price: 1, weight: 0, nonStack: false, model: "", image: "np_katana.png", information: "Steel folded over 1000 times", deg: false }
itemList["key1"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Key 1", price: 1, weight: 0, nonStack: false, model:  "", image: "np_key1.png", information: "Numbered Key", deg: false }
itemList["key2"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Key 2", price: 1, weight: 0, nonStack: false, model:  "", image: "np_key2.png", information: "Numbered Key", deg: false }
itemList["key3"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Key 3", price: 1, weight: 0, nonStack: false, model:  "", image: "np_key3.png", information: "Numbered Key", deg: false }
itemList["keya"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Key A", price: 1, weight: 0, nonStack: false, model:  "", image: "np_keya.png", information: "Lettered Key", deg: false }
itemList["keyb"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Key B", price: 1, weight: 0, nonStack: false, model:  "", image: "np_keyb.png", information: "Lettered Key", deg: false }
itemList["keyc"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Key C", price: 1, weight: 0, nonStack: false, model:  "", image: "np_keyc.png", information: "Lettered Key", deg: false }
itemList["latte"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Latte", price: 1, weight: 0, nonStack: false, model:  "", image: "np_latte.png", information: "Thats so fetch", deg: false }
itemList["lbpapers"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "LB Papers", price: 1, weight: 0, nonStack: false, model: "", image: "np_lb-papers.png", information: "I plead guilty mon", deg: false }
itemList["lighter"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bật lửa", price: 10, weight: 0,   nonStack: false, model: "", image: "np_lighter.png", information: "", deg: false}
itemList["lockpick"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bộ Lockpick", craft: [{itemid: "plastic", amount: 5 }, {itemid: "copper", amount: 5 }, {itemid: "scrapmetal", amount: 5 }], price: 150, weight: 1, nonStack: false, model: "", image: "np_lockpick-set.png" , deg: false}
itemList["locksystem"]	= {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Air Pressure Lockpick", price: 3500, weight: 0, nonStack: false, model: "", image: "locksystem.png", information: "Used to blow out small locks - one time use." , deg: false}
itemList["log"]	        = {fullyDegrades: false, decayrate: 0.0, displayname: "Gỗ thô", price: 10, weight: 2, nonStack: false, model: "", image: "np_fishinglog.png" , deg: false}
itemList["logger"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Logger Beer", price: 100, weight: 0, nonStack: false, model: "", image: "np_logger-beer.png", information: "Ming Ha Ling Bev. 2013", deg: false, esxuse: true }

itemList["lostcut"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter", deg: false }
itemList["lostcut_aw"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Al Weaselton", deg: false }
itemList["lostcut_cc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Cooch Cassidy", deg: false }
itemList["lostcut_cs"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Catherine Scratch", deg: false }
itemList["lostcut_ga"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Gary Adams", deg: false }
itemList["lostcut_gm"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Gazza Maloo", deg: false }
itemList["lostcut_gs"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Greyson Sparks", deg: false }
itemList["lostcut_jp"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Jason Paul", deg: false }
itemList["lostcut_ng"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Negan Graham", deg: false }
itemList["lostcut_rc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Reginald Campbell", deg: false }
itemList["lostcut_rd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Reid Dankleaf", deg: false }
itemList["lostcut_rr"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Rudi Rinsen", deg: false }
itemList["lostcut_so"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Samuel O'Faolain", deg: false }
itemList["lostcut_vm"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Victor Mason", deg: false }
itemList["lostcut_wd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Wyatt Derp", deg: false }
itemList["lostcut_gt"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of George Temple", deg: false }
itemList["lostcut_ww"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Wade Willson", deg: false }
itemList["lostcut_hm"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Holden Maloo", deg: false }
itemList["lostcut_tr"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Taran Raid", deg: false }
itemList["lostcut_dw"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />In honor of Denzel Washington", deg: false }
itemList["lostcut_cd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Lost MC Cut", price: 1, weight: 0, nonStack: false, model:  "", image: "np_lost-cut.png", information: "Sandy Shores Chapter<br />Property of Cherry Divine", deg: false }

itemList["lostpapers"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Lost MC Papers", price: 1, weight: 0, nonStack: false, model: "", image: "np_lost-papers.png", information: "Does not work with meth", deg: false }
itemList["lotion"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Hand Lotion", price: 1, weight: 0, nonStack: false, model:  "", image: "np_hand-lotion.png", information: "My hands are dry I swear", deg: false }
itemList["lspapers"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "LS Papers", price: 1, weight: 0, nonStack: false, model: "", image: "np_ls-papers.png", information: "The city with the safest banks", deg: false }
itemList["madamelr"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Madame LR", price: 1, weight: 0, nonStack: false, model: "", image: "np_madame-lr.png", information: "Brancusi 1918", deg: false }
itemList["maneki"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Maneki Neko", price: 1, weight: 0, nonStack: false, model:  "", image: "np_maneki-neko.png", information: "Good fortune beckons", deg: false }
itemList["markedbills"]	= {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Marked Bills", price: 300, weight: 1, nonStack: false, model: "", image: "np_inked-money-bag.png" , deg: false}
itemList["martini"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Martini", price: 100, weight: 1, nonStack: false, model: "", image: "np_martini.png", information: "Shaken, not stirred", deg: false, esxuse: true }
itemList["mdiptych"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Marilyn Diptych", price: 1, weight: 0, nonStack: false, model: "", image: "np_marilyn-diptych.png", information: "Warhol 1962", deg: false }
itemList["MedicalBag"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Medical Bag", price: 10, weight: 5, nonStack: false, model: "", image: "np_medbag.png", information: "Dùng để cứu thương" , deg: false}
itemList["mfalcon"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Maltese Falcon", price: 150, weight: 0, nonStack: false, model:  "", image: "np_maltese-falcon.png", information: "Highly prized movie prop" , deg: false}
itemList["misfit"]      = {fullyDegrades: false,  decayrate: 0.0, displayname: "Headphones", price: 1, weight: 0, nonStack: false, model: "", image: "np_headphones.png", information: "We out here cuh", deg: false }
itemList["mixtape"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Mixtape", price: 1, weight: 0, nonStack: false, model:  "", image: "np_mixtape.png", information: "Check it, yo", deg: false }
itemList["mk2usbdevice"] = {fullyDegrades: false, decayrate: 0.0, displayname: "MKII USB Device", price: 300, weight: 5, nonStack: false, model: "", image: "np_mkii-usb-device.png" , deg: false}
itemList["phone"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Điện thoại", price: 200, weight: 1, nonStack: false, model: "", image: "np_mobile-phone.png" , deg: false}

itemList["moonshine"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Moonshine Jug", price: 1, weight: 0, nonStack: false, model: "", image: "np_moonshine-jug.png", information: "Using the same jugs since 1910", deg: false }
itemList["moonshinej"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Moonshine Jar", price: 1, weight: 0, nonStack: false, model: "", image: "np_jar-of-moonshine.png", information: "Almost paint thinner", deg: false }
itemList["mtrophy"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Mic Trophy", price: 1, weight: 0, nonStack: false, model: "", image: "np_mic-trophy.png", information: "A star is born", deg: false }
itemList["muffin"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Muffin", price: 1, weight: 0, nonStack: false, model:  "", image: "np_muffin.png", information: "Is your muffin buttered?", deg: false }
itemList["mugbeer"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Mug of Beer", price: 100, weight: 1, nonStack: false, model: "", image: "np_mug-of-beer.png", information: "Cheers!", deg: false, esxuse: true }
itemList["mvial"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Mysterious Vial", price: 1, weight: 0, nonStack: false, model:  "", image: "np_mysterious-vial.png", information: "Do not drink", deg: false }
itemList["nachos"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Nachos", price: 1, weight: 0, nonStack: false, model: "", image: "np_nachos.png", information: "Delicioso", deg: false }


itemList["nmenu"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Nanakaze Menu", price: 1, weight: 0, nonStack: false, model: "", image: "np_nanakaze-menu.png", information: "Take a look feller", deg: false }
itemList["no10"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "No. 10", price: 1, weight: 0, nonStack: false, model: "", image: "np_no10.png", information: "Rothko 1950", deg: false }
itemList["no5"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "No. 5", price: 1, weight: 0, nonStack: false, model: "", image: "np_no5.png", information: "Pollock 1948", deg: false }
itemList["oil"]	        = {fullyDegrades: false, decayrate: 0.0, displayname: "Oil", price: 10, weight: 0, nonStack: false, model: "", image: "np_oil.png" , deg: false}
itemList["okaylockpick"] = {fullyDegrades: false, decayrate: 0.0, displayname: "Not-Shit Ass Lockpick", price: 0, craft: [ {itemid: "shitlockpick", amount: 100 } ], weight: 0, nonStack: false, model: "", image: "np_shitlockpick.png", information: "TBH its still shit, so shit its almost identical... almost.", deg: false } //'Heavy Shotgun'
itemList["onigiri"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Onigiri", price: 1, weight: 0, nonStack: false, model:  "", image: "np_onigiri.png", information: "Delicious rice balls", deg: false }
itemList["onion"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Onion", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model:  "", image: "np_onion.png", information: "Are your eyes watering?" , deg: false}
itemList["oxygentank"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Oxygen Tank", craft: [{itemid: "aluminium", amount: 15 }, {itemid: "plastic", amount: 15 }, {itemid: "rubber", amount: 10 }], price: 300, weight: 1, nonStack: false, model: "", image: "np_oxygen-tank.png" , deg: false}
itemList["pallet"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Pallet of Boxes", price: 150, weight: 0, nonStack: false, model:  "", image: "np_pallet-of-boxes.png", information: "Transportable goods" , deg: false}
itemList["passtest"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Passed Test", price: 1, weight: 0, nonStack: false, model:  "", image: "np_passed-test.png", information: "Excellent work", deg: false }
itemList["paynepic"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Portrait of Payne", price: 1, weight: 0, nonStack: false, model: "", image: "np_payne-portrait.png", information: "Cue tongue pop", deg: false }
itemList["pearlneck"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Pearl Necklace", price: 150, weight: 0, nonStack: false, model:  "", image: "np_dragon", information: "Good way to finish a date" , deg: false}
itemList["pegg"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Pink Faberge Egg", price: 1, weight: 0, nonStack: false, model: "", image: "np_pink-faberge-egg.png", information: "Faberge Series (3/3)", deg: false }
itemList["petchicken"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Pet Chicken", price: 1, weight: 0, nonStack: false, model: "", image: "np_pet-chicken.png", information: "Careful around Cluckin Bell", deg: false }
itemList["petfish"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Pet Fish", price: 1, weight: 0, nonStack: false, model:  "", image: "np_pet-fish.png", information: "Gold fish memory", deg: false }
itemList["petrock"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Pet Rock", price: 1, weight: 0, nonStack: false, model:  "", image: "np_pet-rock.png", information: "You dont even have to feed it", deg: false }
itemList["petturtle"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Pet Turtle", price: 1, weight: 0, nonStack: false, model: "", image: "np_pet-turtle.png", information: "Cowabunga", deg: false }

itemList["pix1"]	    = {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Pixerium Stick Small", price: 300, weight: 0, nonStack: false, model: "", image: "np_decrypter-fv2.png" , deg: false}
itemList["pix2"]	    = {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Pixerium Stick Large", price: 1000, weight: 0, nonStack: false, model: "", image: "np_decrypter-enzo.png" , deg: false}

itemList["platinumrec"] = {fullyDegrades: false, decayrate: 0.0, displayname: "Platinum Record", price: 1, weight: 0, nonStack: false, model: "", image: "np_platinum-record.png", information: "1 Million units sold!", deg: false }
itemList["popsicle"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Popsicle", price: 1, weight: 0, nonStack: false, model:  "", image: "np_popsicle.png", information: "Is that sea salt?", deg: false }
itemList["portal"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Portal", price: 1, weight: 0, nonStack: false, model: "", image: "np_portal.png", information: "Paden 2012", deg: false }
itemList["ppapers"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Prison Papers", price: 1, weight: 0, nonStack: false, model: "", image: "np_prison-papers.png", information: "Dont ask where its been...", deg: false }
itemList["pupusas"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Pupusas", price: 1, weight: 0, nonStack: false, model: "", image: "np_pupusas.png", information: "Mas curtido vos", deg: false }
itemList["purpleb"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Purple Bandana", price: 1, weight: 0, nonStack: false, model:  "", image: "np_purple-bandana.png", information: "Straight outta da cul-de-sac", deg: false }
itemList["qhearts"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Queen of Hearts", price: 1, weight: 0, nonStack: false, model: "", image: "np_queen-of-hearts.png", information: "Off with their heads!", deg: false }
itemList["qualityscales"]	= {fullyDegrades: true, decayrate: 1.0, displayname: "Cân điện tử", craft: [{itemid: "steel", amount: 5 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 10 }, {itemid: "electronics", amount: 25 }], price: 2000, weight: 2, nonStack: false, model: "", image: "np_high-quality-scales.png", information: "Cân với sai số cực thấp" , deg: false}
itemList["radio"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bộ đàm", craft: [{itemid: "electronics", amount: 40 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 5 }], price: 1000, weight: 3, nonStack: false, model: "", image: "np_radio.png", information: "Dùng để liên lạc với người khác bằng các kênh riêng." , deg: false}
itemList["rbumper"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Rear Bumper", price: 1, weight: 0, nonStack: false, model: "", image: "np_rear-bumper.png", information: "You owe me a ten second car", deg: false }
itemList["recoupon10"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "10% Off Deal", price: 1, weight: 0, nonStack: false, model:  "", image: "np_recoupon10.png", information: "May not be used for drugs" , deg: false}
itemList["recoupon15"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "15% Off Deal", price: 1, weight: 0, nonStack: false, model:  "", image: "np_recoupon15.png", information: "We are not liable for any raids or robberies" , deg: false}
itemList["recoupon20"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "20% Off Deal", price: 1, weight: 0, nonStack: false, model:  "", image: "np_recoupon20.png", information: "May or may not be exchanged for a hug from Mr. Payne" , deg: false}
itemList["recoupon5"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "5% Off Deal", price: 1, weight: 0, nonStack: false, model:  "", image: "np_recoupon5.png", information: "Southside shootings are complimentary", deg: false }
itemList["recyclablematerial"]	= {fullyDegrades: true, decayrate: 0.03, displayname: "Vật liệu tái chế", price: 20, weight: 1, nonStack: false, model: "", image: "np_recyclable-material.png" , deg: false}
itemList["redb"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Red Bandana", price: 1, weight: 0, nonStack: false, model:  "", image: "np_red-bandana.png", information: "Lean with me", deg: false }
itemList["redbelt"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Red Belt", price: 1, weight: 0, nonStack: false, model:  "", image: "np_red-belt.png", information: "Expert Rank 3/4", deg: false }
itemList["redchip"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Red Chip", price: 1, weight: 0, nonStack: false, model: "", image: "np_red-chip.png", information: "Calling your bluff", deg: false }
itemList["redpack"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Bao thuốc lá", price: 150, weight: 0, nonStack: false, model: "", image: "np_redwood-pack.png", information: "Một bao thuốc", deg: false }
itemList["refinedwood"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Gỗ tinh luyện", price: 15, weight: 12, nonStack: false, model: "", image: "np_wood.png" , deg: false}
itemList["repairtoolkit"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Repair Toolkit", craft: [{itemid: "aluminium", amount: 5 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 50, weight: 15, nonStack: false, model: "", image: "np_repair-toolkit.png", information: "Used by Tow Truck drivers and repair people." , deg: false}
itemList["riflebody"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Thân súng trường", price: 70, weight: 10, nonStack: false, model: "", image: "np_rifle-body.png" , deg: false}
itemList["riflebodybox"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Box (10+ Rifle Bodys)", price: 200, weight: 85, nonStack: false, model: "", image: "np_rifle-box.png" , deg: false}
itemList["rims"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Racing Rims", price: 150, weight: 0, nonStack: false, model:  "", image: "np_racing-rims.png", information: "Best rims for the job" , deg: false}
itemList["rnovel"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Romance Novel", price: 150, weight: 0, nonStack: false, model:  "", image: "np_romance-novel.png", information: "A hurricane of passion" , deg: false}
itemList["rolexwatch"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Đồng hồ Rolex", price: 5, weight: 1, nonStack: false, model: "", information: "Đồng hồ thụy sỹ Cao cấp và mắc tiền" ,image: "np_rolex-watch.png" , deg: false}
itemList["rollingpaper"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Giấy cuốn", price: 1, weight: 0, nonStack: false, model: "", image: "np_rolling-paper.png", information: "Cần để cuốn!" , deg: false}
itemList["rooster"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Rooster Pin", price: 1, weight: 0, nonStack: false, model:  "", image: "np_rooster-pin.png", information: "With egg in hand...", deg: false }
itemList["rose"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Rose", price: 1, weight: 0, nonStack: false, model:  "", image: "np_rose.png", information: "Cue dramatic monologue", deg: false }

itemList["rtrophy"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Racing Trophy", price: 1, weight: 0, nonStack: false, model: "", image: "np_racing-trophy.png", information: "All I do is win", deg: false }
itemList["ruby"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Ruby", price: 1, weight: 0, nonStack: false, model:  "", image: "np_ruby.png", information: "Like a sunrise", deg: false }
itemList["russian"]     = {fullyDegrades: false, decayrate: 0.0, displayname: "Matryoshka Doll", price: 1, weight: 0, nonStack: false, model: "", image: "np_matryoshka-doll.png", information: "If he dies, he dies, cyka.", deg: false }
itemList["sake"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Sake", price: 400, weight: 1, nonStack: false, model:  "", image: "np_sake.png", information: "Kampai!", deg: false, esxuse: true }
itemList["brandy"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Brandy", price: 250, weight: 1, nonStack: false, model:  "", image: "np_brandy.png", information: "Eau de vie !", deg: false, esxuse: true }
itemList["cognac"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Cognac", price: 250, weight: 1, nonStack: false, model:  "", image: "np_cognac.png", information: "à la part des anges !", deg: false, esxuse: true }
itemList["richardhennessy"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Hennessy Richard", price: 300, weight: 1, nonStack: false, model:  "", image: "np_richard.png", information: "", deg: false, esxuse: true }


itemList["sbsxray"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "SBS X-Ray", price: 1, weight: 0, nonStack: false, model:  "", image: "np_sbs-xray.png", information: "Warlord size", deg: false }
itemList["scanner"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Radio Scanner", craft: [{itemid: "aluminium", amount: 5 }, {itemid: "plastic", amount: 1 }, {itemid: "rubber", amount: 1 }], price: 500, weight: 15, nonStack: false, model: "", image: "np_radio-scanner.png", information: "Used to receive random radio chatter." , deg: false}
itemList["scissors"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Scissors", price: 1, weight: 0, nonStack: false, model: "", image: "np_scissors.png", information: "Fuck me up fam", deg: false }
itemList["scoin"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Gold Coin", price: 1, weight: 0, nonStack: false, model: "", image: "np_secret-coin.png", information: "Ens causa sui", deg: false }

itemList["screen"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Screen", price: 120, weight: 1, nonStack: false, model: "", image: "np_screen.png" , deg: false}
itemList["scripted"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Script", price: 1, weight: 0, nonStack: false, model:  "", image: "np_script.png", information: "Scripted? Reee", deg: false }
itemList["sealedbucket"]	= {fullyDegrades: false, price: 5, decayrate: 0.0, displayname: "Sealed Bucket", weight: 1, nonStack: true, model: "", image: "np_sealed-bucket.png" , deg: false}
itemList["sealedevidencebag"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Túi chứa mẫu vật", price: 0, weight: 0, nonStack: true, model: "", image: "np_sealed-evidence-bag.png" , deg: false}
itemList["seat"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Seat", price: 150, weight: 0, nonStack: false, model:  "", image: "np_seat.png", information: "Only for the most hardcore of racers" , deg: false}
itemList["secretfile"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Secret File", price: 1, weight: 0, nonStack: false, model:  "", image: "np_secret-file.png", information: "High level clearance required", deg: false }
itemList["securityblack"]	= {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Security Card", price: 1500,   weight: 1, nonStack: false, model: "", image: 'cblk.png', information: "Some sort of security card..", deg: false}
itemList["securityblue"]	= {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Security Card", price: 1500,   weight: 1, nonStack: false, model: "", image: 'cb.png', information: "Some sort of security card..", deg: false}
itemList["SecurityCase"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Security Case", price: 350, weight: 0, nonStack: false, model: "", image: "np_securitycase.png", information: "Its a prop, wow?" , deg: false}
itemList["securitygold"]	= {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Security Card", price: 1500,   weight: 1, nonStack: false, model: "", image: 'cgld.png', information: "Some sort of security card..", deg: false}
itemList["securitygreen"]	= {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Security Card", price: 1500,   weight: 1, nonStack: false, model: "", image: 'cg.png', information: "Some sort of security card..", deg: false}
itemList["securityred"]	= {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Security Card", price: 1500,   weight: 1, nonStack: false, model: "", image: 'cr.png', information: "Some sort of security card..", deg: false}
itemList["sfinger"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Severed Finger", price: 1, weight: 0, nonStack: false, model: "", image: "np_severed-finger.png", information: "Now we're even", deg: false }
itemList["sgrace"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Saying Grace", price: 1, weight: 0, nonStack: false, model: "", image: "np_saying-grace.png", information: "Rockwell 1951", deg: false }
itemList["shampoo"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Shampoo", price: 1, weight: 0, nonStack: false, model: "", image: "np_shampoo.png", information: "Full of body and volume", deg: false }
itemList["shearsoj"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Shears of Justice", price: 1, weight: 0, nonStack: false, model: "", image: "np_shears-of-justice.png", information: "Justice prevails", deg: false }
itemList["shipbox"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Shipping Box", price: 150, weight: 0, nonStack: false, model:  "", image: "np_shipping-box.png", information: "Free 2day shipping" , deg: false}
itemList["shipcrate"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Shipping Crate", price: 150, weight: 0, nonStack: false, model:  "", image: "np_shipping-crate.png", information: "This side up" , deg: false}
itemList["shitlockpick"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Ass Lockpick", price: 0, craft: [ {itemid: "jailfood", amount: 1 } ], weight: 1, nonStack: false, model: "", image: "np_shitlockpick.png", information: "-5 Jail <br> -3 Strength <br> +3 Intelligence <br> Why the fuck is this so heavy? CoPixel das why. <br> If it has roleplay stats, it must be roleplay.", deg: false } //'Heavy Shotgun'
itemList["silvercoin"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Silver Coin", price: 1, weight: 0, nonStack: false, model:  "", image: "np_silver-coin.png", information: "Dont lose it", deg: false }
itemList["slushy"]	    = {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "The best slushy ever.", price: 0, weight: 15, nonStack: false, model: "", image: "np_slushy.png", information: "-5 Jail <br> +5 Charisma <br> The only thing in Jail that tastes good. <br> If it has roleplay stats, it must be roleplay. " , deg: false}
itemList["smirror"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Side Mirror", price: 1, weight: 0, nonStack: false, model: "", image: "np_side-mirror.png", information: "On green, I'm going for it", deg: false }

itemList["snowpic"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Photo of Snow", price: 1, weight: 0, nonStack: false, model:  "", image: "np_snow-photo.png", information: "My beloved Jacqueline Snow", deg: false }
itemList["snowvhs"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "The Ultimate Boomer", price: 1, weight: 0, nonStack: false, model:  "", image: "np_snow-vhs.png", information: "Filmed On the Samsung flip phone from 2003 this high quality boomer production value will have you questioning.... Is that a dick?", deg: false }
itemList["sound"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Hệ thống âm thanh", price: 150, weight: 0, nonStack: false, model:  "", image: "np_sound-system.png", information: "Makes your ears bleed" , deg: false}
itemList["sozepic"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Photo of Soze", price: 1, weight: 0, nonStack: false, model: "", image: "np_soze-photo.png", information: "The State PO-lice's finest", deg: false }
itemList["spoiler"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Spoiler", price: 150, weight: 0, nonStack: false, model:  "", image: "np_spoiler.png", information: "Quarter mile at a time" , deg: false}
itemList["sprunk"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Sprunk", price: 1, weight: 0, nonStack: false, model:  "", image: "np_sprunk.png", information: "The Essence of Life", deg: false }
itemList["sskirts"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Side Skirts", price: 1, weight: 0, nonStack: false, model: "", image: "np_side-skirts.png", information: "Ride or die, remember?", deg: false }
itemList["stolen10ctchain"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "10ct Gold Chain (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_10ct-gold-chain.png" , deg: false}
itemList["stolen2ctchain"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "2ct Gold Chain (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_2ct-gold-chain.png" , deg: false}
itemList["stolen5ctchain"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "5ct Gold Chain (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_5ct-gold-chain.png" , deg: false}
itemList["stolen8ctchain"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "8ct Gold Chain (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_8ct-gold-chain.png" , deg: false}
itemList["stolencasiowatch"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Casio Watch (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_casio-watch.png" , deg: false}
itemList["stolengameboy"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Gameboy (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_gameboy.png" , deg: false}
itemList["stoleniphone"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Apple Iphone (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_apple-iphone.png" , deg: false}
itemList["stolennokia"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Nokia Phone (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_nokia-phone.png" , deg: false}
itemList["stolenoakleys"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Oakley Sunglasses (p)", price: 8, weight: 0, nonStack: false, model: "", image: "np_oakley-sunglesses.png" , deg: false}
itemList["stolenpixel3"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Pixel 3 Phone (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_pixel-2-phone.png" , deg: false}
itemList["stolenpsp"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "PSP (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_psp.png" , deg: false}
itemList["stolenraybans"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Ray Ban Sunglasses (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_raybans.png" , deg: false}
itemList["stolens8"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Samsung S8 (p)", price: 5, weight: 0, nonStack: false, model: "", image: "np_samsung-s8.png" , deg: false}
itemList["stooth"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Shark Tooth", price: 1, weight: 0, nonStack: false, model: "", image: "np_shark-tooth.png", information: "Gonna need a bigger boat", deg: false }
itemList["Suitcase"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Suitcase", price: 350, weight: 0, nonStack: false, model: "", image: "np_suitcase.png", information: "Its a prop, wow?" , deg: false}
itemList["sunflower"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Sunflower", price: 1, weight: 0, nonStack: false, model: "", image: "np_sunflower.png", information: "Super effective vs zombies", deg: false }
itemList["swheel"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Steering Wheel", price: 1, weight: 0, nonStack: false, model:  "", image: "np_steering-wheel.png", information: "Winning is winning...", deg: false }
itemList["tagbelt"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Tag Team Belt", price: 1, weight: 0, nonStack: false, model: "", image: "np_tag-team-belt.png", information: "Off the turbuckle", deg: false }
itemList["tbag"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Transport Bag", price: 1, weight: 0, nonStack: false, model: "", image: "np_transport-bag.png", information: "Keeping your organs fresh", deg: false }
itemList["tbear"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Teddy Bear", price: 1, weight: 0, nonStack: false, model: "", image: "np_teddy-bear.png", information: "Hug me", deg: false }
itemList["tealb"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Teal Bandana", price: 1, weight: 0, nonStack: false, model:  "", image: "np_teal-bandana.png", information: "Simon ese", deg: false }
itemList["telvis"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Triple Elvis", price: 1, weight: 0, nonStack: false, model: "", image: "np_triple-elvis.png", information: "Warhol 1963", deg: false }
itemList["textbooka"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Textbook A", price: 1, weight: 0, nonStack: false, model:  "", image: "np_textbook-a.png", information: "Buy new of course", deg: false }
itemList["thermite"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Thermite", craft: [{itemid: "aluminium", amount: 10 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 10 }], price: 0, weight: 5, nonStack: false, model: "", image: "np_thermite.png" , deg: false}
itemList["ticket"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Ticket", price: 1, weight: 0, nonStack: false, model:  "", image: "np_ticket.png", information: "Admit one", deg: false }
itemList["tire"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Tire", price: 150, weight: 0, nonStack: false, model:  "", image: "np_tire.png", information: "Im going to get another set" , deg: false}
itemList["tissuebox"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Box of Tissues", price: 1, weight: 0, nonStack: false, model:  "", image: "np_tissue-box.png", information: "Not what it seems I swear", deg: false }
itemList["Toolbox"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Toolbox", price: 350, weight: 0, nonStack: false, model: "", image: "np_toolbox.png", information: "Its a prop, wow?" , deg: false}
itemList["toothneck"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Tooth Necklace", price: 1, weight: 0, nonStack: false, model:  "", image: "np_tooth-necklace.png", information: "Shes a beauty", deg: false }
itemList["trophy"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Trophy", price: 1, weight: 0, nonStack: false, model:  "", image: "np_trophy.png", information: "Winner!", deg: false }

itemList["boomerphone"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Boomer Phone", price: 5, weight: 0, nonStack: false, model: "", image: "np_boomerphone.png", information: "Made for boomers, extra large buttons and screen." , deg: false}


itemList["umbrella"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Cây dù", price: 500, weight: 3, nonStack: false, model: "", image: "np_umbrella.png" , deg: false}
itemList["umetal"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Unknown Metal", price: 1, weight: 0, nonStack: false, model: "", image: "np_unknown-metal.png", information: "Dont lick your fingers", deg: false }

itemList["usbdevice"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Unknown USB Device", price: 300, weight: 5, nonStack: false, model: "", image: "np_unknown-usb-device.png" , deg: false}
itemList["valuablegoods"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Valuable Goods", craft: [{itemid: "goldbar", amount: 7 }], price: 4000, weight: 4, nonStack: false, model: "", image: "np_valuable-goods.png" , deg: false}
itemList["viagra"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Viagra", price: 1, weight: 0, nonStack: false, model:  "", image: "np_viagra.png", information: "Magic little blue pill", deg: false }
itemList["voodoo"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Voodoo Doll", price: 1, weight: 0, nonStack: false, model:  "", image: "np_voodoo-doll.png", information: "Beware the spirits", deg: false }
itemList["vpapers"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Vagos Papers", price: 1, weight: 0, nonStack: false, model: "", image: "np_vagos-papers.png", information: "No prrrraaaaaablem", deg: false }
itemList["vpnxj"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "VPN XJ", price: 300, weight: 5, nonStack: false, model: "", image: "np_vpn-xj.png" , deg: false}
itemList["vulture"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Vulture Statue", price: 1, weight: 0, nonStack: false, model: "", image: "np_vulture-statue.png", information: "For the culture", deg: false }
itemList["wallet"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Wallet", price: 150, weight: 0, nonStack: false, model:  "", image: "np_wallet.png", information: "Includes picture of mom" , deg: false}
itemList["watch"]       = {fullyDegrades: false, decayrate: 0.0, displayname: "Watch", price: 1000, weight: 0, nonStack: false, model: "", image: "np_watch.png", information: "It's a Watch", deg: false}
itemList["wedding"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Wedding Ring", price: 150, weight: 0, nonStack: false, model:  "", image: "np_wedding-ring.png", information: "Did you know fifty percent..." , deg: false}
itemList["weeping"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Weeping Woman", price: 1, weight: 0, nonStack: false, model:  "", image: "np_weeping-woman.png", information: "Picasso 1937", deg: false }
itemList["wglass"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Glass of Whiskey", price: 50, weight: 1, nonStack: false, model: "", image: "np_glass-of-whiskey.png", information: "On the rocks", deg: false, esxuse: true }
itemList["whitebelt"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "White Belt", price: 1, weight: 0, nonStack: false, model:  "", image: "np_white-belt.png", information: "Novice Rank 1/4", deg: false }
itemList["whitechip"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "White Chip", price: 1, weight: 0, nonStack: false, model: "", image: "np_white-chip.png", information: "Hit me", deg: false }
itemList["whitepearl"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "White Pearl", price: 0, weight: 1, nonStack: false, model: "", image: "np_white-pearl.png" , deg: false}
itemList["whitewine"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "White Wine", price: 500, weight: 0, nonStack: false, model:  "", image: "np_white-wine-bottle.png", information: "Made from real crime free grapes", deg: false, esxuse: true }
itemList["wineglass"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Glass of Wine", price: 1, weight: 0, nonStack: false, model:  "", image: "np_glass-wine.png", information: "Quite exquisite", deg: false }

itemList["xscondom"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "XSmall Condom", price: 150, weight: 0, nonStack: false, model:  "", image: "np_xs-condom.png", information: "Its the motion in the ocean" , deg: false}
itemList["ydiamond"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Yellow Diamond", price: 1, weight: 0, nonStack: false, model:  "", image: "np_yellow-diamond.png", information: "Forever", deg: false }
itemList["yellowb"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Yellow Bandana", price: 1, weight: 0, nonStack: false, model:  "", image: "np_yellow-bandana.png", information: "Im tellin you", deg: false }
itemList["zebra"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Zebra", price: 1, weight: 0, nonStack: false, model: "", image: "np_zebra.png", information: "Vasarely 1937", deg: false }
itemList["fakesnowvhs"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bootleg Boomer", price: 1, weight: 0, nonStack: false, model:  "", image: "np_fake-snow-vhs.png", information: "At this point you can not even tell if it is a dick or the roundhay garden scene from 1888.", deg: false }
itemList["wigglue"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Wig glue", price: 1, weight: 0, nonStack: false, model:  "", image: "np_wig-glue.png", information: "Recommended by Snow.", deg: false }
itemList["marstonrevolver"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "John Marston's Cattleman Revolver", price: 1, weight: 0, nonStack: false, model:  "", image: "np_marston-revolver.png", information: "Owned by John Marston, this Cattleman Revolver features a black steel frame inlaid with gold and a custom bone grip.", deg: false }
itemList["cloak"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Cloak", price: 1, weight: 0, nonStack: false, model:  "", image: "np_cloak.png", information: "Only to be used for some cloak and dagger shit by NoPixel management.", deg: false }


// Event items
itemList["Bankbox"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bank Box", price: 1, weight: 10, nonStack: false, model:  "", image: "np_bankbox.png", information: "A locked bank box.", deg: false }
itemList["Bankboxkey"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Briefcase Key", price: 1, weight: 1, nonStack: false, model:  "", image: "np_bankboxkey.png", information: "A key that seems to fit somewhere.", deg: false }
itemList["Heirloom"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Family Heirloom", price: 1, weight: 0, nonStack: false, model:  "", image: "np_heirloom.png", information: "Ring with a weird emblem carved in to it.", deg: false }
itemList["Hobonickel1"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Hobonickel", price: 1, weight: 0, nonStack: false, model:  "", image: "np_hobonickel1.png", information: "A fancy looking coin. Maybe you should keep this on your person.", deg: false }
itemList["Hobonickel2"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Hobonickel", price: 1, weight: 0, nonStack: false, model:  "", image: "np_hobonickel2.png", information: "A fancy looking coin. Maybe you should keep this on your person.", deg: false }
itemList["Hobonickel3"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Hobonickel", price: 1, weight: 0, nonStack: false, model:  "", image: "np_hobonickel3.png", information: "A fancy looking coin. Maybe you should keep this on your person.", deg: false }
itemList["Routemap"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Route Map", price: 1, weight: 0, nonStack: false, model:  "", image: "np_routemap.png", information: "A map that is showing you the way.", deg: false }
itemList["Securebriefcase"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Secure Briefcase", price: 1, weight: 10, nonStack: false, model:  "", image: "np_securebriefcase.png", information: "A Briefcase that only a handful of people can open.", deg: false }
itemList["Securitykey"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Security Key", price: 1, weight: 0, nonStack: false, model:  "", image: "np_securitykey.png", information: "And interesting looking key. Does not seem to fit in a lock.", deg: false }
itemList["Largesupplycrate"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Large Supply crate", price: 1, weight: 150, nonStack: true, model:  "", image: "np_supplycrate_large.png", information: "A very big and heavy crate.", deg: false }
itemList["Mediumsupplycrate"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Medium Supply crate", price: 1, weight: 100, nonStack: true, model:  "", image: "np_supplycrate_medium.png", information: "A semi-heavy crate.", deg: false }
itemList["Smallsupplycrate"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Small Supply crate", price: 1, weight: 50, nonStack: true, model:  "", image: "np_supplycrate_small.png", information: "A smaller crate that doesn't have much weight to it.", deg: false }

itemList["foodsupplycrate"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Food Supply crate", price: 1, weight: 50, nonStack: true, model:  "", image: "np_supplycrate_medium.png", information: "Special delivery for Siz Fulker!", deg: false }

//Human parts
itemList["bodybag"]	        = {fullyDegrades: true, decayrate: 0.5, displayname: "Bọc khả nghi", price: 1, weight: 100, nonStack: true, model:  "", image: "np_bodybag.png", information: "Một cái bọc khả nghi nhìn giống bên trong có chứa một người?", deg: false }
itemList["bodygarbagebag"]  = {fullyDegrades: true, decayrate: 0.2, displayname: "Bọc rác (có máu)", price: 1, weight: 50, nonStack: true, model:  "", image: "np_bodygarbagebag.png", information: "Một túi rác có vết máu quanh đó. Không biết bên trong có gì?", deg: false }
itemList["organcooler"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Organ Cooler", price: 1, weight: 5, nonStack: true, model:  "", image: "np_organcooler.png", information: "Organ cooler? I wonder what it contains!", deg: false }
itemList["organcooleropen"] = {fullyDegrades: false, decayrate: 0.0, displayname: "Open Organ Cooler", price: 1, weight: 3, nonStack: true, model:  "", image: "np_organcooler.png", information: "An empty organ cooler. Where is the content?", deg: false }
itemList["humanbody"]	    = {fullyDegrades: true, decayrate: 2.0, displayname: "Human Corpse", price: 1, weight: 100, nonStack: true, model:  "", image: "np_humanbody.png", information: "A human corpse. How long has this been here?", deg: false }
itemList["humanhead"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Severed Head", price: 1, weight: 7, nonStack: true, model:  "", image: "np_humanhead.png", information: "A bloody severed head.", deg: false }
itemList["humantorso"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Severed Torso", price: 1, weight: 15, nonStack: true, model:  "", image: "np_humantorso.png", information: "A bloody severed torso.", deg: false }
itemList["humanarm"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Severed Arm", price: 1, weight: 7, nonStack: true, model:  "", image: "np_humanarm.png", information: "A bloody severed arm.", deg: false }
itemList["humanhand"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Severed Hand", price: 1, weight: 5, nonStack: true, model:  "", image: "np_humanhand.png", information: "A bloody severed hand.", deg: false }
itemList["humanleg"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Severed Leg", price: 1, weight: 7, nonStack: true, model:  "", image: "np_humanleg.png", information: "A bloody severed leg.", deg: false }
itemList["humanfinger"]	    = {fullyDegrades: true, decayrate: 2.0, displayname: "Severed finger", price: 1, weight: 1, nonStack: true, model:  "", image: "np_humanfinger.png", information: "A bloody severed finger. Where is the rest?", deg: false }
itemList["humanear"]	    = {fullyDegrades: true, decayrate: 2.0, displayname: "Severed Ear", price: 1, weight: 1, nonStack: true, model:  "", image: "np_humanear.png", information: "A bloody severed ear.", deg: false }
itemList["humanskull"]	    = {fullyDegrades: true, decayrate: 0.2, displayname: "Đầu lâu người", price: 1, weight: 5, nonStack: true, model:  "", image: "np_humanskull.png", information: "Đầu lâu của một người nào đó.", deg: false }
itemList["humanbones"]	    = {fullyDegrades: true, decayrate: 0.2, displayname: "Xương người", price: 1, weight: 15, nonStack: true, model:  "", image: "np_humanbones.png", information: "Bộ sưu tập xương người.", deg: false }
itemList["humanbone"]	    = {fullyDegrades: true, decayrate: 0.2, displayname: "Đoạn xương người", price: 1, weight: 3, nonStack: true, model:  "", image: "np_humanbone.png", information: "Một đoạn xương của một ai đó.", deg: false }
itemList["humanheart"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Human Heart", price: 1, weight: 2, nonStack: true, model:  "", image: "np_humanheart.png", information: "A bloody heart.", deg: false }
itemList["humaneye"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Human Eyeball", price: 1, weight: 1, nonStack: true, model:  "", image: "np_humaneye.png", information: "A severed torn out eyeball.", deg: false }
itemList["humanbrain"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Human Brain", price: 1, weight: 2, nonStack: true, model:  "", image: "np_humanbrain.png", information: "A bloody brain.", deg: false }
itemList["humanintestines"]	= {fullyDegrades: false, decayrate: 2.0, displayname: "Human Intestines", price: 1, weight: 5, nonStack: true, model:  "", image: "np_humanintestines.png", information: "A bunch of intestines.", deg: false }
itemList["humankidney"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Human Kidney", price: 1, weight: 2, nonStack: true, model:  "", image: "np_humankidney.png", information: "A bloody kidney.", deg: false }
itemList["humanliver"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Human Liver", price: 1, weight: 3, nonStack: true, model:  "", image: "np_humanliver.png", information: "A bloody liver.", deg: false }
itemList["humanlungs"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Human Lungs", price: 1, weight: 4, nonStack: true, model:  "", image: "np_humanlungs.png", information: "A bloody pair of lungs.", deg: false }
itemList["humannail"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Human Nail", price: 1, weight: 0, nonStack: true, model:  "", image: "np_humannail.png", information: "A single torn out nail.", deg: false }
itemList["humanpancreas"]   = {fullyDegrades: false, decayrate: 2.0, displayname: "Human Pancreas", price: 1, weight: 2, nonStack: true, model:  "", image: "np_humanpancreas.png", information: "A bloody pancreas.", deg: false }
itemList["humantongue"]	    = {fullyDegrades: false, decayrate: 2.0, displayname: "Human Tongue", price: 1, weight: 1, nonStack: true, model:  "", image: "np_humantongue.png", information: "A tongue without its human.", deg: false }
itemList["humantooth"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Human Tooth", price: 1, weight: 0, nonStack: true, model:  "", image: "np_humantooth.png", information: "A single tooth with root and all.", deg: false }

// Coop request - gallery stoof
itemList["gallery1star"]	    = {fullyDegrades: true, decayrate: 0.0, displayname: "1 Star Contract", price: 1, weight: 0, nonStack: true, model:  "", image: "np_gallery_1star.png", information: "1 Star Contract", deg: false }
itemList["gallery2star"]	    = {fullyDegrades: true, decayrate: 0.0, displayname: "2 Star Contract", price: 1, weight: 0, nonStack: true, model:  "", image: "np_gallery_2star.png", information: "2 Star Contract", deg: false }
itemList["gallery3star"]	    = {fullyDegrades: true, decayrate: 0.0, displayname: "3 Star Contract", price: 1, weight: 0, nonStack: true, model:  "", image: "np_gallery_3star.png", information: "3 Star Contract", deg: false }
itemList["gallery4star"]	    = {fullyDegrades: true, decayrate: 0.0, displayname: "4 Star Contract", price: 1, weight: 0, nonStack: true, model:  "", image: "np_gallery_4star.png", information: "4 Star Contract", deg: false }
itemList["gallery5star"]	    = {fullyDegrades: true, decayrate: 0.0, displayname: "5 Star Contract", price: 1, weight: 0, nonStack: true, model:  "", image: "np_gallery_5star.png", information: "5 Star Contract", deg: false }
itemList["gallerypremium"]	    = {fullyDegrades: true, decayrate: 0.0, displayname: "Membership Card", price: 1, weight: 0, nonStack: true, model:  "", image: "np_gallery_premium.png", information: "Premiere Membership Card", deg: false }
itemList["galleryregular"]	    = {fullyDegrades: true, decayrate: 0.0, displayname: "Membership Card", price: 1, weight: 0, nonStack: true, model:  "", image: "np_gallery_regular.png", information: "Regular Membership Card", deg: false }
itemList["galleryvip"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Membership Card", price: 1, weight: 0, nonStack: true, model:  "", image: "np_gallery_vip.png", information: "VIP Membership Card", deg: false }

// curvy gift - can delete in merge
itemList["curvyelephant"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Pet Elephant", price: 1, weight: 0, nonStack: true, model:  "", image: "np_pet-elephant.png", information: "Pretty curvy", deg: false }



//Perfect World

itemList["paintinge"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bức tranh số 1", price: 1, weight: 1, nonStack: true, model:  "", image: "paintinge.png", information: "", deg: false }

itemList["paintingf"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bức tranh số 2", price: 1, weight: 1, nonStack: true, model:  "", image: "paintingf.png", information: "", deg: false }

itemList["paintingg"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bức tranh số 3", price: 1, weight: 1, nonStack: true, model:  "", image: "paintingg.png", information: "", deg: false }

itemList["paintingh"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bức tranh số 4", price: 1, weight: 1, nonStack: true, model:  "", image: "paintingh.png", information: "", deg: false }

itemList["paintingi"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bức tranh số 5", price: 1, weight: 1, nonStack: true, model:  "", image: "paintingi.png", information: "", deg: false }

itemList["paintingj"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Bức tranh số 6", price: 1, weight: 1, nonStack: true, model:  "", image: "paintingj.png", information: "", deg: false }

itemList["paperblade"]	    = {fullyDegrades: false, decayrate: 0.7, displayname: "Dao rọc", price: 1, weight: 1, craft: [{itemid: "ironmate", amount: 15 } , {itemid: "aluminiummate", amount: 10  } ], nonStack: true, model:  "", image: "np_switchblade.png", information: "", deg: false }


itemList["logo1"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Mảnh ghép số 1", price: 1, weight: 1, nonStack: true, model:  "", image: "pw_logo1.png", information: "", deg: false }

itemList["logo2"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Mảnh ghép số 2", price: 1, weight: 1, nonStack: true, model:  "", image: "pw_logo2.png", information: "", deg: false }

itemList["logo3"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Mảnh ghép số 3", price: 1, weight: 1, nonStack: true, model:  "", image: "pw_logo3.png", information: "", deg: false }

itemList["logo4"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Mảnh ghép số 4", price: 1, weight: 1, nonStack: true, model:  "", image: "pw_logo4.png", information: "", deg: false }

itemList["logofull"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Mảnh ghép hoàn chỉnh", price: 1, weight: 1, nonStack: true, model:  "", image: "pw_logofull.png", information: "", deg: false }


itemList["goldbar"]	   = {fullyDegrades: false, illegal: true, decayrate: 0.0, displayname: "Thỏi Vàng", craft: [{itemid: "goldmate", amount: 2 } , {itemid: "coal", amount: 1 } ], price: 550, weight: 2, nonStack: false, model: "", image: "np_gold-bar.png" , information: "Vàng nguyên chất thường thấy ở các tiệm trang sức", deg: false}


itemList["rock"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Cục đá", price: 1, weight: 5, nonStack: true, model:  "", image: "np_rock.png", information: "", deg: false }

itemList["coal"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Than đá", price: 1, weight: 1, nonStack: true, model:  "", image: "np_coal.png", information: "", deg: false }

itemList["goldmate"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Quặng vàng", price: 1, weight: 5, nonStack: true, model:  "", image: "np_goldmaterial.png", information: "", deg: false }

itemList["ironmate"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Quặng sắt", price: 1, weight: 5, nonStack: true, model:  "", image: "np_ironmaterial.png", information: "", deg: false }

itemList["mercury"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Thuỷ ngân", price: 1, weight: 1, nonStack: true, model:  "", image: "np_mercury.png", information: "", deg: false }

itemList["jadeite"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Jadeite Stone", price: 1, weight: 10, nonStack: false, model:  "", image: "np_jadeite-stone.png", information: "", deg: false }

itemList["aluminiummate"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Quặng nhôm", price: 1, weight: 5, nonStack: true, model:  "", image: "np_aluminummaterial.png", information: "", deg: false }


itemList["motelkey"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Chìa khoá phòng", price: 1, weight: 1, nonStack: true, model:  "", image: "np_bankboxkey.png", information: "", deg: false, esxuse: true }
itemList["luciferbarcard"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Thẻ Bar Lucifer", price: 1, weight: 0, nonStack: true, model:  "", image: "np_luciferbar.png", information: "", deg: false }

itemList["morphine"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Morphine", price: 200, weight: 0, nonStack: false, model:  "", image: "np_drug-x.png", information: "Morphine là một loại thuốc giảm đau thuộc họ thuốc phiện", deg: false }

itemList["firstimegift"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Quà nhận lần đầu", price: 1, weight: 1, nonStack: true, model:  "", image: "reward1.png", information: "Đây là hộp quà được tặng khi lần đầu vào game", deg: false, esxuse: true, removuse: true }
itemList["onlinelv1"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Quà online level 1", price: 1, weight: 1, nonStack: true, model:  "", image: "reward4.png", information: "Đây là hộp quà thưởng người chơi online level 1", deg: false, esxuse: true, removuse: true }
itemList["onlinelv2"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Quà online level 2", price: 1, weight: 1, nonStack: true, model:  "", image: "reward3.png", information: "Đây là hộp quà thưởng người chơi online level 2", deg: false, esxuse: true, removuse: true }
itemList["onlinelv3"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Quà online level 2", price: 1, weight: 1, nonStack: true, model:  "", image: "reward5.png", information: "Đây là hộp quà thưởng người chơi online level 3", deg: false, esxuse: true, removuse: true }
itemList["loginreward1"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Quà online level 2", price: 1, weight: 1, nonStack: true, model:  "", image: "reward1.png", information: "Đây là hộp quà thưởng người chơi điểm danh cấp 1", deg: false, esxuse: true, removuse: true }
itemList["loginreward2"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Quà online level 2", price: 1, weight: 1, nonStack: true, model:  "", image: "reward2.png", information: "Đây là hộp quà thưởng người chơi điểm danh cấp 2", deg: false, esxuse: true, removuse: true }

itemList["attach_skin_cb_empress"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Skin Weapon Empress", price: 1, weight: 1, nonStack: true, model:  "", image: "reward2.png", information: "Đây là skin vũ khí", deg: false }


itemList["coral1"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Skin Weapon Empress", price: 1, weight: 8, nonStack: true, model:  "", image: "dendrogyra_coral.png", information: "Đây là skin vũ khí", deg: false }

itemList["coral2"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Skin Weapon Empress", price: 1, weight: 8, nonStack: true, model:  "", image: "antipatharia_coral.png", information: "Đây là skin vũ khí", deg: false }


itemList["scuba_oxygen_tank"]	    = {fullyDegrades: true, decayrate: 1.5, displayname: "Bình oxy", price: 300, weight: 20, nonStack: true, model:  "", image: "np_oxygen-tank.png", information: "Bình oxy dùng để tiếp thêm oxy cho bộ đồ lặn", deg: false, esxuse: true, removuse: true }

itemList["scuba_gear"]	    = {fullyDegrades: true, decayrate: 1.5, displayname: "Đồ lặn", craft: [{itemid: "rubber", amount: 100 },{itemid: "glass", amount: 100 } ] , price: 2000, weight: 10, nonStack: true, model:  "", image: "pw_diving_gear.png", information: "Bộ đồ lặn chuyên dụng", deg: false, esxuse: true}

itemList["snorkelling_gear"]	    = {fullyDegrades: true, decayrate: 1.5, displayname: "Mặt nạ lặn", price: 400, craft: [{itemid: "rubber", amount: 50 },{itemid: "glass", amount: 50 } ] ,weight: 10, nonStack: true, model:  "", image: "pw_diving_gear.png", information: "Mặt nạ lặn thông thường.", deg: false, esxuse: true}


itemList["fertilizer"]	= {fullyDegrades: true, decayrate: 0.4, displayname: "Phân bón", price: 600, weight: 3, nonStack: false, model: "", image: "np_fertilizer.png", information: "Dùng cho hầu hết các loại cây." , deg: false}


itemList["painting_1"]	= {fullyDegrades: true, decayrate: 0.4, displayname: "Starry Night", price: 150, weight: 20, nonStack: false, model:  "", image: "np_starry-night.png", information: "Neither ear nor there" , deg: false}

itemList["painting_2"] = {fullyDegrades: true,  decayrate: 0.4, displayname: "Water Lilies", price: 1, weight: 20, nonStack: false, model: "", image: "np_water-lilies.png", information: "Monet 1907", deg: false }

itemList["painting_3"] 	= {fullyDegrades: true,  decayrate: 0.4, displayname: "American Gothic", price: 1, weight: 20, nonStack: false, model: "", image: "np_american-gothic.png", information: "Wood 1930", deg: false }

itemList["painting_4"] = {fullyDegrades: true,  decayrate: 0.4, displayname: "The Scream", price: 1, weight: 20, nonStack: false, model: "", image: "np_the-scream.png", information: "Munch 1893", deg: false }

itemList["painting_5"] = {fullyDegrades: true,  decayrate: 0.4, displayname: "Mona Lisa", price: 1, weight: 20, nonStack: false, model: "", image: "np_mona-lisa.png", information: "Da Vinci 1517", deg: false }

itemList["painting_7"]	= {fullyDegrades: true, decayrate: 0.4, displayname: "Salvator Mundi", price: 1, weight: 20, nonStack: false, model:  "", image: "np_salvator-mundi.png", information: "Da Vinci 1500", deg: false }

itemList["painting_8"] 	= {fullyDegrades: true,  decayrate: 0.4, displayname: "Dora Maar au Chat", price: 1, weight: 20, nonStack: false, model: "", image: "np_dora-maar-auchat.png", information: "Picasso 1941", deg: false }

itemList["painting_10"] = {fullyDegrades: true,  decayrate: 0.4, displayname: "Portrait of Dr.Gachet", price: 1, weight: 20, nonStack: false, model: "", image: "np_portrait-of-drgachet.png", information: "Van Gogh 1890", deg: false }


itemList["negg"] = {fullyDegrades: true,  decayrate: 0.4, displayname: "Napoleonic Egg", price: 1, weight: 0, nonStack: false, model: "", image: "np_napoleonic-egg.png", information: "Faberge Series (2/3)", deg: false }

itemList["carradio"]	    = {fullyDegrades: true, decayrate: 2.0, displayname: "Car radio",       craft: [ {itemid: "electronics", amount: 100 }, {itemid: "rubber", amount: 80 },{itemid: "scrapmetal", amount: 20 }, {itemid: "glass", amount: 20 } ], price: 1000, weight: 5,   nonStack: false, model: "", image: "np_tuner.png", information: "Dùng để bật nhạc trên xe..", deg: false, esxuse: true}

itemList["keyfob"]	    = {fullyDegrades: true, decayrate: 5.0, displayname: "Chìa điện tử",       craft: [ {itemid: "electronics", amount: 100 } ], price: 500, weight: 0,   nonStack: false, model: "", image: "np_keyfob.png", information: "Dùng để mở cửa từ xa..", deg: false, esxuse: true}

itemList["cameravirus"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Virus Camera", price: 1, weight: 0, nonStack: false, model:  "", image: "np_securitykey.png", information: "Dùng để hack vào hệ thống camera.", deg: false }

itemList["huntingbait"]	    = {fullyDegrades: true, decayrate: 0.6, displayname: "Mồi săn", price: 30, weight: 0, nonStack: true, model:  "", image: "np_huntingbait.png", information: "Thức ăn để dụ thú rừng <br> Mount Chiliad <br> Chiliad Mountain State Wilderness <br> Paleto Forest.", deg: false }

itemList["huntingknife"]	    = {fullyDegrades: true, decayrate: 0.3, displayname: "Dao rọc da", price: 50, weight: 0, nonStack: true, model:  "", image: "np_huntingknife.png", information: "Dao cho thợ săn.", deg: false }

itemList["-646649097"] = {fullyDegrades: true, decayrate: 2.0, displayname: "Súng săn", price: 1500, craft: [ {itemid: "aluminium", amount: 50 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 20, nonStack: true, model:  "", image: "np_huntingrifle.png", weapon: false, information: "Súng săn. Không được phép bắn người",deg: true} //'Hunting Rifle'

itemList["huntingscope"] = {fullyDegrades: true, decayrate: 2.0, displayname: "Ống nhòm súng săn", price: 500, craft: [ {itemid: "aluminium", amount: 50 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 5, nonStack: true, model:  "", image: "np_tscope.png", weapon: false, information: "Scope súng săn",deg: true} //'Hunting Rifle'

itemList["huntingammo"] = {fullyDegrades: false, decayrate: 2.0, displayname: "Đạn súng săn", price: 800, craft: [ {itemid: "aluminium", amount: 50 }, {itemid: "plastic", amount: 80 }, {itemid: "rubber", amount: 1 } ],  weight: 5, nonStack: true, model:  "", image: "np_223ammo.png", weapon: false, deg: true} //'Hunting Rifle'

itemList["leatherboard1"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da heo rừng", price: 1, weight: 7, nonStack: false, model: "", image: "leather_boar_bad.png", information: "", deg: false }

itemList["leatherboard2"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da heo rừng", price: 1, weight: 7, nonStack: false, model: "", image: "leather_boar_good.png", information: "", deg: false }

itemList["leatherboard3"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da heo rừng", price: 1, weight: 7, nonStack: false, model: "", image: "leather_boar_perfect.png", information: "", deg: false }

itemList["leathercormorant1"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da chim cốc", price: 1, weight: 2, nonStack: false, model: "", image: "leather_cormorant_bad.png", information: "", deg: false }

itemList["leathercormorant2"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da chim cốc", price: 1, weight: 2, nonStack: false, model: "", image: "leather_cormorant_good.png", information: "", deg: false }

itemList["leathercormorant3"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da chim cốc", price: 1, weight: 2, nonStack: false, model: "", image: "leather_cormorant_perfect.png", information: "", deg: false }

itemList["leathercoyote1"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da sói đồng cỏ", price: 1, weight: 3, nonStack: false, model: "", image: "leather_coyote_bad.png", information: "", deg: false }

itemList["leathercoyote2"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da sói đồng cỏ", price: 1, weight: 3, nonStack: false, model: "", image: "leather_coyote_good.png", information: "", deg: false }

itemList["leathercoyote3"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da sói đồng cỏ", price: 1, weight: 3, nonStack: false, model: "", image: "leather_coyote_perfect.png", information: "", deg: false }

itemList["leatherdeer1"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da Huơu", price: 1, weight: 10, nonStack: false, model: "", image: "leather_deer_bad.png", information: "", deg: false }

itemList["leatherdeer2"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da Huơu", price: 1, weight: 10, nonStack: false, model: "", image: "leather_deer_good.png", information: "", deg: false }

itemList["leatherdeer3"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da Huơu", price: 1, weight: 10, nonStack: false, model: "", image: "leather_deer_perfect.png", information: "", deg: false }

itemList["leathermtlion1"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da báo núi", price: 1, weight: 10, nonStack: false, model: "", image: "leather_mtlion_bad.png", information: "", deg: false }

itemList["leathermtlion2"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da báo núi", price: 1, weight: 10, nonStack: false, model: "", image: "leather_mtlion_good.png", information: "", deg: false }

itemList["leathermtlion3"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da báo núi", price: 1, weight: 10, nonStack: false, model: "", image: "leather_mtlion_perfect.png", information: "", deg: false }

itemList["leatherrabbit1"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da thỏ", price: 1, weight: 2, nonStack: false, model: "", image: "leather_rabbit_bad.png", information: "", deg: false }

itemList["leatherrabbit2"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da thỏ", price: 1, weight: 2, nonStack: false, model: "", image: "leather_rabbit_good.png", information: "", deg: false }

itemList["leatherrabbit3"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Da thỏ", price: 1, weight: 2, nonStack: false, model: "", image: "leather_rabbit_perfect.png", information: "", deg: false }

itemList["thitthu1"] 		= {fullyDegrades: true,  decayrate: 0.7, displayname: "Xiên que nướng", craft: [{itemid: "foodingredient", amount: 5 },{itemid: "xienque", amount: 1 },{itemid: "huntingcarcass1", amount: 1 } ] ,price: 1, weight: 2, nonStack: false, model: "", image: "pw_thithu.png", information: "", deg: false }

itemList["thitthu2"] 		= {fullyDegrades: true,  decayrate: 0.7, displayname: "Xiên thịt thú nướng", craft: [{itemid: "foodingredient", amount: 5 },{itemid: "xienque", amount: 1 },{itemid: "huntingcarcass2", amount: 1 } ] ,price: 1, weight: 2, nonStack: false, model: "", image: "pw_thithu2.png", information: "", deg: false }

itemList["thitthu3"] 		= {fullyDegrades: true,  decayrate: 0.7, displayname: "Da thỏ", craft: [{itemid: "foodingredient", amount: 10 }, {itemid: "bakingsoda", amount: 2 }, {itemid: "huntingcarcass3", amount: 1 } ] ,price: 1, weight: 2, nonStack: false, model: "", image: "pw_suon.png", information: "", deg: false }

itemList["xienque"] 		= {fullyDegrades: true,  decayrate: 0.3, displayname: "Que xiên",price: 15, weight: 2, nonStack: false, model: "", image: "pw_xienque.png", information: "", deg: false }

itemList["thitbonuong"] 		= {fullyDegrades: true,  decayrate: 0.5, displayname: "Thịt bò nướng", craft: [{itemid: "foodingredient", amount: 5 }, {itemid: "bakingsoda", amount: 1 } ] ,price: 1, weight: 2, nonStack: false, model: "", image: "pw_bonuong.png", information: "", deg: false }

itemList["dhide"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Deer Hide", price: 1, weight: 0, nonStack: false, model: "", image: "np_deer-hide.png", information: "Call peta", deg: false }

itemList["antlers"] 	= {fullyDegrades: false,  decayrate: 0.0, displayname: "Antlers", price: 1, weight: 0, nonStack: false, model: "", image: "np_antlers.png", information: "A fine prize", deg: false }

itemList["cpelt"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Cougar Pelt", price: 1, weight: 0, nonStack: false, model: "", image: "np_cougar-pelt.png", information: "The hunter becomes the hunted", deg: false }

itemList["ctooth"] 		= {fullyDegrades: false,  decayrate: 0.0, displayname: "Cougar Tooth", price: 1, weight: 0, nonStack: false, model: "", image: "np_cougar-tooth.png", information: "Stalks its prey", deg: false }

itemList["rpelt"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Da thỏ", price: 1, weight: 1, nonStack: false, model: "", image: "np_rabbit-pelt.png", information: "Một tấm da nhỏ thường", deg: false }

itemList["hpelt"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Da thú", price: 1, weight: 0, nonStack: false, model: "", image: "np_huntingpelt.png", information: "", deg: false }

itemList["snakeskin"] = {fullyDegrades: false,  decayrate: 0.0, displayname: "Snakeskin", price: 1, weight: 0, nonStack: false, model: "", image: "np_snakeskin.png", information: "Sssss", deg: false }


itemList["huntingcarcass1"]	    = {fullyDegrades: true, decayrate: 20.0, displayname: "Thịt thú rừng loại 1", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_huntingcarcass1.png", information: "Loại thịt chất lượng kém", deg: false}

itemList["huntingcarcass2"]	    = {fullyDegrades: true, decayrate: 20.0, displayname: "Thịt thú rừng loại 2", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_huntingcarcass2.png", information: "Loại thịt thông thường", deg: false}

itemList["huntingcarcass3"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Thịt thú rừng loại 3", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_huntingcarcass3.png", information: "Loại thịt đỉnh cấp cắt rất gọn gàng", deg: false}

itemList["huntingcarcass4"]	    = {fullyDegrades: true, decayrate: 0.90, displayname: "Thịt thú rừng loại 4", craft: [{itemid: "foodingredient", amount: 1 } ], price: 10, weight: 12, nonStack: false, model: "", image: "np_huntingcarcass4.png", information: "Đây là động vật quý hiếm ư?", deg: false}



itemList["axleparta"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Trục xe Hạng A", craft: [{itemid: "axle", amount: 1 }, {itemid: "scrapmetal", amount: 1 }, {itemid: "copper", amount: 1 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_axle_parts_a.png" , deg: false}

itemList["axlepartb"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Trục xe Hạng B", craft: [{itemid: "axle", amount: 1 }, {itemid: "scrapmetal", amount: 2 }, {itemid: "copper", amount: 2 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_axle_parts_b.png" , deg: false}

itemList["axlepartc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Trục xe Hạng C", craft: [{itemid: "axle", amount: 1 }, {itemid: "scrapmetal", amount: 3 }, {itemid: "copper", amount: 3 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_axle_parts_c.png" , deg: false}

itemList["axlepartd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Trục xe Hạng D", craft: [{itemid: "axle", amount: 1 }, {itemid: "scrapmetal", amount: 4 }, {itemid: "copper", amount: 4 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_axle_parts_d.png" , deg: false}

itemList["axleparts"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Trục xe Hạng S", craft: [{itemid: "axle", amount: 1 }, {itemid: "scrapmetal", amount: 5 }, {itemid: "copper", amount: 5 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_axle_parts_s.png" , deg: false}


itemList["bodypanela"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Vỏ xe Hạng A", craft: [{itemid: "bodycar", amount: 1 }, {itemid: "plastic", amount: 2 }, {itemid: "rubber", amount: 2 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_body_panels_a.png" , deg: false}

itemList["bodypanelb"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Vỏ xe Hạng B", craft: [{itemid: "bodycar", amount: 1 }, {itemid: "plastic", amount: 4 }, {itemid: "rubber", amount: 4 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_body_panels_b.png" , deg: false}

itemList["bodypanelc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Vỏ xe Hạng C", craft: [{itemid: "bodycar", amount: 1 }, {itemid: "plastic", amount: 6 }, {itemid: "rubber", amount: 6 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_body_panels_c.png" , deg: false}

itemList["bodypaneld"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Vỏ xe Hạng D", craft: [{itemid: "bodycar", amount: 1 }, {itemid: "plastic", amount: 8 }, {itemid: "rubber", amount: 8 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_body_panels_d.png" , deg: false}

itemList["bodypanels"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Vỏ xe Hạng S", craft: [{itemid: "bodycar", amount: 1 }, {itemid: "plastic", amount: 10 }, {itemid: "rubber", amount: 10 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_body_panels_s.png" , deg: false}

itemList["brakeparta"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Phanh xe Hạng A", craft: [{itemid: "brakecar", amount: 1 }, {itemid: "scrapmetal", amount: 1 }, {itemid: "refinedwood", amount: 1 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_brake_parts_a.png" , deg: false}

itemList["brakepartb"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Phanh xe Hạng B", craft: [{itemid: "brakecar", amount: 1 }, {itemid: "scrapmetal", amount: 2 }, {itemid: "refinedwood", amount: 2 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_brake_parts_b.png" , deg: false}

itemList["brakepartc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Phanh xe Hạng C", craft: [{itemid: "brakecar", amount: 1 }, {itemid: "scrapmetal", amount: 3 }, {itemid: "refinedwood", amount: 3 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_brake_parts_c.png" , deg: false}

itemList["brakepartd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Phanh xe Hạng D", craft: [{itemid: "brakecar", amount: 1 }, {itemid: "scrapmetal", amount: 4 }, {itemid: "refinedwood", amount: 4 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_brake_parts_d.png" , deg: false}

itemList["brakeparts"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Phanh xe Hạng S", craft: [{itemid: "brakecar", amount: 1 }, {itemid: "scrapmetal", amount: 5 }, {itemid: "refinedwood", amount: 5 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_brake_parts_s.png" , deg: false}

itemList["clutchparta"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Ly hợp Hạng A", craft: [{itemid: "clutch", amount: 1 }, {itemid: "scrapmetal", amount: 1 }, {itemid: "refinedwood", amount: 1 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_clutch_parts_a.png" , deg: false}

itemList["clutchpartb"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Ly hợp Hạng B", craft: [{itemid: "clutch", amount: 1 }, {itemid: "scrapmetal", amount: 2 }, {itemid: "refinedwood", amount: 2 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_clutch_parts_b.png" , deg: false}

itemList["clutchpartc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Ly hợp Hạng C", craft: [{itemid: "clutch", amount: 1 }, {itemid: "scrapmetal", amount: 3 }, {itemid: "refinedwood", amount: 3 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_clutch_parts_c.png" , deg: false}

itemList["clutchpartd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Ly hợp Hạng D", craft: [{itemid: "clutch", amount: 1 }, {itemid: "scrapmetal", amount: 4 }, {itemid: "refinedwood", amount: 4 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_clutch_parts_d.png" , deg: false}

itemList["clutchparts"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Ly hợp Hạng S", craft: [{itemid: "clutch", amount: 1 }, {itemid: "scrapmetal", amount: 5 }, {itemid: "refinedwood", amount: 5 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_clutch_parts_s.png" , deg: false}

itemList["coolingparta"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bộ làm mát Hạng A", craft: [{itemid: "radiator", amount: 1 }, {itemid: "scrapmetal", amount: 1 }, {itemid: "copper", amount: 1 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_cooling_parts_a.png" , deg: false}

itemList["coolingpartb"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bộ làm mát Hạng B", craft: [{itemid: "radiator", amount: 1 }, {itemid: "scrapmetal", amount: 2 }, {itemid: "copper", amount: 2 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_cooling_parts_b.png" , deg: false}

itemList["coolingpartc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bộ làm mát Hạng C", craft: [{itemid: "radiator", amount: 1 }, {itemid: "scrapmetal", amount: 3 }, {itemid: "copper", amount: 3 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_cooling_parts_c.png" , deg: false}

itemList["coolingpartd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bộ làm mát Hạng D", craft: [{itemid: "radiator", amount: 1 }, {itemid: "scrapmetal", amount: 4 }, {itemid: "copper", amount: 4 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_cooling_parts_d.png" , deg: false}

itemList["coolingparts"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bộ làm mát Hạng S", craft: [{itemid: "radiator", amount: 1 }, {itemid: "scrapmetal", amount: 5 }, {itemid: "copper", amount: 5 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_cooling_parts_s.png" , deg: false}

itemList["electronicparta"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Thiết bị điển tự Hạng A", craft: [{itemid: "sound", amount: 1 }, {itemid: "electronics", amount: 1 }, {itemid: "glass", amount: 1 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_electronic_parts_a.png" , deg: false}

itemList["electronicpartb"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Thiết bị điển tự Hạng B", craft: [{itemid: "sound", amount: 1 }, {itemid: "electronics", amount: 2 }, {itemid: "glass", amount: 2 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_electronic_parts_b.png" , deg: false}

itemList["electronicpartc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Thiết bị điển tự Hạng C", craft: [{itemid: "sound", amount: 1 }, {itemid: "electronics", amount: 3 }, {itemid: "glass", amount: 3 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_electronic_parts_c.png" , deg: false}

itemList["electronicpartd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Thiết bị điển tự Hạng D", craft: [{itemid: "sound", amount: 1 }, {itemid: "electronics", amount: 4 }, {itemid: "glass", amount: 4 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_electronic_parts_d.png" , deg: false}

itemList["electronicparts"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Thiết bị điển tự Hạng S", craft: [{itemid: "sound", amount: 1 }, {itemid: "electronics", amount: 5 }, {itemid: "glass", amount: 5 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_electronic_parts_s.png" , deg: false}

itemList["engineparta"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Động cơ Hạng A", craft: [{itemid: "engineblock", amount: 1 }, {itemid: "scrapmetal", amount: 2 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_engine_parts_a.png" , deg: false}

itemList["enginepartb"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Động cơ Hạng B", craft: [{itemid: "engineblock", amount: 1 }, {itemid: "scrapmetal", amount: 4 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_engine_parts_b.png" , deg: false}

itemList["enginepartc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Động cơ Hạng C", craft: [{itemid: "engineblock", amount: 1 }, {itemid: "scrapmetal", amount: 6 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_engine_parts_c.png" , deg: false}

itemList["enginepartd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Động cơ Hạng D", craft: [{itemid: "engineblock", amount: 1 }, {itemid: "scrapmetal", amount: 8 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_engine_parts_d.png" , deg: false}

itemList["engineparts"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Động cơ Hạng S", craft: [{itemid: "engineblock", amount: 1 }, {itemid: "scrapmetal", amount: 10 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_engine_parts_s.png" , deg: false}

itemList["fuelinjectora"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Kim phun Hạng A", craft: [{itemid: "fuelinjector", amount: 1 }, {itemid: "copper", amount: 2 } , {itemid: "plastic", amount: 2 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_fuel_injectors_a.png" , deg: false}

itemList["fuelinjectorb"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Kim phun Hạng B", craft: [{itemid: "fuelinjector", amount: 1 }, {itemid: "copper", amount: 4 }, {itemid: "plastic", amount: 4 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_fuel_injectors_b.png" , deg: false}

itemList["fuelinjectorc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Kim phun Hạng C", craft: [{itemid: "fuelinjector", amount: 1 }, {itemid: "copper", amount: 6 }, {itemid: "plastic", amount: 6 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_fuel_injectors_c.png" , deg: false}

itemList["fuelinjectord"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Kim phun Hạng D", craft: [{itemid: "fuelinjector", amount: 1 }, {itemid: "copper", amount: 8 }, {itemid: "plastic", amount: 8 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_fuel_injectors_d.png" , deg: false}

itemList["fuelinjectors"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Kim phun Hạng S", craft: [{itemid: "fuelinjector", amount: 1 }, {itemid: "copper", amount: 10 }, {itemid: "plastic", amount: 10 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_fuel_injectors_s.png" , deg: false}

itemList["tirekita"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bánh xe Hạng A", craft: [{itemid: "tire", amount: 1 }, {itemid: "rubber", amount: 4 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_tire_kit_a.png" , deg: false}

itemList["tirekitb"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bánh xe Hạng B", craft: [{itemid: "tire", amount: 1 }, {itemid: "rubber", amount: 8 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_tire_kit_b.png" , deg: false}

itemList["tirekitc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bánh xe Hạng C", craft: [{itemid: "tire", amount: 1 }, {itemid: "rubber", amount: 12 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_tire_kit_c.png" , deg: false}

itemList["tirekitd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bánh xe Hạng D", craft: [{itemid: "tire", amount: 1 }, {itemid: "rubber", amount: 16 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_tire_kit_d.png" , deg: false}

itemList["tirekits"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Bánh xe Hạng S", craft: [{itemid: "tire", amount: 1 }, {itemid: "rubber", amount: 20 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_tire_kit_s.png" , deg: false}

itemList["transmissionparta"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Hộp số Hạng A", craft: [{itemid: "transmission", amount: 1 }, {itemid: "scrapmetal", amount: 1 }, {itemid: "copper", amount: 1 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_transmission_parts_a.png" , deg: false}

itemList["transmissionpartb"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Hộp số Hạng B", craft: [{itemid: "transmission", amount: 1 }, {itemid: "scrapmetal", amount: 2 }, {itemid: "copper", amount: 2 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_transmission_parts_b.png" , deg: false}

itemList["transmissionpartc"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Hộp số Hạng C", craft: [{itemid: "transmission", amount: 1 }, {itemid: "scrapmetal", amount: 3 }, {itemid: "copper", amount: 3 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_transmission_parts_c.png" , deg: false}

itemList["transmissionpartd"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Hộp số Hạng D", craft: [{itemid: "transmission", amount: 1 }, {itemid: "scrapmetal", amount: 4 }, {itemid: "copper", amount: 4 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_transmission_parts_d.png" , deg: false}

itemList["transmissionparts"]	= {fullyDegrades: false, decayrate: 0.0, displayname: "Hộp số Hạng S", craft: [{itemid: "transmission", amount: 1 }, {itemid: "scrapmetal", amount: 5 }, {itemid: "copper", amount: 5 }], price: 10, weight: 7, nonStack: false, model: "", image: "np_transmission_parts_s.png" , deg: false}



itemList["engineblock"]	= {fullyDegrades: false, decayrate: 1.0, displayname: "Động cơ xe", price: 10, weight: 7, nonStack: false, model: "", image: "np_engineblock.png" , deg: false}

itemList["radiator"]	= {fullyDegrades: false, decayrate: 1.0, displayname: "Bộ làm mát", price: 10, weight: 2, nonStack: false, model: "", image: "np_radiatorcar.png" , deg: false}

itemList["fuelinjector"]= {fullyDegrades: false, decayrate: 1.0, displayname: "Bộ kim phun", price: 10, weight: 2, nonStack: false, model: "", image: "np_fuelinjectorcar.png" , deg: false}

itemList["axle"]= {fullyDegrades: false, decayrate: 1.0, displayname: "Trục xe", price: 10, weight: 2, nonStack: false, model: "", image: "np_axlepart.png" , deg: false}

itemList["brakecar"]= {fullyDegrades: false, decayrate: 1.0, displayname: "Bánh phanh", price: 10, weight: 5, nonStack: false, model: "", image: "np_brakepart.png" , deg: false}

itemList["transmission"]= {fullyDegrades: false, decayrate: 1.0, displayname: "Bộ phận hộp số", price: 10, weight: 2, nonStack: false, model: "", image: "np_transmissioncar.png" , deg: false}

itemList["bodycar"]= {fullyDegrades: false, decayrate: 1.0, displayname: "Vỏ xe", craft: [{itemid: "carhood", amount: 1 }, {itemid: "fbumper", amount: 1 }, {itemid: "rbumper", amount: 1 }, {itemid: "hlights", amount: 1 }, {itemid: "sskirts", amount: 1 }, {itemid: "spoiler", amount: 1 }], price: 10, weight: 12, nonStack: false, model: "", image: "np_bodycar.png" , deg: false}

itemList["whiteseed"]	= {fullyDegrades: true, decayrate: 1.0, displayname: "hạt giống White Widow", price: 100, weight: 0,   nonStack: false, model: "", image: "np_weed-seed.png", information: "Plant near females to make them produce seeds. ", deg: false, esxuse: true, removuse: true}



itemList["nitrous"]	    = {fullyDegrades: false, decayrate: 0.0, displayname: "Nitrous Oxide", craft: [{itemid: "electronics", amount: 10 }], price: 300, weight: 5, nonStack: false, model: "", image: "np_nitrous-oxide.png" , deg: false, esxuse: true, removuse: true}




// Progression
itemList['godbook'] = {
    fullyDegrades: false,
    decayrate: 0.0,
    displayname: 'Dummies For Dummies',
    price: 1,
    weight: 0,
    nonStack: true,
    model: '',
    image: 'np_textbook-a.png',
    information: 'You look like you need knowlage',
    deg: false,
  };
  
  itemList['newaccountbox'] = {
    fullyDegrades: true,
    decayrate: 0.02,
    displayname: 'Presents',
    price: 350,
    weight: 0,
    nonStack: false,
    model: '',
    image: 'np_box.png',
    information: 'Welcome to NoPixel!',
    deg: true,
  };
  
  itemList['pimpcane'] = {
    fullyDegrades: false,
    decayrate: 2.0,
    displayname: 'Cane',
    price: 350,
    weight: 0,
    nonStack: false,
    model: '',
    image: 'np_pimp-cane.png',
    information: 'Walk with style.',
    deg: true,
  };
  
  itemList['notepiece'] = {
    fullyDegrades: false,
    decayrate: 0.0,
    displayname: 'Tờ giấy',
    price: 40,
    weight: 0,
    nonStack: false,
    model: '',
    image: 'np_receipt.png',
    information: 'Một tờ giấy không rõ',
    deg: false,
  };
  
  itemList['softdrink'] = {
    fullyDegrades: true,
    decayrate: 0.01,
    displayname: 'Soft Drink',
    price: 5,
    weight: 1,
    nonStack: false,
    model: '',
    image: 'np_softdrink.png',
    information: 'Sates thirst and gives a sugar rush',
    deg: false,
  };
  
  itemList['bscoffee'] = {
    fullyDegrades: true,
    decayrate: 0.01,
    displayname: 'Cheap Coffee',
    price: 50,
    weight: 1,
    nonStack: false,
    model: '',
    image: 'np_bscoffee.png',
    information: 'Tastes like dirt, but has the caffeine you need',
    deg: false,
  };





  itemList['taserammo'] = {
    fullyDegrades: true,
    decayrate: 0.1,
    displayname: 'Taser Cartridges',
    craft: [
      { itemid: 'aluminium', amount: 1 },
      { itemid: 'plastic', amount: 1 },
      { itemid: 'rubber', amount: 1 },
    ],
    price: 10,
    weight: 1,
    nonStack: false,
    model: '',
    image: 'np_taserammo.png',
    deg: false,
  };
  

  
// Nail gun nailgun
itemList['1748076076'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Nail gun',
  price: 10,
  craft: [[
    { itemid: 'aluminium', amount: 1 },
    { itemid: 'plastic', amount: 1 },
    { itemid: 'rubber', amount: 1 },
  ]],
  weight: 11,
  nonStack: true,
  model: '',
  image: 'np_nailgun.png',
  weapon: true,
};


  // weapon_glock
itemList['-120179019'] = {
    fullyDegrades: false,
    decayrate: 1.0,
    displayname: 'PD Glock',
    price: 10,
    craft: [
      { itemid: 'aluminium', amount: 1 },
      { itemid: 'plastic', amount: 1 },
      { itemid: 'rubber', amount: 1 },
    ],
    weight: 11,
    nonStack: true,
    model: '',
    image: 'np_glock.png',
    weapon: true,
    deg: true,
  };

  
// FISHING
itemList['fishingrod']	    = {fullyDegrades: true, decayrate: 0.4, displayname: 'Fishing Rod', price: 100, weight: 10, nonStack: true, model: '', image: 'np_fishing-rod.png', information: 'Cần câu thông dụng', deg: false,
};

itemList["fishingherring"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá trích", price: 1, weight: 3, nonStack: true, model:  "", image: "np-fishing-herring.png", information: "Một loại cá bé ở biển", deg: false }

itemList["fishinghalibut"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá bơn", price: 1, weight: 3, nonStack: true, model:  "", image: "np-fishing-halibut.png", information: "", deg: false }

itemList["fishingminnow"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá tuế", price: 1, weight: 3, nonStack: true, model:  "", image: "np-fishing-minnow.png", information: "", deg: false }

itemList["fishingredfish"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá da đỏ", price: 1, weight: 4, nonStack: true, model:  "", image: "np-fishing-redfish.png", information: "", deg: false }

itemList["fishingsalmon"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá hồi Alaska", price: 1, weight: 4, nonStack: true, model:  "", image: "np-fishing-salmon.png", information: "", deg: false }

itemList["fishingbarbel"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá Barbel", price: 1, weight: 4, nonStack: true, model:  "", image: "np-fishing-barbel.png", information: "", deg: false }

itemList["fishingtigerfish"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá Hổ", price: 1, weight: 5, nonStack: true, model:  "", image: "np-fishing-tigerfish.png", information: "", deg: false }

itemList["fishingmahseer"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá Mahseer", price: 1, weight: 5, nonStack: true, model:  "", image: "np-fishing-mahseer.png", information: "", deg: false }

itemList["fishinghake"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá Hake", price: 1, weight: 5, nonStack: true, model:  "", image: "np-fishing-hake.png", information: "", deg: false }

itemList["fishingbillfish"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá Kiếm", price: 1, weight: 5, nonStack: true, model:  "", image: "np-fishing-billfish.png", information: "", deg: false }

itemList["fishingredcod"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá Tuyết Đỏ", price: 1, weight: 5, nonStack: true, model:  "", image: "np-fishing-redcod.png", information: "Một loại cá kiếm trong các loại cá hiếm", deg: false }

itemList["fishbait"]	    = {fullyDegrades: true, decayrate: 0.5, displayname: "Mồi câu", price: 3, weight: 1.5, nonStack: false, model:  "", image: "pw_fishbait.png", information: "Mồi câu thông dụng trong câu cá", deg: false }

itemList["fishingeel"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Lươn biển", price: 1, weight: 5, nonStack: true, model:  "", image: "np-fishingeel.png", information: "Môt con lươn", deg: false }

itemList["fishingtuna"]	    = {fullyDegrades: true, decayrate: 1.0, displayname: "Cá Ngừ đại dương", price: 1, weight: 5, nonStack: true, model:  "", image: "np-fishsingtuna.png", information: "Cá ngừ sống ở vùng biển lớn", deg: false }

itemList['fishingbass'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Cá vược',
  price: 1,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_fishing-bass.png',
  information: 'Striped Bass. Bass like the fish, not the officer',
  deg: false,
};

itemList['fishingbluefish'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Bluefish',
  price: 1,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_fishing-bluefish.png',
  information: 'Whoever coined this name was a genius',
  deg: false,
};

itemList['fishingflounder'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Flounder',
  price: 1,
  weight: 4,
  nonStack: false,
  model: '',
  image: 'np_fishing-flounder.png',
  information: 'I went fishing and all I got was this lousy flounder',
  deg: false,
};

itemList['fishingmackerel'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Mackerel',
  price: 1,
  weight: 6,
  nonStack: false,
  model: '',
  image: 'np_fishing-mackerel.png',
  information: 'Sometimes holy',
  deg: false,
};

itemList['fishingcod'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Cod',
  price: 1,
  weight: 7,
  nonStack: false,
  model: '',
  image: 'np_fishing-cod.png',
  information: 'Modern Warfare',
  deg: false,
};

itemList['fishingwhale'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Cá voi (Con non)',
  price: 1,
  weight: 15,
  nonStack: true,
  model: '',
  image: 'np_fishing-whale.png',
  information: 'Đây là cá voi. Chỉ một số ít người mới dám mua nó...?',
  deg: false,
};

itemList['fishingdolphin'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Cá heo (Con non)',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_fishing-dolphin.png',
  information: 'Đây là cá heo. Chỉ một số ít người mới dám mua nó...?',
  deg: false,
};

itemList['fishingshark'] = {
  fullyDegrades: true,
  decayrate: 1.0,
  displayname: 'Cá mập (Con non)',
  price: 1,
  weight: 10,
  nonStack: true,
  model: '',
  image: 'np_fishing-shark.png',
  information: 'Đây là cá mập. Chỉ một số ít người mới dám mua nó...?',
  deg: false,
};

// FISHING JUNK

itemList['fishingboot'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Ủng rách',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishingboot.png',
  information: 'Vật này nhìn trông khá vô dụng',
  deg: false,
};

itemList['fishinglog'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Khúc gỗ',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishinglog.png',
  information: 'Vật này nhìn trông khá vô dụng',
  deg: false,
};

itemList['fishingtin'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Hộp thiếc',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishingtin.png',
  information: 'Vật này nhìn trông khá vô dụng',
  deg: false,
};

itemList['-102323637'] = {
  fullyDegrades: true,
  decayrate: 0.2,
  displayname: 'Chai bị vỡ',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_glass-bottle.png',
  information: 'insert shit here',
  deg: false,
};

itemList['fishingtacklebox'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Tackle box',
  price: 1,
  weight: 1,
  nonStack: false,
  model: '',
  image: 'np_fishingtacklebox.png',
  information: 'insert shit here',
  deg: false,
};

itemList['fishingchest'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Hộp kho báu',
  price: 1,
  weight: 5,
  nonStack: false,
  model: '',
  image: 'np_fishingchest.png',
  information: 'Một chiếc hộp cũ kĩ không rõ niên đại',
  deg: false,
};

itemList['fishinglockbox'] = {
  fullyDegrades: true,
  decayrate: 0.02,
  displayname: 'Lockbox',
  price: 1,
  weight: 10,
  nonStack: false,
  model: '',
  image: 'np_fishinglockbox.png',
  information: 'insert shit here',
  deg: false,
};

itemList['fishingtunac'] = {
  fullyDegrades: true,
  decayrate: 0.1,
  displayname: 'Tuna Chip',
  craft: [{ itemid: 'electronics', amount: 100 }],
  price: 500,
  weight: 0,
  nonStack: false,
  model: '',
  image: 'np_tuner.png',
  information: 'Works better on boats.',
  deg: false,
};

// FISHING END



itemList['stolentv'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Flat Panel TV (p)',
  craft: [[
    //{ itemid: 'aluminium', amount: 1 },
    //{ itemid: 'steel', amount: 1 },
    //{ itemid: 'copper', amount: 1 },
    //{ itemid: 'scrapmetal', amount: 1 },
    //{ itemid: 'rubber', amount: 1 },
    //{ itemid: 'plastic', amount: 5 },
    { itemid: 'genericelectronicpart', amount: 18 },
  ]],
  price: 710,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolentv.png',
};

itemList['stolenmusic'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Music Equipment (p)',
  craft: [[
    //{ itemid: 'aluminium', amount: 1 },
    //{ itemid: 'steel', amount: 1 },
    //{ itemid: 'copper', amount: 1 },
    //{ itemid: 'scrapmetal', amount: 1 },
    //{ itemid: 'rubber', amount: 1 },
    { itemid: 'genericelectronicpart', amount: 9 },
    //{ itemid: 'glass', amount: 1 },
    { itemid: 'stolenBrokenGoods', amount: 1 },
  ]],
  price: 210,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolenmusic.png',
};

itemList['stolencoffee'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Coffe Machine (p)',
  price: 350,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolencoffee.png',
};

itemList['stolenmicrowave'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Microwave (p)',
  price: 440,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolenmicrowave.png',
};

itemList['stolencomputer'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Computer Equipment (p)',
  craft: [[
    //{ itemid: 'aluminium', amount: 1 },
    //{ itemid: 'steel', amount: 1 },
    //{ itemid: 'copper', amount: 1 },
    //{ itemid: 'scrapmetal', amount: 1 },
    //{ itemid: 'rubber', amount: 1 },
    { itemid: 'genericelectronicpart', amount: 12 },
    //{ itemid: 'glass', amount: 1 },
    { itemid: 'stolenBrokenGoods', amount: 1 },
  ]],
  price: 475,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolencomputer.png',
};

itemList['stolenart'] = {
  fullyDegrades: false,
  isStolen: true,
  decayrate: 0.0,
  displayname: 'Art (p)',
  price: 2015,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolenart.png',
};

itemList['gatheringkit'] = {
  fullyDegrades: false,
  decayrate: 0.25,
  displayname: 'Kit Detetive',
  price: 1500,
  weight: 15,
  craft: [[
    { itemid: 'plastic', amount: 100 },
    { itemid: 'rubber', amount: 100 },
  ]],
  nonStack: false,
  model: '',
  image: 'np_cleaning-goods.png',
  information: 'Usado para coletar evidências.',
};

itemList['stolenBrokenGoods'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Broken Goods (p)',
  price: 25,
  weight: 50,
  nonStack: false,
  model: '',
  image: 'np_stolenBrokenGoods.png',
};

itemList['np_evidence_marker_red'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidência Vermelha',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_red.png',
};

itemList['np_evidence_marker_white'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidência Branca',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_white.png',
};

itemList['np_evidence_marker_orange'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidência Laranja',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_orange.png',
};

itemList['np_evidence_marker_light_blue'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidência Azul',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_light_blue.png',
};

itemList['np_evidence_marker_purple'] = {
  fullyDegrades: false,
  decayrate: 0.0,
  displayname: 'Evidência Roxa',
  price: 0,
  weight: 1,
  nonStack: true,
  model: '',
  image: 'np_evidence_marker_purple.png',
};