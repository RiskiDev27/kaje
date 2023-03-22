#define MAX_DOOR 500

enum ddoor
{
    dName[128],
    dPass[32],
    dIcon,
    dLocked,
    dAdmin,
    dVip,
    dFaction,
    dFamily,
    dGarage,
    dCustom,
    dExtvw,
    dExtInt,
    Float:
        dExtPosX,
        Float:
        dExtPosY,
        Float:
        dExtPosZ,
        Float:
        dExtPosA,
        dIntvw,
        dInt,
        Float:
        dIntPosX,
        Float:
        dIntPosY,
        Float:
        dIntPosZ,
        Float:
        dIntPosA,

        dCP,
        Text3D:
        dLabelExt,
        Text3D:
        dLabelInt,
        dPickupExt,
        dPickupInt
    };

new dData[MAX_DOOR][ddoor],
    Iterator:Doors<MAX_DOOR>;


// Save Door
Door_Save(id)
{
    new query[2048];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE `doors` SET `name` = '%s', `password` = '%s', `icon` = '%d', `locked` = '%d', `admin` = '%d', `vip` = '%d', `faction` = '%d', `family` = '%d', `garage` = '%d', `custom` = '%d', `extvw` = '%d', `extint` = '%d', `extposx` = '%f', `extposy` = '%f', `extposz` = '%f', `extposa` = '%f', `intvw` = '%d', `intint` = '%d', `intposx` = '%f', `intposy` = '%f', `intposz` = '%f', `intposa` = '%f' WHERE `ID` = '%d'", dData[id][dName], dData[id][dPass], dData[id][dIcon], dData[id][dLocked], dData[id][dAdmin], dData[id][dVip], dData[id][dFaction], dData[id][dFamily], dData[id][dGarage], dData[id][dCustom], dData[id][dExtvw], dData[id][dExtInt], dData[id][dExtPosX], dData[id][dExtPosY], dData[id][dExtPosZ], dData[id][dExtPosA], dData[id][dIntvw], dData[id][dInt], dData[id][dIntPosX], dData[id][dIntPosY], dData[id][dIntPosZ], dData[id][dIntPosA], id);
    mysql_tquery(g_SQL, query);
    print("Door Saved");
    return 1;
}

Door_UpdateLabel(id)
{
    if (id != -1)
    {
        if (IsValidDynamic3DTextLabel(dData[id][dLabelExt]))
            DestroyDynamic3DTextLabel(dData[id][dLabelExt]);

        if (IsValidDynamicPickup(dData[id][dPickupExt]))
            DestroyDynamicPickup(dData[id][dPickupExt]);

        if (IsValidDynamic3DTextLabel(dData[id][dLabelInt]))
            DestroyDynamic3DTextLabel(dData[id][dLabelInt]);

        if (IsValidDynamicPickup(dData[id][dPickupInt]))
            DestroyDynamicPickup(dData[id][dPickupInt]);

        if (IsValidDynamicCP(dData[id][dCP]))
            DestroyDynamicCP(dData[id][dCP]);

        if (dData[id][dGarage] == 1)
        {
            new dStr[512];
            format(dStr, sizeof(dStr), "[ID: %d]\n"LB_E"%s\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' to Enter", id, dData[id][dName]);
            dData[id][dPickupExt] = CreateDynamicPickup(19130, 23, dData[id][dExtPosX], dData[id][dExtPosY], dData[id][dExtPosZ], dData[id][dExtvw], dData[id][dExtInt]);
            dData[id][dLabelExt] = CreateDynamic3DTextLabel(dStr, COLOR_LOGS, dData[id][dExtPosX], dData[id][dExtPosY], dData[id][dExtPosZ] + 0.35, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, dData[id][dExtvw], dData[id][dExtInt]);

        }
        else
        {
            new dStr[512];
            format(dStr, sizeof(dStr), "[ID: %d]\n"LB_E"%s\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' To Enter", id, dData[id][dName]);
            dData[id][dPickupExt] = CreateDynamicPickup(19130, 23, dData[id][dExtPosX], dData[id][dExtPosY], dData[id][dExtPosZ], dData[id][dExtvw], dData[id][dExtInt]);
            dData[id][dLabelExt] = CreateDynamic3DTextLabel(dStr, COLOR_LOGS, dData[id][dExtPosX], dData[id][dExtPosY], dData[id][dExtPosZ] + 0.35, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, dData[id][dExtvw], dData[id][dExtInt]);
        }

        if (dData[id][dIntPosX] != 0.0 && dData[id][dIntPosY] != 0.0 && dData[id][dIntPosZ] != 0.0)
        {
            if (dData[id][dGarage] == 1)
            {
                new mstr[512];
                format(mstr, sizeof(mstr), "[ID: %d]\n"LB_E"%s\n{FFFFFF}Press '{FF0000}ENTER{FFFFFF}' To Exit", id, dData[id][dName]);
                dData[id][dPickupInt] = CreateDynamicPickup(19130, 23, dData[id][dIntPosX], dData[id][dIntPosY], dData[id][dIntPosZ], dData[id][dIntvw], dData[id][dInt], -1, 7);
                dData[id][dLabelInt] = CreateDynamic3DTextLabel(mstr, COLOR_LOGS, dData[id][dIntPosX], dData[id][dIntPosY], dData[id][dIntPosZ] + 0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, dData[id][dIntvw], dData[id][dInt]);
            }
            else
            {
                new mstr[512];
                format(mstr, sizeof(mstr), "[ID: %d]\n"LB_E"%s\n{FFFFFF} '{FF0000}ENTER{FFFFFF}' To Exit", id, dData[id][dName]);
                dData[id][dPickupInt] = CreateDynamicPickup(19130, 23, dData[id][dIntPosX], dData[id][dIntPosY], dData[id][dIntPosZ], dData[id][dIntvw], dData[id][dInt], -1, 7);
                dData[id][dLabelInt] = CreateDynamic3DTextLabel(mstr, COLOR_LOGS, dData[id][dIntPosX], dData[id][dIntPosY], dData[id][dIntPosZ] + 0.7, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, dData[id][dIntvw], dData[id][dInt]);

            }
        }
    }
}

