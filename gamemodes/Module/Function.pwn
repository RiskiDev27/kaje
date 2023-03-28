function SafeLogin(playerid)
{
    // Main Menu Features.
    SetPlayerVirtualWorld(playerid, 0);

    /*if(!IsValidRoleplayName(pData[playerid][pName]))
    {
        Error(playerid, "Nama kamu tidak sesuai format untuk server mode Roleplay Name.");
        Error(playerid, "Penggunaan nama harus mengikuti format Roleplay Name.");
        Error(playerid, "Sebagai contoh, Zenn_Luxury, Iqbal_Santosa, dll.");
        KickEx(playerid);
    }*/
    return 1;
}

function OnPlayerDataLoaded(playerid, race_check)
{
    if (race_check != g_MysqlRaceCheck[playerid]) return Kick(playerid);

    new string[1000], query[248], PlayerIP[16];
    if (cache_num_rows() > 0)
    {
        cache_get_value_name_int(0, "reg_id", pData[playerid][pID]);
        cache_get_value_name(0, "password", pData[playerid][pPassword], 65);
        cache_get_value_name(0, "salt", pData[playerid][pSalt], 17);
        cache_get_value_name(0, "ucp", pData[playerid][pUCP], 22);
        cache_get_value_name(0, "temppass", pData[playerid][pTempPass], 64);
        TempPass[playerid] = pData[playerid][pTempPass];
        //---
        InterpolateCameraPos(playerid, 1330.757080, -1732.019042, 23.432754, 1484.328125, -1716.528442, 23.261428, 20000);
        InterpolateCameraLookAt(playerid, 1335.739990, -1732.224365, 23.073688, 1483.968627, -1721.461547, 23.993165, 19000);
        //---
        cache_get_value_name(0, "ucp", pData[playerid][pUCP]);
        if (pData[playerid][pUCP] > 0)
        {
            format(string, sizeof string, "{FFFFFF}This account is {00FF00}registered!\n\n{FFFFFF}Account: {FFFF00}%s\n{FFFFFF}UCP: {FFFF00}%s\n{FFFFFF}Enter your password below :", GetName(playerid), pData[playerid][pUCP]);
            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login to Infinity", string, "Login", "Abort");
        }
        else
        {
            ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "ERROR", "The character has not at UCP in the database.", "", "Quit");
        }
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "ERROR", "The character has not at UCP in the database.", "", "Quit");
    }
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `banneds` WHERE `name` = '%s' OR `ip` = '%s' OR (`longip` != 0 AND (`longip` & %i) = %i) LIMIT 1", pData[playerid][pName], pData[playerid][pIP], BAN_MASK, (Ban_GetLongIP(PlayerIP) & BAN_MASK));
    mysql_tquery(g_SQL, query, "CheckBan", "i", playerid);
    return 1;
}

