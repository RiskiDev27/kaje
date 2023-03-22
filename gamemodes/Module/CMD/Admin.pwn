CMD:aduty(playerid, params[])
{
    if (pData[playerid][pAdmin] < 1)
        if (pData[playerid][pHelper] == 0)
            return PermissionError(playerid);

    if (!strcmp(pData[playerid][pAdminname], "None"))
        return Error(playerid, "You must set your admin name to owner!");

    if (!pData[playerid][pAdminDuty])
    {
        if (pData[playerid][pAdmin] > 0)
        {
            SetPlayerColor(playerid, 0xFF0000);
            pData[playerid][pAdminDuty] = 1;
            SetPlayerName(playerid, pData[playerid][pAdminname]);
            SendStaffMessage(COLOR_RIKO, "{FF0000}%s {FFFFFF} %s has "GREEN_E"Onduty {FFFFFF} Admins", GetStaffRank(playerid), pData[playerid][pName]);
        }
        else
        {
            SetPlayerColor(playerid, COLOR_GREEN);
            pData[playerid][pAdminDuty] = 1;
            SetPlayerName(playerid, pData[playerid][pAdminname]);
            SendStaffMessage(COLOR_RIKO, "{FFFFFF} %s has "PURPLE_E"Onduty {FFFFFF} Helper", GetStaffRank(playerid), pData[playerid][pName]);
        }
    }
    else
    {
        // if(pData[playerid][pFaction] != -1 && pData[playerid][pOnDuty])
        SetPlayerColor(playerid, COLOR_WHITE);
        pData[playerid][pAdminDuty] = 0;
        SetPlayerName(playerid, pData[playerid][pName]);
        SendStaffMessage(COLOR_RIKO, "{FF0000} %s {FFFFFF} %s has "YELLOW_E"Offduty {FFFFFF} Admins", GetStaffRank(playerid), pData[playerid][pName]);
    }
    return 1;
}

