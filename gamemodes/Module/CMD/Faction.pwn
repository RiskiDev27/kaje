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