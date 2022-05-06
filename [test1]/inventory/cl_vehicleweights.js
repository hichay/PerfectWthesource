const VehicleWeightModifiers = {
    //[classModifier, classBaseWeight, classMaxWeight]
    //A higher class modifier means the vehicle size will matter more
    //A higher base weight will mean vehicle # of seats matter more
    0: [1.0, 20, 150], //Compacts
    1: [2.0, 20, 100], //Sedans
    2: [5.0, 100, 125], //SUVs
    3: [3.0, 50, 125], //Coupes
    4: [3.0, 100, 125], //Muscle
    5: [1.0, 20, 200], //Sports Classics
    6: [1.0, 20, 100], //Sports
    7: [1.0, 10, 50], //Super
    8: [0.0, 0, 0], //Motorcycles
    9: [1.0, 100, 300], //Off-road
    10: [4.0, 300, 1000], //Industrial
    11: [5.0, 250, 1000], //Utility
    12: [5.0, 100, 125], //Vans
    13: [0.0, 0, 0], //Cycles
    14: [2.0, 100, 300], //Boats
    15: [1.0, 100, 400], //Helicopters
    16: [5.0, 100, 4000], //Planes
    17: [10.0, 100, 1200], //Service
    18: [2.0, 200, 500], //Emergency
    19: [5.0, 200, 500], //Military
    20: [20.0, 250, 2000], //Commerical
    21: [10.0, 200, 500], //Trains
};

const VehicleWeightOverrides = {
    //Enter Model then overrided weight
    //ex. "nptaco": 0,
}