CMD:setadminname(playerid, params[])
{
    if (pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    new aname[128], otherid, query[128];
    if (sscanf(params, "us[128]", otherid, aname))
    {
        Usage(playerid, "/setadminname [Name/ID] >> [admin name]");
        return 1;
    }

    mysql_format(g_SQL, query, sizeof(query), "SELECT `adminname` FROM `players` WHERE `adminname` = '%s'", aname);
    mysql_tquery(g_SQL, query, "a_ChangeAdminName", "iis", otherid, playerid, aname);
    return 1;
}

CMD:restart(playerid, params[])
{
    new time;

    if (pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if (g_ServerRestart)
    {
        TextDrawHideForAll(gServerTextdraws[1]);

        g_ServerRestart = 0;
        g_RestartTime = 0;

        return SendClientMessageToAllEx(0xB38D97FF, "[ADMIN]: %s postponed the server restart.", pData[playerid][pAdminname]);
    }
    if (sscanf(params, "d", time))
        return Usage(playerid, "/restart [seconds]");

    if (time < 3 || time > 600)
        return Error(playerid, "The specified second can't be below 3 or above 600");

    TextDrawShowForAll(gServerTextdraws[1]);

    g_ServerRestart = 1;
    g_RestartTime = time;

    SendClientMessageToAllEx(0xB38D97FF, "[ADMIN]: "RED_E"%s{FFFFFF} has inititalted a server restart in %d seconds", pData[playerid][pAdminname], time);
    return 1;
}

CMD:cokbadai(playerid, params[])
{
    new time;

    if (pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);

    if (g_ServerBadai)
    {
        TextDrawHideForAll(gServerTextdraws[1]);

        g_ServerBadai = 0;
        g_BadaiTime = 0;

        return SendClientMessageToAllEx(COLOR_BAN, "[ADMIN]: "RED_E"%s{FFFFFF} postponed the server restart.", pData[playerid][pAdminname]);
    }
    if (sscanf(params, "d", time))
        return Usage(playerid, "/BADAI [seconds]");

    if (time < 3 || time > 600)
        return Error(playerid, "The specified second can't be below 3 or above 600");

    TextDrawShowForAll(gServerTextdraws[1]);

    g_ServerBadai = 1;
    g_BadaiTime = time;

    SendClientMessageToAllEx(COLOR_BAN, "[ADMIN]: %s {FFFFFF}has inititalted a server maintenance in %d seconds", pData[playerid][pAdminname], time);
    return 1;
}

CMD:adminjail(playerid, params[])
{
    if (pData[playerid][pAdmin] < 1)
        if (pData[playerid][pHelper] == 0)
            return PermissionError(playerid);

    new count = 0, line3[512];
    foreach (new i : Player)
    {
        if (pData[i][pJail] > 0)
        {
            format(line3, sizeof(line3), "%s\n"WHITE_E"%s(ID: %d)[Jail Time: %d seconds]", line3, pData[i][pName], i, pData[i][pJailTime]);
            count++;
        }
    }
    if (count > 0)
    {
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Jail Player", line3, "Close", "");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"Jail Player", "There are no player in jail!", "Close", "");
    }
    return 1;
}

CMD:jail(playerid, params[])
{
    if (pData[playerid][pAdmin] < 1)
        if (pData[playerid][pHelper] == 0)
            return PermissionError(playerid);

    new reason[60], timeSec, otherid;
    new string[300];
    if (sscanf(params, "uD(15)S(*)[60]", otherid, timeSec, reason))
    {
        Usage(playerid, "/jail [ID/Name] [time] [reason]");
        return 1;
    }

    if (!IsPlayerConnected(otherid))
        return Error(playerid, "Player not connected!");

    if (pData[otherid][pSpawned] == 0)
    {
        Error(playerid, "%s(%i) isn't spawned", pData[otherid][pName], otherid);
        return 1;
    }

    if (reason[0] != '*' && strlen(reason) > 60)
    {
        Error(playerid, "Reason too long! Must be smaller than 60 characters!");
        return 1;
    }

    if (timeSec < 1 || timeSec > 60)
    {
        if (pData[playerid][pAdmin] < 5)
        {
            Error(playerid, "Jail time mus be remain between 1 and 60 minutes");
            return 1;
        }
    }

    pData[otherid][pJail] = 1;
    pData[otherid][pJailTime] = timeSec * 60;
    JailPlayer(playerid);
    if (reason[0] == '*')
    {
        SendClientMessageToAllEx(COLOR_BAN, "AdmCmd: %s Has Jailed Player %s For %d Minute.", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
        format(string, sizeof(string), ">>>JAIL: Admin %s telah menjail player %s selama %d menit. >>>", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
        print(string);
    }
    else
    {
        SendClientMessageToAllEx(COLOR_BAN, "AdmCmd: %s Has Jailed Player %s For %d Minute", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
        SendClientMessageToAllEx(COLOR_BAN, "Reason: %s", reason);
        format(string, sizeof(string), ">>>JAIL: Admin: %s telah menjail player: %s selama %d menit. REASON: %s >>>", pData[playerid][pAdminname], pData[otherid][pName], timeSec);
        print(string);
    }
    return 1;
}

CMD:unjail(playerid, params[])
{
    if (pData[playerid][pAdmin] < 1)
        if (pData[playerid][pHelper] < 2)
            return PermissionError(playerid);

    new otherid;
    new string[300];
    if (sscanf(params, "u", otherid))
    {
        Usage(playerid, "/unjail [ID/Name]");
        return 1;
    }

    if (!IsPlayerConnected(otherid))
        return Error(playerid, "Player Not Connected!");

    if (pData[otherid][pJail] == 0)
        return Error(playerid, "The player isn't in jail");

    pData[otherid][pJail] = 0;
    pData[otherid][pJailTime] = 0;
    SetPlayerInterior(otherid, 0);
    SetPlayerPos(otherid, 1529.6, -1691.2, 13.3);
    SetPlayerSpecialAction(otherid, SPECIAL_ACTION_NONE);

    SendClientMessageToAllEx(COLOR_BAN, "AdmCmd: %s Unjailed Player %s", pData[playerid][pAdminname], pData[otherid][pName]);
    format(string, sizeof(string), "<<<JAIL: admin -> %s telah unjailed %s  >>>", pData[playerid][pAdminname], pData[otherid][pName]);
    print(string);
    return 1;
}

CMD:gotocord(playerid, params[])
{
    if (pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

new Float:
    pos[3], int;
    if (sscanf(params, "fffd", pos[0], pos[1], pos[2], int)) return Usage(playerid, "/gotocord [x, y, z, interior]");

    Servers(playerid, "You have been teleported to the coordinates specified.");
    SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    SetPlayerInterior(playerid, int);
    return 1;
}

CMD:jetpack(playerid, params[])
{
    if (pData[playerid][pAdmin] < 1)
        if (pData[playerid][pHelper] == 0)
            return PermissionError(playerid);

    new otherid;
    if (sscanf(params, "u", otherid))
    {
        pData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    }
    else
    {
        pData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
        Servers(playerid, "You have spawned a jetpack for %s.", pData[otherid][pAdminname]);
    }
    return 1;
}

CMD:veh(playerid, params[])
{
    static model[32],
           color1,
           color2;

    if (pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    new string[300];

    if (sscanf(params, "s[32]I(-1)I(-1)", model, color1, color2)) return Usage(playerid, "/cars [model ID/name cars] [Color First] [Color Second]");

    if ((model[0] = GetVehicleModelByName(model)) == 0)
        return Error(playerid, "Invalid model ID!");

    static Float:x, Float:y, Float:z, Float:a, vehicleid;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    vehicleid = CreateVehicle(model[0], x, y + 4.5, z, a, color1, color2, 0);

    if (GetPlayerInterior(playerid) != 0) LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

    if (GetPlayerVirtualWorld(playerid) != 0) SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

    if (IsABoat(vehicleid) || IsAPlane(vehicleid) || IsAHelicopter(vehicleid)) PutPlayerInVehicle(playerid, vehicleid, 0);

    SetVehicleNumberPlate(vehicleid, "STATIC");
    Servers(playerid, "You have spawned a %s (%d, %d).", GetVehicleModelName(model[0]), color1, color2);
    return 1;
}

CMD:setfaction(playerid, params[])
{
    new fid, rank, otherid, tmp[64];
    if (pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if (sscanf(params, "udd", otherid, fid, rank))
        return Usage(playerid, "/setfaction [playerid/PartOfName] [1.SAPD, 2.SAGS, 3.SAMD, 4.SANEWS, 5.PEDAGANG] [Rank 1-6]");

    if (!IsPlayerConnected(otherid))
        return Error(playerid, "Player Not Connected!");

    if (pData[otherid][pFamily] != -1)
        return Error(playerid, "The player has joined the family");

    if (fid < 0 || fid > 5)
        return Error(playerid, "You have specified an invalid faction ID 0 - 5");

    if (rank < 1 || rank > 6)
        return Error(playerid, "You have specified an invalid rank 1 - 6");

    if (fid == 0)
    {
        pData[otherid][pFaction] = 0;
        pData[otherid][pFactionRank] = 0;
        Servers(playerid, "You have removed %s's from faction", pData[otherid][pName]);
        Servers(otherid, "%s has removed your faction.", pData[playerid][pName]);
    }
    else
    {
        pData[otherid][pFaction] = fid;
        pData[otherid][pFactionRank] = rank;
        Servers(playerid, "You have set %s's faction ID: %d with Rank: %d|", pData[otherid][pName], fid, rank);
        Servers(otherid, "%s has set your faction ID to %d with Rank %d|", pData[playerid][pName], fid, rank);
    }

    format(tmp, sizeof(tmp), "%d(%d rank)", fid, rank);
    StaffCommandLog("SetFaction", playerid, otherid, tmp);
    return 1;
}

CMD:setleader(playerid, params[])
{
    new fid, otherid, tmp[64];
    if (pData[playerid][pAdmin] < 4)
        return PermissionError(playerid);

    if (sscanf(params, "ud", otherid, fid))
        return Usage(playerid, "/setleader [playerid/PartOfName] [0.None, 1.SAPD, 2.SAGS, 3.SAMD, 4.SANEWS, 5.PEDAGANG]");

    if (!IsPlayerConnected(otherid))
        return Error(playerid, "Player not connected!");

    if (fid < 0 || fid > 5)
        return Error(playerid, "You have specified an invalid faction ID 0 - 5");

    if (fid == 0)
    {
        pData[otherid][pFaction] = 0;
        pData[otherid][pFactionLead] = 0;
        pData[otherid][pFactionRank] = 0;
        Servers(playerid, "You have removed %s's from faction leader.", pData[otherid][pName]);
        Servers(otherid, "%s has removed your faction leader", pData[playerid][pName]);
    }
    else
    {
        pData[otherid][pFaction] = fid;
        pData[otherid][pFactionLead] = fid;
        pData[otherid][pFactionRank] = 6;
        Servers(playerid, "You have set %s's faction ID: %d with leader", pData[otherid][pName], fid);
        Servers(otherid, "%s Has set your faction ID to : %d with leader", pData[playerid][pName], fid);
    }

    format(tmp, sizeof(tmp), "%d", fid);
    StaffCommandLog("SetLeader", playerid, otherid, tmp);
    return 1;
}

CMD:ann(playerid, params[])
{
    if (pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    if (isnull(params))
    {
        Usage(playerid, "/announce [Message]");
        return 1;
    }

    if (strfind(params, "~x~", true) != -1)
        return Error(playerid, "~x~ is not allowed in announcement!");

    if (strfind(params, "#k~", true) != -1)
        return Error(playerid, "The constant key is not allowed in announcement");
    if (strfind(params, "/q", true) != -1)
        return Error(playerid, "You are not allowed to type /q in announcement!");

    new iTemp = 0;
    for (new i = (strlen(params) - 1); i != -1; i--)
    {
        if (params[i] == '~')
            iTemp++;
    }
    if (iTemp % 2 == 1)
        return Error(playerid, "You either have an extra ~ or one is missing in the announcement!");

    new str[512];
    new string[512];
    format(str, sizeof(str), "~w~%s", params);
    format(string, sizeof(str), "%s", params);
    GameTextForAll(str, 6500, 3);
    SendClientMessageToAllEx(COLOR_RED, "[ANNOUNCEMENT]: "WHITE_E"%s", string);
    return 1;
}

CMD:revive(playerid, params[])
{
    if (pData[playerid][pAdmin] < 1)
        if (pData[playerid][pHelper] < 2)
            return PermissionError(playerid);

    new otherid;
    if (sscanf(params, "u", otherid))
        return Usage(playerid, "/revive [playerid/PartOfName]");

    if (!IsPlayerConnected(playerid))
        return Error(playerid, "Player not connected!");

    if (!pData[otherid][pInjured])
        return Error(playerid, "You can't revive a player that's not injured");

    SetPlayerHealthEx(otherid, 100.0);
    pData[otherid][pInjured] = 0;
    pData[otherid][pHospital] = 0;
    pData[otherid][pSick] = 0;
    ClearAnimations(otherid);

    SendStaffMessage(COLOR_RED, "Staff %s have revived player %s.", pData[playerid][pAdminname], pData[otherid][pName]);
    Info(otherid, "Staff %s has revived your character.", pData[playerid][pAdminname]);
    return 1;
}

CMD:sethealth(playerid, params[])
{
    if (pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

    new otherid;
    if (sscanf(params, "ud", otherid))
        return Usage(playerid, "/sethealth [playerid/PartOfName]");

    if (!IsPlayerConnected(playerid))
        return Error(playerid, "Player not connected!");

    SetPlayerHealthEx(otherid, 100);
    // SetPlayerArmourEx(playerid, 100);
    SendStaffMessage(COLOR_RED, "%s telah men set health player %s", pData[playerid][pAdminname], pData[otherid][pName]);
    Servers(otherid, "Admin %s telah men set health anda", pData[playerid][pAdminname]);
    return 1;
}

CMD:setgold(playerid, params[])
{
    if (pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    new gold, otherid, tmp[64];
    if (sscanf(params, "ud", otherid, gold))
    {
        Usage(playerid, "/setgold [ID/Name] [gold]");
        return 1;
    }

    if (!IsPlayerConnected(otherid))
        return Error(playerid, "Player not connected!");

    pData[otherid][pGold] = gold;

    Servers(playerid, "You have set gold %s(%d) with the amount %d!", pData[otherid][pName], otherid, gold);
    Servers(otherid, "Admin %s has set gold to your with amount %d!", pData[playerid][pAdminname], gold);

    format(tmp, sizeof(tmp), "%d", gold);
    StaffCommandLog("SETGOLD", playerid, otherid, tmp);
    return 1;
}

CMD:cord(playerid, params[])
{
    new int, Float:px, Float:py, Float:pz, Float:a;
    GetPlayerPos(playerid, px, py, pz);
    GetPlayerFacingAngle(playerid, a);
    int = GetPlayerInterior(playerid);
    new zone [MAX_ZONE_NAME];
    GetPlayer3DZone(playerid, zone, sizeof(zone));
    SendClientMessageEx(playerid, COLOR_WHITE, "Lokasi Anda Saat ini: %s (%0.2f, %0.2f, %0.2f, %0.2f) int = %d", zone, px, py, pz, a, int);
    return 1;
}
CMD:ahelp(playerid, params[])
{
    if (!pData[playerid][pAdmin] == 6)
        return PermissionError(playerid);
    new str[257];
    format(str, sizeof(str), "ahelp\tshow all command\n");
    format(str, sizeof(str), "%s{25CED1}aduty\t{FFFFFF}on duty admin\n", str);
    format(str, sizeof(str), "%s{25CED1}setadminname\t{FFFFFF}change admin name\n", str);
    format(str, sizeof(str), "%s{25CED1}restart\t{FFFFFF}Restart Server\n", str);
    format(str, sizeof(str), "%s{25CED1}cokbadai\t{FFFFF}Maintenance server\n", str);
    format(str, sizeof(str), "%s{25CED1}adminjail\t{FFFFFF}Show Player Jail(OOC)\n", str);
    format(str, sizeof(str), "%s{25CED1}jail\t{FFFFF}Jail Player(OOC)\n", str);
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "ADMIN COMMAND", str, "Ok", "Exit");

    return 1;
}