function CheckBan(playerid)
{
    if (cache_num_rows() > 0)
    {
        new Reason[40], PlayerName[24], BannedName[24];
        new banTime_Int, banDate, banIP[16];
        cache_get_value_name(0, "name", BannedName);
        cache_get_value_name(0, "admin", PlayerName);
        cache_get_value_name(0, "reason", Reason);
        cache_get_value_name(0, "ip", banIP);
        cache_get_value_name_int(0, "ban_expire", banTime_Int);
        cache_get_value_name_int(0, "ban_date", banDate);

        new currentTime = gettime();
        if (banTime_Int != 0 && banTime_Int <= currentTime) // Unban the player.
        {
            new query[248];
            mysql_format(g_SQL, query, sizeof(query), "DELETE FROM banneds WHERE name = '%s'", pData[playerid][pName]);
            mysql_tquery(g_SQL, query);

            Servers(playerid, "Welcome back to server, its been %s since your ban was lifted.", ReturnTimelapse(banTime_Int, gettime()));
        }
        else
        {
            foreach (new pid : Player)
            {
                if (pData[pid][pTogLog] == 0)
                {
                    SendClientMessageEx(pid, COLOR_BAN, "BotCmd: "GREY2_E"%s(%i) has been auto-kicked for ban evading.", pData[playerid][pName], playerid);
                }
            }
            new query[248], PlayerIP[16];
            mysql_format(g_SQL, query, sizeof query, "UPDATE `banneds` SET `last_activity_timestamp` = %i WHERE `name` = '%s'", gettime(), pData[playerid][pName]);
            mysql_tquery(g_SQL, query);

            pData[playerid][IsLoggedIn] = false;
            printf("[BANNED INFO]: Ban Getting Called on %s", pData[playerid][pName]);
            GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));

            InfoTD_MSG(playerid, 5000, "~r~~h~You are banned from this server!");
            //for(new l; l < 20; l++) SendClientMessage(playerid, COLOR_DARK, "\n");
            SendClientMessage(playerid, COLOR_RED, "You are banned from this server!");
            if (banTime_Int == 0)
            {
                new lstr[512];
                format(lstr, sizeof(lstr), "{FF0000}You are banned from this server!\n\n"LB2_E"Ban Info:\n{FF0000}Name: {778899}%s\n{FF0000}IP: {778899}%s\n{FF0000}Admin: {778899}%s\n{FF0000}Ban Date: {778899}%s\n{FF0000}Ban Reason: {778899}%s\n{FF0000}Ban Time: {778899}Permanent\n\n{FFFFFF}Feel that you were wrongfully banned? Appeal at https://dsc.gg/infinity", BannedName, PlayerIP, PlayerName, ReturnDate(banDate), Reason);
                ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"BANNED", lstr, "Exit", "");
            }
            else
            {
                new lstr[512];
                format(lstr, sizeof(lstr), "{FF0000}You are banned from this server!\n\n"LB2_E"Ban Info:\n{FF0000}Name: {778899}%s\n{FF0000}IP: {778899}%s\n{FF0000}Admin: {778899}%s\n{FF0000}Ban Date: {778899}%s\n{FF0000}Ban Reason: {778899}%s\n{FF0000}Ban Time: {778899}%s\n\n{FFFFFF}Feel that you were wrongfully banned? Appeal at https://dsc.gg/infinity", BannedName, PlayerIP, PlayerName, ReturnDate(banDate), Reason, ReturnTimelapse(gettime(), banTime_Int));
                ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""RED_E"BANNED", lstr, "Exit", "");
            }
            KickEx(playerid);
            return 1;
        }
    }
    return 1;
}

function InfoTD_MSG(playerid, ms_time, text[])
{
    if (GetPVarInt(playerid, "InfoTDshown") != -1)
    {
        PlayerTextDrawHide(playerid, InfoTD[playerid]);
        KillTimer(GetPVarInt(playerid, "InfoTDshown"));
    }

    PlayerTextDrawSetString(playerid, InfoTD[playerid], text);
    PlayerTextDrawShow(playerid, InfoTD[playerid]);
    SetPVarInt(playerid, "InfoTDshown", SetTimerEx("InfoTD_Hide", ms_time, false, "i", playerid));
}

function _KickPlayerDelayed(playerid)
{
    Kick(playerid);
    return 1;
}

