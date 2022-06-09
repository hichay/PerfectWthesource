const VehicleWeightModifiers = {
    //[classModifier, classBaseWeight, classMaxWeight]
    //A higher class modifier means the vehicle size will matter more
    //A higher base weight will mean vehicle # of seats matter more
    0: [1.0, 25, 150], //Compacts
    1: [2.0, 25, 100], //Sedans
    2: [5.0, 100, 250], //SUVs
    3: [3.0, 25, 150], //Coupes
    4: [3.0, 25, 100], //Muscle
    5: [1.0, 20, 50], //Sports Classics
    6: [2.0, 20, 100], //Sports
    7: [1.0, 25, 50], //Super
    8: [0.0, 0, 0], //Motorcycles
    9: [1.0, 100, 300], //Off-road
    10: [4.0, 50, 200], //Industrial
    11: [5.0, 10, 10], //Utility
    12: [5.0, 100, 300], //Vans
    13: [0.0, 0, 0], //Cycles
    14: [2.0, 0, 0], //Boats
    15: [1.0, 100, 400], //Helicopters
    16: [5.0, 50, 50], //Planes
    17: [10.0, 50, 100], //Service
    18: [2.0, 50, 100], //Emergency
    19: [5.0, 50, 100], //Military
    20: [20.0, 50, 100], //Commerical
    21: [10.0, 50, 100], //Trains
};

const VehicleWeightOverrides = {
    //Enter Model then overrided weight
    //ex. "nptaco": 0,
	/* "t20": 3000, */
	"sandking": 300.0,
    "sandking2": 300.0,
	"bobcatxl": 300.0,
	"caracara2": 250.0,
	"G632021": 200,
	"mcjcw20": 150,
	"BMWM5CS": 150,
	"G632019": 200,
	"rmodx6": 200,
	"rmodbentley1": 170,
	"AVJ": 100,
	"bdivo": 100,
	"db11": 150,
	"sadler": 300,
	"scrap": 300,
	"bison": 200,
	"bison2": 200,
	"raptor150": 150,
	"sh350": 150,
}