function OnDoorsCreated(id)
{
    Door_Save(id);
    Door_UpdateLabel(id);
    return 1;
}

function LoadDoors()
{
    new rows = cache_num_rows();
    if (rows)
    {
        new did, name[128], password[128];
        for (new i; i < rows; i++)
        {
            cache_get_value_name_int(i, "ID", did);
            cache_get_value_name(i, "name", name);
            format(dData[did][dName], 128, name);
            cache_get_value_name(i, "password", password);
            format(dData[did][dPass], 128, password);
            cache_get_value_name_int(i, "icon", dData[did][dIcon]);
            cache_get_value_name_int(i, "locked", dData[did][dLocked]);
            cache_get_value_name_int(i, "admin", dData[did][dAdmin]);
            cache_get_value_name_int(i, "vip", dData[did][dVip]);
            cache_get_value_name_int(i, "faction", dData[did][dFaction]);
            cache_get_value_name_int(i, "family", dData[did][dFamily]);
            cache_get_value_name_int(i, "garage", dData[did][dGarage]);
            cache_get_value_name_int(i, "custom", dData[did][dCustom]);
            cache_get_value_name_int(i, "extvw", dData[did][dExtvw]);
            cache_get_value_name_int(i, "extint", dData[did][dExtInt]);
            cache_get_value_name_float(i, "extposx", dData[did][dExtPosX]);
            cache_get_value_name_float(i, "extposy", dData[did][dExtPosY]);
            cache_get_value_name_float(i, "extposz", dData[did][dExtPosZ]);
            cache_get_value_name_float(i, "extposa", dData[did][dExtPosA]);
            cache_get_value_name_int(i, "intvw", dData[did][dIntvw]);
            cache_get_value_name_int(i, "intint", dData[did][dInt]);
            cache_get_value_name_float(i, "intposx", dData[did][dIntPosX]);
            cache_get_value_name_float(i, "intposy", dData[did][dIntPosY]);
            cache_get_value_name_float(i, "intposz", dData[did][dIntPosZ]);
            cache_get_value_name_float(i, "intposa", dData[did][dIntPosA]);

            Iter_Add(Doors, did);
            Door_UpdateLabel(did);
        }
        printf("[Doors]: Number of Doors loaded: %d", rows);
    }
}

