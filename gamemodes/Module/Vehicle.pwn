



#define MAX_PRIVATE_VEHICLE (1000)
#define MAX_PLAYER_VEHICLE (3)
new bool:VehicleHealthSecurity[MAX_VEHICLES] = false, Float:VehicleHealthSecurityData[MAX_VEHICLES] = 1000.0;


enum pvdata
{
    cID,
    cOwner,
    cModel,
    cColor1,
    cColor2,
    cPaintJob,
    cNeon,
    cTogNeon,
    cLocked,
    cInsu,
    cClaim,
    cClaimTime,
    cPlate[15],
    cPlateTime,
    cTicket,
    cPrice,
    Float:cHealth,
    cFuel,
    Float:cPosX,
    Float:cPosY,
    Float:cPosZ,
    Float:cPosA,
    cInt,
    cVw,
    cDamage0,
    cDamage1,
    cDamage2,
    cDamage3,
    cMod[17],
    cLumber,
    cMetal,
    cCoal,
    cProduct,
    cGasOil,
    cRent,
    cVeh,
    cDeath,
    cPark,
    bool:PurchasedvToy,
    vtoySelected,
    bool:LoadedStorage
};

new pvData[MAX_PRIVATE_VEHICLE][pvdata],
    Iterator:PVehicles < MAX_PRIVATE_VEHICLE + 1 >;

//Private Vehicle Player System Native
new const g_arrVehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

GetVehicleModelByName(const name[])
{
    if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611)) return strval(name);

    for (new i = 0; i < sizeof(g_arrVehicleNames); i++)
    {
        if (strfind(g_arrVehicleNames[i], name, true) != -1)
        {
            return i + 400;
        }
    }
    return 0;
}

IsABoat(vehicleid)
{
    switch (GetVehicleModel(vehicleid))
    {
        case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595:
            return 1;
    }
    return 0;
}

IsAPlane(vehicleid)
{
    switch (GetVehicleModel(vehicleid))
    {
        case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593:
            return 1;
    }
    return 0;
}

IsAHelicopter(vehicleid)
{
    switch (GetVehicleModel(vehicleid))
    {
        case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563:
            return 1;
    }
    return 0;
}

GetEngineStatus(vehicleid)
{
    static engine,
           light,
           alarm,
           doors,
           bonnet,
           boot,
           objective;

    GetVehicleParamsEx(vehicleid, engine, light, alarm, doors, bonnet, boot, objective);

    if (engine != 1)
        return 0;

    return 1;
}

IsEngineVehicle(vehicleid)
{
    static const g_aEngineStatus[] =
    {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
        1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
    };
    new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aEngineStatus[modelid - 400]);
}

GetHoodStatus(vehicleid)
{
    static engine,
           lights,
           alarm,
           doors,
           bonnet,
           boot,
           objective;

    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if (bonnet != 1)
        return 0;

    return 1;
}

GetTrunkStatus(vehicleid)
{
    static engine,
           lights,
           alarm,
           doors,
           bonnet,
           boot,
           objective;

    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if (boot != 1)
        return 0;

    return 1;
}


function EngineStatus(playerid, vehicleid)
{
    if (!GetEngineStatus(vehicleid))
    {
        foreach (new ii : PVehicles)
        {
            if (vehicleid == pvData[ii][cVeh])
            {
                if (pvData[ii][cTicket] >= 2000)
                    return Error(playerid, "This vehicle has a pending ticket in SAPD Officer! /v insu -> to check pending ticket");
            }
        }

        new Float:f_vHealth;
        GetVehicleHealth(vehicleid, f_vHealth);
        if (f_vHealth < 350.0) return Error(playerid, "The cars won't start - it's totalled!");
        if (GetVehicleFuel(vehicleid) <= 0.0) return Error(playerid, "The car won't start - there's no fuel in the tank!");

        SwitchVehicleEngine(vehicleid, true);
        InfoTD_MSG(playerid, 4000, "Engine ~g~ON");
        SendClientMessage(playerid, ARWIN, "VEHICLE: {FFFFFF}You have "LG_E"successfuly {FFFFFF}started engine");
        vehicleid = GetPlayerVehicleID(playerid);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Turn on engine of vehicle %s", ReturnName(playerid, 0), GetVehicleName(vehicleid));

    }
    else
    {
        SwitchVehicleEngine(vehicleid, false);
        InfoTD_MSG(playerid, 4000, "Engine ~r~ OFF");
        vehicleid = GetPlayerVehicleID(playerid);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s Turn off engine of vehicle %s", ReturnName(playerid), GetVehicleName(vehicleid));
    }
    return 1;
}

CMD:veh(playerid, params[])
{
    static type[20],
           string[225],
           vehicleid;

    if (sscanf(params, "s[20]S()[128]", type, string))
    {
        SendClientMessage(playerid, 0x00A6FBFF, "_______________Vehicle Command__________________");
        SendClientMessage(playerid, COLOR_FAMILY, "[VEHICLE]: /v >> [engine](Y) | [hood] [trunk] [tow] [untow]");
        SendClientMessage(playerid, COLOR_FAMILY, "[VEHICLE]: /v >> [my](/mv) | [lock] | [park]");
        return 1;
    }

    if (!strcmp(type, "en", true))
    {
        vehicleid = GetPlayerVehicleID(playerid);
        if (IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            if (!IsEngineVehicle(vehicleid))
                return Error(playerid, "You are not in any vehicles");

            if (GetEngineStatus(vehicleid))
            {
                EngineStatus(playerid, vehicleid);
            }
            else
            {
                InfoTD_MSG(playerid, 2000, "Turn on Engine");
                SetTimerEx("EngineStatus", 4000, false, "id", playerid, vehicleid);
                ShowProgressbar(playerid, "Turn on engine", 4);
            }
        }
        else return Error(playerid, "Anda harus mengendarai kendaraan!");
    }
    else if (!strcmp(type, "hood", true))
    {
        if (IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu harus keluar dari kendaraan");

        vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);

        if (vehicleid == INVALID_VEHICLE_ID)
            return Error(playerid, "Kamu tidak berada didekat kendaraan apapun.");

        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        switch (GetHoodStatus(vehicleid))
        {
            case false:
            {
                SwitchVehicleBonnet(vehicleid, true);
                InfoTD_MSG(playerid, 4000, "Vehicle Hood ~g~ Dibuka");
            }
            case true:
            {
                SwitchVehicleBonnet(vehicleid, false);
                InfoTD_MSG(playerid, 4000, "Vehicle Hood ~r~ Ditutup");
            }
        }
    }
    else if (!strcmp(type, "trunk", true))
    {
        if (IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Kamu harus keluar dari kendaraan.");

        vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);

        if (vehicleid == INVALID_VEHICLE_ID)
            return Error(playerid, "Kamu tidak berada didekat kendaran apapun.");

        switch (GetTrunkStatus(vehicleid))
        {
            case false:
            {
                SwitchVehicleBoot(vehicleid, true);
                Vehicle(playerid, "trunk "GREEN_E"dibuka");
                return callcmd:veh(playerid, "storage");
            }
            case true
            {
                SwitchVehicleBoot(vehicleid, false);
                Vehicle(playerid, "Vehicle trunk "RED_E"ditutup.");
            }
        }
    }

    return 1;
}
