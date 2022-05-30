Config = Config or {}

Config.ActivePolice = 0     --<< needed policemen to activate the mission
Config.ActivationCost = 5000       --<< how much is the activation of the mission (clean from the bank)
Config.DealerCoords = vector3(960.78, -216.25, 76.25)   -- << place where the NPC dealer stands
Config.MissionMarker = vector3(960.71197509766, -215.51979064941, 76.2552947998)
Config.DriverWeapon = "WEAPON_MICROSMG" -- << the weapon the guards should be equipped with
Config.TimeToBlow = 10 -- time in seconds

Config.VehicleSpawn = {     -- << below the coordinates for where bank truck can spawn
    [1] = {
        coords = vector3(-1327.479736328, -86.045326232910, 49.31)
    },
    [2] = {
        coords = vector3(-2075.888183593, -233.73908996580, 21.10)
    },
    [3] = {
        coords = vector3(-972.1781616210, -1530.9045410150, 4.890)
    },
    [4] = {
        coords = vector3(798.18426513672, -1799.8173828125, 29.33)
    },
    [5] = {
        coords = vector3(1247.0718994141, -344.65634155273, 69.08)
    },

}

Config.CashA = 5000     --<< how much maximum you can get from a robbery
Config.CashB = 7700     --<< how much maximum you can get from a robbery