// Door System
CMD:createdoor(playerid, params[])
{
    if (pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    new did = Iter_Free(Doors), mstr[128], query[248];
    if (did == -1) return Error(playerid, "You can't create more door!");
    new name[128];
    if (sscanf(params, "s[128]", name))
        return Usage(playerid, "/createdoor [name]");

    format(dData[did][dName], 128, name);
    GetPlayerPos(playerid, dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ]);
    GetPlayerFacingAngle(playerid, dData[did][dExtPosA]);
    dData[did][dExtvw] = GetPlayerVirtualWorld(playerid);
    dData[did][dExtInt] = GetPlayerInterior(playerid);
    format(dData[did][dPass], 32, "");
    dData[did][dIcon] = 19130;
    dData[did][dLocked] = 0;
    dData[did][dAdmin] = 0;
    dData[did][dVip] = 0;
    dData[did][dFaction] = 0;
    dData[did][dFamily] = -1;
    dData[did][dGarage] = 0;
    dData[did][dCustom] = 0;
    dData[did][dIntvw] = 0;
    dData[did][dInt] = 0;
    dData[did][dIntPosX] = 0;
    dData[did][dIntPosY] = 0;
    dData[did][dIntPosZ] = 0;
    dData[did][dIntPosA] = 0;

    format(mstr, sizeof(mstr), "[ID: %d]\n{FFFFFF}%s{FFFFFF}Press {FF0000}ENTER {FFFFFF}to enter", did, dData[did][dName]);
    dData[did][dPickupExt] = CreateDynamicPickup(19130, 23, dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ], dData[did][dExtvw], dData[did][dExtInt]);
    dData[did][dLabelExt] = CreateDynamic3DTextLabel(mstr, COLOR_YELLOW, dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ] + 0.35, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, dData[did][dExtvw], dData[did][dExtInt]);
    Door_UpdateLabel(did);
    Iter_Add(Doors, did);

    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `doors` SET `ID` = '%d', `extvw` = '%d', `extint` = '%d', `extposx` ='%f', `extposy` = '%f', `extposz` = '%f', `extposa` = '%f', `name` = '%s'", did, dData[did][dExtvw], dData[did][dExtInt], dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ], dData[did][dExtPosA], name);
    mysql_tquery(g_SQL, query, "OnDoorsCreated", "i", did);
    return 1;
}

CMD:gotodoor(playerid, params[])
{
    new did;
    if (pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    if (sscanf(params, "d", did))
        return Usage(playerid, "/gotodoor [id]");

    if (!Iter_Contains(Doors, did)) return Error(playerid, "The Doors you specified ID of doesn't exist.");
    SetPlayerPosition(playerid, dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ], dData[did][dExtPosA]);
    SetPlayerInterior(playerid, dData[did][dExtInt]);
    SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
    pData[playerid][pInDoor] = -1;
    pData[playerid][pInHouse] = -1;
    pData[playerid][pInBiz] = -1;
    Servers(playerid, "You have teleport to door id %d", did);
    return 1;
}