function AssignPlayerData(playerid)
{
    new aname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], email[40], age[128], regdate[200], ip[128], lastlogin[50];
    new name[MAX_PLAYER_NAME], ucp[22];
    /*if(pData[playerid][pID] < 1)
    {
    	Error(playerid, "Database player not found!");
    	KickEx(playerid);
    	return 1;
    }*/
    cache_get_value_name_int(0, "reg_id", pData[playerid][pID]);
    cache_get_value_name(0, "ucp", ucp);
    format(pData[playerid][pUCP], 22, "%s", ucp);
    cache_get_value_name(0, "username", name);
    format(pData[playerid][pName], MAX_PLAYER_NAME, "%s", name);
    cache_get_value_name(0, "adminname", aname);
    format(pData[playerid][pAdminname], MAX_PLAYER_NAME, "%s", aname);
    cache_get_value_name(0, "tnames", tname);
    format(pData[playerid][pTname], MAX_PLAYER_NAME, "%s", tname);
    cache_get_value_name(0, "ip", ip);
    format(pData[playerid][pIP], 128, "%s", ip);
    cache_get_value_name(0, "email", email);
    format(pData[playerid][pEmail], 40, "%s", email);
    cache_get_value_name_int(0, "admin", pData[playerid][pAdmin]);
    cache_get_value_name_int(0, "helper", pData[playerid][pHelper]);
    cache_get_value_name_int(0, "level", pData[playerid][pLevel]);
    cache_get_value_name_int(0, "levelup", pData[playerid][pLevelUp]);
    cache_get_value_name_int(0, "vip", pData[playerid][pVip]);
    cache_get_value_name_int(0, "vip_time", pData[playerid][pVipTime]);
    cache_get_value_name_int(0, "boost", pData[playerid][pBooster]);
    cache_get_value_name_int(0, "characterstory", pData[playerid][pCS]);
    cache_get_value_name_int(0, "boost_time", pData[playerid][pBoostTime]);
    cache_get_value_name_int(0, "gold", pData[playerid][pGold]);
    cache_get_value_name(0, "reg_date", regdate);
    format(pData[playerid][pRegDate], 128, "%s", regdate);
    cache_get_value_name(0, "last_login", lastlogin);
    format(pData[playerid][pLastLogin], 128, "%s", lastlogin);
    cache_get_value_name_int(0, "money", pData[playerid][pMoney]);
    cache_get_value_name_int(0, "bmoney", pData[playerid][pBankMoney]);
    cache_get_value_name_int(0, "brek", pData[playerid][pBankRek]);
    cache_get_value_name_int(0, "phone", pData[playerid][pPhone]);
    cache_get_value_name_int(0, "phoneoff", pData[playerid][pPhoneOff]);
    cache_get_value_name_int(0, "phonecredit", pData[playerid][pPhoneCredit]);
    cache_get_value_name_int(0, "phonebook", pData[playerid][pPhoneBook]);
    cache_get_value_name_int(0, "wt", pData[playerid][pWT]);
    cache_get_value_name_int(0, "hours", pData[playerid][pHours]);
    cache_get_value_name_int(0, "minutes", pData[playerid][pMinutes]);
    cache_get_value_name_int(0, "seconds", pData[playerid][pSeconds]);
    cache_get_value_name_int(0, "paycheck", pData[playerid][pPaycheck]);
    cache_get_value_name_int(0, "skin", pData[playerid][pSkin]);
    cache_get_value_name_int(0, "facskin", pData[playerid][pFacSkin]);
    cache_get_value_name_int(0, "gender", pData[playerid][pGender]);
    cache_get_value_name(0, "age", age);
    format(pData[playerid][pAge], 128, "%s", age);
    cache_get_value_name_int(0, "indoor", pData[playerid][pInDoor]);
    cache_get_value_name_int(0, "inhouse", pData[playerid][pInHouse]);
    cache_get_value_name_int(0, "inbiz", pData[playerid][pInBiz]);
    cache_get_value_name_float(0, "posx", pData[playerid][pPosX]);
    cache_get_value_name_float(0, "posy", pData[playerid][pPosY]);
    cache_get_value_name_float(0, "posz", pData[playerid][pPosZ]);
    cache_get_value_name_float(0, "posa", pData[playerid][pPosA]);
    cache_get_value_name_int(0, "interior", pData[playerid][pInt]);
    cache_get_value_name_int(0, "world", pData[playerid][pWorld]);
    cache_get_value_name_float(0, "health", pData[playerid][pHealth]);
    cache_get_value_name_float(0, "armour", pData[playerid][pArmour]);
    cache_get_value_name_int(0, "hunger", pData[playerid][pHunger]);
    cache_get_value_name_int(0, "bladder", pData[playerid][pBladder]);
    cache_get_value_name_int(0, "energy", pData[playerid][pEnergy]);
    cache_get_value_name_int(0, "sick", pData[playerid][pSick]);
    cache_get_value_name_int(0, "hospital", pData[playerid][pHospital]);
    cache_get_value_name_int(0, "injured", pData[playerid][pInjured]);
    cache_get_value_name_int(0, "duty", pData[playerid][pOnDuty]);
    cache_get_value_name_int(0, "dutytime", pData[playerid][pOnDutyTime]);
    cache_get_value_name_int(0, "faction", pData[playerid][pFaction]);
    cache_get_value_name_int(0, "factionrank", pData[playerid][pFactionRank]);
    cache_get_value_name_int(0, "factionlead", pData[playerid][pFactionLead]);
    cache_get_value_name_int(0, "farm", pData[playerid][pFarm]);
    cache_get_value_name_int(0, "farmrank", pData[playerid][pFarmRank]);
    cache_get_value_name_int(0, "family", pData[playerid][pFamily]);
    cache_get_value_name_int(0, "familyrank", pData[playerid][pFamilyRank]);
    cache_get_value_name_int(0, "jail", pData[playerid][pJail]);
    cache_get_value_name_int(0, "jail_time", pData[playerid][pJailTime]);
    cache_get_value_name_int(0, "arrest", pData[playerid][pArrest]);
    cache_get_value_name_int(0, "arrest_time", pData[playerid][pArrestTime]);
    cache_get_value_name_int(0, "warn", pData[playerid][pWarn]);
    cache_get_value_name_int(0, "job", pData[playerid][pJob]);
    cache_get_value_name_int(0, "job2", pData[playerid][pJob2]);
    cache_get_value_name_int(0, "jobtime", pData[playerid][pJobTime]);
    cache_get_value_name_int(0, "exitjob", pData[playerid][pExitJob]);
    cache_get_value_name_int(0, "taxitime", pData[playerid][pTaxiTime]);
    cache_get_value_name_int(0, "medicine", pData[playerid][pMedicine]);
    cache_get_value_name_int(0, "medkit", pData[playerid][pMedkit]);
    cache_get_value_name_int(0, "mask", pData[playerid][pMask]);
    cache_get_value_name_int(0, "fstyle", pData[playerid][pFightStyle]);
    cache_get_value_name_int(0, "gvip", pData[playerid][pGymVip]);
    cache_get_value_name_int(0, "helmet", pData[playerid][pHelmet]);
    cache_get_value_name_int(0, "flight", pData[playerid][pFlashlight]);
    cache_get_value_name_int(0, "snack", pData[playerid][pSnack]);
    cache_get_value_name_int(0, "sprunk", pData[playerid][pSprunk]);
    cache_get_value_name_int(0, "ayam", pData[playerid][pAyam]);
    cache_get_value_name_int(0, "burger", pData[playerid][pBurger]);
    cache_get_value_name_int(0, "nasbung", pData[playerid][pNasi]);
    cache_get_value_name_int(0, "airmineral", pData[playerid][pMineral]);
    cache_get_value_name_int(0, "gas", pData[playerid][pGas]);
    cache_get_value_name_int(0, "bandage", pData[playerid][pBandage]);
    cache_get_value_name_int(0, "gps", pData[playerid][pGPS]);
    cache_get_value_name_int(0, "material", pData[playerid][pMaterial]);
    cache_get_value_name_int(0, "component", pData[playerid][pComponent]);
    cache_get_value_name_int(0, "food", pData[playerid][pFood]);
    cache_get_value_name_int(0, "frozenpizza", pData[playerid][pFrozenPizza]);
    cache_get_value_name_int(0, "seed", pData[playerid][pSeed]);
    cache_get_value_name_int(0, "potato", pData[playerid][pPotato]);
    cache_get_value_name_int(0, "wheat", pData[playerid][pWheat]);
    cache_get_value_name_int(0, "orange", pData[playerid][pOrange]);
    cache_get_value_name_int(0, "price1", pData[playerid][pPrice1]);
    cache_get_value_name_int(0, "price2", pData[playerid][pPrice2]);
    cache_get_value_name_int(0, "price3", pData[playerid][pPrice3]);
    cache_get_value_name_int(0, "price4", pData[playerid][pPrice4]);
    cache_get_value_name_int(0, "marijuana", pData[playerid][pMarijuana]);
    cache_get_value_name_int(0, "blindfold", pData[playerid][pBlindfold]);
    cache_get_value_name_int(0, "armor", pData[playerid][pArmor]);
    cache_get_value_name_int(0, "borax", pData[playerid][pBorax]);
    cache_get_value_name_int(0, "paketborax", pData[playerid][pPaketBorax]);
    cache_get_value_name_int(0, "redmoney", pData[playerid][pRedMoney]);
    cache_get_value_name_int(0, "plant", pData[playerid][pPlant]);
    cache_get_value_name_int(0, "plant_time", pData[playerid][pPlantTime]);
    cache_get_value_name_int(0, "fishtool", pData[playerid][pFishTool]);
    cache_get_value_name_int(0, "fish", pData[playerid][pFish]);
    cache_get_value_name_int(0, "worm", pData[playerid][pWorm]);
    cache_get_value_name_int(0, "idcard", pData[playerid][pIDCard]);
    cache_get_value_name_int(0, "idcard_time", pData[playerid][pIDCardTime]);
    cache_get_value_name_int(0, "skck", pData[playerid][pSkck]);
    cache_get_value_name_int(0, "skck_time", pData[playerid][pSkckTime]);
    cache_get_value_name_int(0, "penebang", pData[playerid][pPenebangs]);
    cache_get_value_name_int(0, "penebang_time", pData[playerid][pPenebangsTime]);
    cache_get_value_name_int(0, "bpjs", pData[playerid][pBpjs]);
    cache_get_value_name_int(0, "bpjs_time", pData[playerid][pBpjsTime]);
    cache_get_value_name_int(0, "licbiz", pData[playerid][pLicBiz]);
    cache_get_value_name_int(0, "licbiz_time", pData[playerid][pLicBizTime]);
    cache_get_value_name_int(0, "drivelic", pData[playerid][pDriveLic]);
    cache_get_value_name_int(0, "drivelic_time", pData[playerid][pDriveLicTime]);
    cache_get_value_name_int(0, "boombox", pData[playerid][pBoombox]);
    cache_get_value_name_int(0, "starter", pData[playerid][pSpack]);
    cache_get_value_name_int(0, "hbemode", pData[playerid][pHBEMode]);
    cache_get_value_name_int(0, "tdmode", pData[playerid][pTDMode]);
    cache_get_value_name_int(0, "akuntw", pData[playerid][pTweet]);
    cache_get_value_name_int(0, "togpm", pData[playerid][pTogPM]);
    cache_get_value_name_int(0, "toglog", pData[playerid][pTogLog]);
    cache_get_value_name_int(0, "togads", pData[playerid][pTogAds]);
    cache_get_value_name_int(0, "togwt", pData[playerid][pTogWT]);
    cache_get_value_name_int(0, "togtweet", pData[playerid][pTogTweet]);
    cache_get_value_name_int(0, "Gun1", pData[playerid][pGuns][0]);
    cache_get_value_name_int(0, "Gun2", pData[playerid][pGuns][1]);
    cache_get_value_name_int(0, "Gun3", pData[playerid][pGuns][2]);
    cache_get_value_name_int(0, "Gun4", pData[playerid][pGuns][3]);
    cache_get_value_name_int(0, "Gun5", pData[playerid][pGuns][4]);
    cache_get_value_name_int(0, "Gun6", pData[playerid][pGuns][5]);
    cache_get_value_name_int(0, "Gun7", pData[playerid][pGuns][6]);
    cache_get_value_name_int(0, "Gun8", pData[playerid][pGuns][7]);
    cache_get_value_name_int(0, "Gun9", pData[playerid][pGuns][8]);
    cache_get_value_name_int(0, "Gun10", pData[playerid][pGuns][9]);
    cache_get_value_name_int(0, "Gun11", pData[playerid][pGuns][10]);
    cache_get_value_name_int(0, "Gun12", pData[playerid][pGuns][11]);
    cache_get_value_name_int(0, "Gun13", pData[playerid][pGuns][12]);

    cache_get_value_name_int(0, "Ammo1", pData[playerid][pAmmo][0]);
    cache_get_value_name_int(0, "Ammo2", pData[playerid][pAmmo][1]);
    cache_get_value_name_int(0, "Ammo3", pData[playerid][pAmmo][2]);
    cache_get_value_name_int(0, "Ammo4", pData[playerid][pAmmo][3]);
    cache_get_value_name_int(0, "Ammo5", pData[playerid][pAmmo][4]);
    cache_get_value_name_int(0, "Ammo6", pData[playerid][pAmmo][5]);
    cache_get_value_name_int(0, "Ammo7", pData[playerid][pAmmo][6]);
    cache_get_value_name_int(0, "Ammo8", pData[playerid][pAmmo][7]);
    cache_get_value_name_int(0, "Ammo9", pData[playerid][pAmmo][8]);
    cache_get_value_name_int(0, "Ammo10", pData[playerid][pAmmo][9]);
    cache_get_value_name_int(0, "Ammo11", pData[playerid][pAmmo][10]);
    cache_get_value_name_int(0, "Ammo12", pData[playerid][pAmmo][11]);
    cache_get_value_name_int(0, "Ammo13", pData[playerid][pAmmo][12]);

    cache_get_value_name_int(0, "pegawai", pData[playerid][pWsEmplooye]);
    cache_get_value_name_int(0, "trash", pData[playerid][pTrash]);
    cache_get_value_name_int(0, "berry", pData[playerid][pBerry]);
    /*cache_get_value_name_int(0, "truckskill", pData[playerid][pTruckSkill]);
    cache_get_value_name_int(0, "mechskill", pData[playerid][pMechSkill]);
    cache_get_value_name_int(0, "smuggskill", pData[playerid][pSmuggSkill]);*/

    /*for (new i; i < 17; i++)
    {
    	WeaponSettings[playerid][i][Position][0] = -0.116;
    	WeaponSettings[playerid][i][Position][1] = 0.189;
    	WeaponSettings[playerid][i][Position][2] = 0.088;
    	WeaponSettings[playerid][i][Position][3] = 0.0;
    	WeaponSettings[playerid][i][Position][4] = 44.5;
    	WeaponSettings[playerid][i][Position][5] = 0.0;
    	WeaponSettings[playerid][i][Bone] = 1;
    	WeaponSettings[playerid][i][Hidden] = false;
    }
    WeaponTick[playerid] = 0;
    EditingWeapon[playerid] = 0;
    new string[128];
    mysql_format(g_SQL, string, sizeof(string), "SELECT * FROM weaponsettings WHERE Owner = '%d'", pData[playerid][pID]);
    mysql_tquery(g_SQL, string, "OnWeaponsLoaded", "d", playerid);

    new strong[128];
    mysql_format(g_SQL, strong, sizeof(strong), "SELECT * FROM `contacts` WHERE `ID` = '%d'", pData[playerid][pID]);
    mysql_tquery(g_SQL, strong, "LoadContact", "d", playerid);*/

    KillTimer(pData[playerid][LoginTimer]);
    pData[playerid][LoginTimer] = 0;
    pData[playerid][IsLoggedIn] = true;

    SetSpawnInfo(playerid, NO_TEAM, pData[playerid][pSkin], pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid);

    // MySQL_LoadPlayerToys(playerid);
    // LoadPlayerVehicle(playerid);
    return 1;
}

