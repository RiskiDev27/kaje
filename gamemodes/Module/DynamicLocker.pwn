






// -----[ Dynamic Locker System ]-----

#define MAX_LOCKERS (100)

enum lockerinfo
{
    lType,
    Float:lPosX,
    Float:lPosY,
    Float:lPosZ,
    lInt,
    Text3D:lLabel,
    lPickup
};

new lData[MAX_LOCKERS][lockerinfo],
    Iterator:Lockers<MAX_LOCKERS>;

Locker_Refresh(lid)
{
    if (lid != -1)
    {
        if (IsValidDynamic3DTextLabel(lLabel))
            DestroyDynamic3DTextLabel(lLabel);

        if (IsValidDynamicPickup(lPickup))
            DestroyDynamicPickup(lPickup);

        static string[255];

        new type[128];
        if (lData[lid][lType] == 1)
        {
            type = "San Andreas Police Departement";
        }
        else if (lData[lid][lType] == 2)
        {
            type = "san Andreas Goverment Service";
        }
        else if (lData[lid][lType] == 3)
        {
            type = "San Andreas medical Departement";
        }
        else if (lData[lid][lType] == 4)
        {
            type = "San Andreas News Agency";
        }
        else if (lData[lid][lType] == 6)
        {
            type = "VIP";
        }
        else
        {
            type = "Unknown";
        }

        format(string, sizeof(string), "[ID: %d]\n"WHITE_E"Type: "YELLOW_E"%s\n"WHITE_E"Type "RED_E"/locker"WHITE_E" to open", lid, type);
        lData[lid][lPickup] = CreateDynamicPickup(1239, 23, lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ] + 0.2, 0, lData[lid][lInt], _, 4);
        lData[lid][lLabel] = CreateDynamic3DTextLabel(string, COLOR_BLUE, lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ] + 0.5, 2.5);
    }
    return 1;
}

function LoadLocker()
{
    static lid;

    new rows = cache_num_rows();
    if (rows)
    {
        for (new i; i < rows; i++)
        {
            cache_get_value_name_int(i, "id", lid);
            cache_get_value_name_int(i, "type", lData[lid][lType]);
            cache_get_value_name_float(i, "posx", lData[lid][lPosX]);
            cache_get_value_name_float(i, "posy", lData[lid][lPosY]);
            cache_get_value_name_float(i, "posz", lData[lid][lPosZ]);
            cache_get_value_name_int(i, "interior", lData[lid][lInt]);
            Locker_Refresh(lid);
            Iter_Add(Lockers, lid);
        }
        printf("[Dynamic Locker Faction]: Number of loaded >> %d", rows);
    }
}

Locker_Save(lid)
{
    new query[512];
    format(query, sizeof(query), "UPDATE lockers SET type='%d', posx='%f', posy='%f', posz='%f', interior='%d' WHERE id = '%d", lData[lid][lType], lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ], lData[lid][lInt], lid);
    return mysql_tquery(g_SQL, query);
}

function OnLockerCreated(lid)
{
    Locker_Refresh(lid);
    Locker_Save(lid);
    return 1;
}

GetLockerName(lid)
{
    new faction[128];
    if (lData[lid][lType] == 1)
    {
        faction = "San Andreas Police Departement";
    }
    else if (lData[lid][lType] == 2)
    {
        faction = "san Andreas Goverment Service";
    }
    else if (lData[lid][lType] == 3)
    {
        faction = "San Andreas medical Departement";
    }
    else if (lData[lid][lType] == 4)
    {
        faction = "San Andreas News Agency";
    }
    else if (lData[lid][lType] == 6)
    {
        faction = "VIP";
    }
    else
    {
        faction = "Unknown";
    }
    return faction;
}

// Dynamic Locker System
CMD:createlocker(playerid, params[])
{
    if (!pData[playerid][pAdmin] == 6)
        return PermissionError(playerid);

    if (!pData[playerid][pAdminDuty])
        return Error(playerid, "You're not On Duty Admin!");

    new lid = Iter_Free(Lockers), query[128], log[300];
    if (lid == -1) return Error(playerid, "You can't create more locker!");
    new type;
    if (sscanf(params, "d", type))
        return Usage(playerid, "/createlocker [type, 1.SAPD, 2.SAGS, 3.SAMD, 4.SANA, 5.PEDAGANG, 6.VIP locker]");

    if (type < 1 || type > 6) return Error(playerid, "Invalid Type!");

    GetPlayerPos(playerid, lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ]);
    lData[lid][lInt] = GetPlayerInterior(playerid);
    lData[lid][lType] = type;
    Locker_Refresh(lid);
    Iter_Add(Lockers, lid);

    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO lockers SET id='%d', type='%d', posx='%f', posy='%f', posz='%f'", lid, lData[lid][lType], lData[lid][lPosX], lData[lid][lPosY], lData[lPosZ]);
    mysql_tquery(g_SQL, query, "OnLockerCreated", "i", lid);
    format(log, sizeof(log), "***LOCKER***\n```LOCKER: %s has Created Locker %d >> pos %f %f %f", pData[playerid][pAdminname], GetLockerName(type), lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ]);
    DCC_SendChannelMessage(g_discord_logServer, log);
    return 1;
}