CMD:editdoor(playerid, params[])
{
    static did,
           type[24],
           string[128];

    if (pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    if (sscanf(params, "ds[24]S()[128]", did, type, string))
    {
        Usage(playerid, "/editdoor [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, interior, password, name, locked , admin, VIP, faction, family, custom, virtual");
        return 1;
    }

    if ((did < 0 || did >= MAX_DOOR))
        return Error(playerid, "You have specified an invalid entrance ID.");

    if (!Iter_Contains(Doors, did)) return Error(playerid, "The Doors you specified ID of doesn't exists.");

    if (!strcmp(type, "location", true))
    {
        GetPlayerPos(playerid, dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ]);
        GetPlayerFacingAngle(playerid, dData[did][dExtPosA]);

        dData[did][dExtvw] = GetPlayerVirtualWorld(playerid);
        dData[did][dExtInt] = GetPlayerInterior(playerid);
        Door_Save(did);
        Door_UpdateLabel(did);

        SendAdminMessage(COLOR_RED, "%s has adjusted the location of entrance ID: %d", pData[playerid][pAdminname], did);
    }
    else if (!strcmp(type, "interior", true))
    {
        GetPlayerPos(playerid, dData[did][dIntPosX], dData[did][dIntPosY], dData[did][dIntPosZ]);
        GetPlayerFacingAngle(playerid, dData[did][dIntPosA]);

        dData[did][dIntvw] = GetPlayerVirtualWorld(playerid);
        dData[did][dInt] = GetPlayerInterior(playerid);
        Door_Save(did);
        Door_UpdateLabel(did);

        SendAdminMessage(COLOR_RED, "{FFFF00}%s{FFFFFF} has adjusted the interior of entrance ID: %d.", pData[playerid][pAdmin], did);
    }
    else if (!strcmp(type, "custom", true))
    {
        new status;

        if (sscanf(string, "d", status))
            return Usage(playerid, "/editdoor [id] [custom] [0/1]");

        if (status < 0 || status > 1)
            return Error(playerid, "You must specified at least 0 or 1");

        dData[did][dCustom] = status;
        Door_Save(did);
        Door_UpdateLabel(did);

        if (status)
        {
            SendAdminMessage(COLOR_RED, "%s has enabled custom interior mode for entrance ID: %d", pData[playerid][pAdminname], did);

        }
        else
        {
            SendAdminMessage(COLOR_RED, "%s has disable custom interior mode for entrance ID: %d", pData[playerid][pAdmin], did);
        }
    }
    else if (!strcmp(type, "virtual", true))
    {
        new worldid;

        if (sscanf(string, "d", worldid))
            return Usage(playerid, "/editdoor [virtual] [worldid]");

        dData[did][dExtvw] = worldid;

        Door_Save(did);
        Door_UpdateLabel(did);
        SendAdminMessage(COLOR_RED, "%s has adjusted the virtual of entrance ID: %d to %d.", pData[playerid][pAdminname], did, worldid);
    }
    else if (!strcmp(type, "password", true))
    {
        new pass[32];

        if (sscanf(string, "s[32]", pass))
            return Usage(playerid, "/editdoor [id] [password] [entrance pass] (use 'none' to disable)");

        if (!strcmp(pass, "none", true))
        {
            format(dData[did][dPass], 32, "");
        }
        else
        {
            format(dData[did][dPass], 32, pass);
        }

        Door_Save(did);
        Door_UpdateLabel(did);
        SendAdminMessage(COLOR_RED, "%s has adjusted the password of entrance ID: %d to %s", pData[playerid][pAdminname], did, pass);
    }
    else if (!strcmp(type, "locked", true))
    {
        new locked;

        if (sscanf(string, "d", locked))
            return Usage(playerid, "/editdoor [id] [locked] [locked 0/1]");

        if (locked < 0 || locked > 1)
            return Error(playerid, "Invalid value. Use 0 for unlocked and 1 for locked");

        dData[did][dLocked] = locked;
        Door_Save(did);
        Door_UpdateLabel(did);

        if (locked)
        {
            SendAdminMessage(COLOR_RED, "%s has locked entrance ID: %d", pData[playerid][pAdminname], did);
        }
        else
        {
            SendAdminMessage(COLOR_RED, "%s has unlocked entrance ID: %d", pData[playerid][pAdminname], did);
        }
    }
    else if (!strcmp(type, "name", true))
    {
        new name[128];

        if (sscanf(string, "s[128]", name))
            return Usage(playerid, "/editdoor [id] [name] [new name]");

        format(dData[did][dName], 128, ColouredText(name));

        Door_Save(did);
        Door_UpdateLabel(did);

        SendAdminMessage(COLOR_RED, "%s has adjusted the name of entrance ID: %d to \"%s\".", pData[playerid][pAdminname], did, ColouredText(name));
    }
    else if (!strcmp(type, "vip", true))
    {
        new level;

        if (sscanf(string, "d", level))
            return Usage(playerid, "/editdoor [id] [VIP] [level]");

        if (level  < 0 || level > 3)
            return Error(playerid, "Invalid value. Use 0 - 3 for level");

        dData[did][dVip] = level;
        Door_Save(did);
        Door_UpdateLabel(did);

        SendAdminMessage(COLOR_RED, "%s has set entrance ID: %d to VIP level: %d", pData[playerid][pAdminname], did, level);
    }
    else if (!strcmp(type, "faction", true))
    {
        new fid;

        if (sscanf(string, "d", fid))
            return Usage(playerid, "/editdoor [id] [faction] [faction id]");

        if (fid < 0 || fid > 4)
            return Error(playerid, "Invalid value | Use 0 - 4 for type");

        dData[did][dFaction] = fid;
        Door_Save(did);
        Door_UpdateLabel(did);

        SendAdminMessage(COLOR_RED, "%s has set entrance ID: %d to faction id %d", pData[playerid][pAdminname], did, fid);
    }
    else if (!strcmp(type, "family", true))
    {
        new fid;

        if (sscanf(string, "d", fid))
            return Usage(playerid, "/editdoor [id] [family] [family id]");

        if (fid < -1 || fid > 9)
            return Error(playerid, "Invalid value. Use -1 to 9 for family id");

        dData[did][dFamily] = fid;
        Door_Save(did);
        Door_UpdateLabel(did);

        SendAdminMessage(COLOR_RED, "%s has set entrance ID: %d to family id %d", pData[playerid][pAdminname], did, fid);
    }
    return 1;
}