function OnPlayerRegister(playerid)
{
    if (pData[playerid][IsLoggedIn] == true)
        return Error(playerid, "You already logged in!");

    pData[playerid][pID] = cache_insert_id();
    pData[playerid][IsLoggedIn] = true;

    pData[playerid][pPosX] = DEFAULT_POS_X;
    pData[playerid][pPosY] = DEFAULT_POS_Y;
    pData[playerid][pPosZ] = DEFAULT_POS_Z;
    pData[playerid][pPosA] = DEFAULT_POS_A;
    pData[playerid][pInt] = 0;
    pData[playerid][pWorld] = 0;
    pData[playerid][pGender] = 0;

    //format(pData[playerid][pUCP], 22, GetName(playerid));
    format(pData[playerid][pAdminname], MAX_PLAYER_NAME, "None");
    format(pData[playerid][pEmail], 40, "None");
    pData[playerid][pHealth] = 100.0;
    pData[playerid][pArmour] = 0.0;
    pData[playerid][pLevel] = 1;
    pData[playerid][pHunger] = 100;
    pData[playerid][pBladder] = 100;
    pData[playerid][pEnergy] = 100;
    pData[playerid][pMoney] = 10000;
    pData[playerid][pBankMoney] = 5000;

    new query[128], rand = RandomEx(111111, 999999);
    new rek = rand + pData[playerid][pID];
    mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
    mysql_tquery(g_SQL, query, "BankRek", "id", playerid, rek);

    SetSpawnInfo(playerid, NO_TEAM, 0, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid);
    return 1;
}