CMD:gotolocker(playerid, params[])
{
    new lid;
    if (pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    if (!pData[playerid][pAdminDuty])
        return Error(playerid, "You're not On Duty Admin!");

    if (sscanf(params, "d", lid))
        return Usage(playerid, "/gotolocker [id]");

    if (!Iter_Contains(Lockers, lid)) return Error(playerid, "The Locker your specified ID of doesn't exist.");
    SetPlayerPos(playerid, lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ]);
    SetPlayerInterior(playerid, lData[lid][lInt]);
    SetPlayerVirtualWorld(playerid, 0);
    Servers(playerid, "You has teleport to locker id %d", lid);
    new log[300];
    format(log, sizeof(log), "***LOCKER***\nLOCKER: Admin %s has teleported to locker id: %d >> faction: %s", pData[playerid][pAdminname], lid, GetLockerName(lData[lid][lType]));
    DCC_SendChannelMessage(g_discord_logServer, log);
    return 1;
}

CMD:editlocker(playerid, params[])
{
    if (!pData[playerid][pAdmin] == 6)
        return PermissionError(playerid);

    if (!pData[playerid][pAdminDuty])
        return Error(playerid, "You're not OnDuty Admin!");

    static lid,
           type[24],
           string[128];

    if (sscanf(params, "ds[24]S()[128]", lid, type, string))
    {
        Usage(playerid, "/editlocker >> [id] >> [name]");
        SendClientMessage(playerid, 0xA6D497, "[NAMES]:{FFFFFF} location, type, delete");
        return 1;
    }

    if ((lid < 0 || lid > MAX_LOCKERS))
        return Error(playerid, "You have specified an invalid ID");

    if (!Iter_Contains(Lockers, lid)) return Error(playerid, "The Lockers you have specified ID of doesn't exist.");

    if (!strcmp(type, "location", true))
    {
        GetPlayerPos(playerid, lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ]);
        lData[lid][lInt] = GetPlayerInterior(playerid);
        Locker_Save(lid);
        Locker_Refresh(lid);

        SendAdminMessage(COLOR_RED, "Admin %s has adjusted the location %f >> %f >> %f of locker ID: %d", pData[playerid][pAdmin], lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ], lid);
        new log[300];
        format(log, sizeof(log), "***LOCKER***\nLOCKER: Admin %s has adjusted the location %f >> %f >> %f of locker ID: %d", pData[playerid][pAdminname], lData[lid][lPosX], lData[lid][lPosY], lData[lid][lPosZ], lid);
        DCC_SendChannelMessage(g_discord_logServer, log);
    }
    else if (!strcmp(type, "type", true))
    {
        new tipe;

        if (sscanf(string, "d", tipe))
            return Usage(playerid, "/editlocker >> [id] >> [type: 1.SAPD, 2.SAGS, 3.SAMD, 4.SANA 5.VIP Locker]");

        if (tipe < 1 || tipe > 5)
            return Error(playerid, "You must specified at least 1 - 5");

        lData[lid][lType] = tipe;
        Locker_Save(lid);
        Locker_Refresh(lid);

        SendAdminMessage(COLOR_RED, "Admin %s has set locket ID: %d to type id faction %d", pData[playerid][pAdminname], lid, tipe);
        new log[300];
        format(log, sizeof(log), "***LOCKER***\nLOCKER: Admin %s has set locket ID: %d to type id faction %d", pData[playerid][pAdminname], lid, tipe);
        DCC_SendChannelMessage(g_discord_logServer, log);
    }
    else if (!strcmp(type, "delete", true))
    {
        new query[128];
        DestroyDynamic3DTextLabel(lData[lid][lLabel]);
        DestroyDynamicPickup(lData[lid][lPickup]);
        lData[lid][lPosX] = 0;
        lData[lid][lPosY] = 0;
        lData[lid][lPosZ] = 0;
        lData[lid][lInt] = 0;
        lData[lid][lLabel] = Text3D:INVALID_3DTEXT_ID;
        lData[lid][lPickup] = -1;
        Iter_Remove(Lockers, lid);
        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM lockers WHERE id=%d", lid);
        mysql_tquery(g_SQL, query);
        SendAdminMessage(COLOR_RED, "Admin %s >> has delete locker ID: %d", pData[playerid][pAdminname], lid);
        new log[300];
        format(log, sizeof(log), "**LOCKER**\n> CMD LOCKER: Admin %s telah menghapus locker ID >> %d", pData[playerid][pAdminname], lid);
        DCC_SendChannelMessage(g_discord_logServer, log);
    }
    return 1;
}

CMD:lockerid(playerid, params[])
{
    new idx, lid;
    for (idx; idx < lid; idx++)
    {
        SendClientMessageEx(playerid, -1, "Locker %d to faction %s\n", idx, GetLockerName(lid));
    }
    return 1;
}