// Factotion Command







CMD:factionhelp(playerid)
{
    if (pData[playerid][pFaction] == 2)
    {
        new string[3500];
        strcat(string, ""LB_E"SAGS: /locker /or (/r)adio /od /d (departement) /gov(goverment) /m(megaphone) /invite /uninvite /setrank\n");
        strcat(string, ""WHITE_E"SAGS: /sagsonline /takecard\n");
        strcat(string, ""WHITE_E"NOTE: lama Waktu duty akan menjadi gaji anda pada saat paycheck!\n");
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"SAGS", string, "Close", "");
    }
    else
    {
        Error(playerid, "Anda tidak bergabung dalam Faction / Family manapun!");
    }
    return 1;
}

CMD:locker(playerid, params[])
{
    if (pData[playerid][pFaction] < 1)
        if (pData[playerid][pFamily] < 1)
            return Error(playerid, "Civilian can't use this command!");

    foreach (new lid : Lockers)
    {
        if (IsPlayerInRangeOfPoint(playerid, 2.5, lData[lid][lPosZ], lData[lid][lPosY], lData[lid][lPosZ]))
        {
            if (pData[playerid][pVip] > 0 && lData[lid][lType] == 6)
            {
                ShowPlayerDialog(playerid, DIALOG_LOCKERVIP, DIALOG_STYLE_LIST, "VIP Locker", "Health\nWeapon\nClothing\nVIP Toys", "Select", "Cancell");
            }
            else if (pData[playerid][pFaction] == 1)
            {
                ShowPlayerDialog(playerid, DIALOG_LOCKERSAPD, DIALOG_STYLE_LIST, "SAPD Locker", "Toggle Duty\nVest\nWeapon\nClothing", "Select", "Cancell");
            }
            else if (pData[playerid][pFaction] == 2)
            {
                ShowPlayerDialog(playerid, DIALOG_LOCKERSAGS, DIALOG_STYLE_LIST, "SAGS Locker", "Toggle Duty\nPerlengkapan\nClothing", "Select", "Cancell");
            }
            // next
            else return Error(playerid, "You are not in this faction type");
        }
    }
    return 1;
}