function BankRek(playerid, brek)
{
    if (cache_num_rows() > 0)
    {
        //Rekening Exist
        new query[128], rand = RandomEx(11111, 99999);
        new rek = rand + pData[playerid][pID];
        mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
        mysql_tquery(g_SQL, query, "BankRek", "is", playerid, rek);
        Info(playerid, "Your Bank rekening number is same with someone. We will research new.");
    }
    else
    {
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET brek='%d' WHERE reg_id=%d", brek, pData[playerid][pID]);
        mysql_tquery(g_SQL, query);
        pData[playerid][pBankRek] = brek;
    }
    return true;
}

function a_ChangeAdminName(otherplayer, playerid, nname[])
{
    if (cache_num_rows() > 0)
    {
        Error(playerid, "The name "DARK_E"%s'"GREY_E"already exists in the database , please use different name!", nname);
    }
    else
    {
        new query[512];
        format(query, sizeof(query), "UPDATE `players` SET `adminname` = '%e' WHERE `reg_id` = '%d'", nname, pData[otherplayer][pID]);
        mysql_tquery(g_SQL, query);
        format(pData[otherplayer][pAdminname], MAX_PLAYER_NAME, "%s", nname);
        Servers(playerid, "You have set admin name player %s to %s", pData[otherplayer][pName], nname);
        SendClientMessage(playerid, 0x6D9DC5, "[DEV]: Called Function ChangeAdminName");
    }
    return 1;
}

function PlayerCheck()
{
    static str[128],
           Float:health,
           id = -1;

    RestartCheck();
    BadaiCheck();
    return 1;
}

function SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z, Float:a)
{
    if (!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
        return 0;

    pData[playerid][pFreeze] = 0;
    SetPlayerPos(playerid, x, y, z);
    SetPlayerFacingAngle(playerid, a);
    TogglePlayerControllable(playerid, 1);
    return 1;
}

function JailPlayer(playerid)
{
    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
    SetPlayerPositionEx(playerid, -310.64, 1894.41, 34.05, 178.17, 2000);
    SetPlayerInterior(playerid, 10);
    SetPlayerVirtualWorld(playerid, 100);
    SetPlayerWantedLevel(playerid, 0);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    pData[playerid][pInBiz] = -1;
    pData[playerid][pInHouse] = -1;
    pData[playerid][pInDoor] = -1;
    pData[playerid][pCuffed] = 0;
    PlayerPlaySound(playerid, 1186, 0, 0, 0);
    return 1;
}

function WeatherRotator()
{
    // gettime(&hour = 0, &hour = 0, &hour = 0)
    new weatherid;
    new hours, minutes, second;
    new time = gettime(second);
    new index = random(sizeof(g_aWeatherRotations));

    SetWeather(g_aWeatherRotations[index]);
    SendClientMessageToAllEx(COLOR_LRED, "[BMKG]: Cuaca : %s [%d]{FFFFFF}Time: (%02d)", GetWeatherName(index), index, gettime());
    // SendClientMessageEx(playerid, -1, "[SYSTEM]: WEATHER %d", g_aWeatherRotations[index]);
}

function SetVehicleToUnfreeze(playerid, vehicleid, Float:x, Float:y, Float:z, Float:a)
{
    if (!IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
        return 0;

    pData[playerid][pFreeze] = 0;
    SetVehiclePos(vehicleid, x, y, z);
    SetVehicleZAngle(vehicleid, a);
    TogglePlayerControllable(playerid, 1);
    return 1;
}