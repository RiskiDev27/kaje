IsValidRoleplayName(const name[])
{
    if (!name[0] || strfind(name, "_") == -1)
        return 0;

    else for (new i = 0, len = strlen(name); i != len; i ++)
        {
            if ((i == 0) && (name[i] < 'A' || name[i] > 'Z'))
                return 0;

            else if ((i != 0 && i < len  && name[i] == '_') && (name[i + 1] < 'A' || name[i + 1] > 'Z'))
                return 0;

            else if ((name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z') && name[i] != '_' && name[i] != '.')
                return 0;
        }
    return 1;
}

stock GetName(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

Ban_GetLongIP(const ip[])
{
    new len = strlen(ip);
    if (!(len > 0 && len < 17))
    {
        return 0;
    }

    new count;
    new pos;
    new dest[3];
    new val[4];
    for (new i; i < len; i++)
    {
        if (ip[i] == '.' || i == len)
        {
            strmid(dest, ip, pos, i);
            pos = (i + 1);

            val[count] = strval(dest);
            if (!(0 <= val[count] <= 255))
            {
                return 0;
            }

            count++;
            if (count > 3)
            {
                return 0;
            }
        }
    }

    if (count != 3)
    {
        return 0;
    }
    return ((val[0] * 16777216) + (val[1] * 65536) + (val[2] * 256) + (val[3]));
}

SendClientMessageEx(playerid, color, const text[], {Float, _} : ...)
{
    static args,
           str[144];

    if ((args = numargs()) == 3)
    {
        SendClientMessage(playerid, color, text);
    }
    else
    {
        while (--args >= 3)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit PUSH.S 8
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessage(playerid, color, str);

        #emit RETN
    }
    return 1;
}

ReturnTimelapse(start, till)
{
    new ret[32];
    new second = till - start;

    const MINUTE = 60,
                    HOUR = 60 * MINUTE,
                    DAY = 24 * HOUR,
                    MONTH = 30 * DAY;

    if (second == 1)
        format(ret, sizeof(ret), "a second");
    if (second < (1 * MINUTE))
        format(ret, sizeof(ret), "%i seconds", second);
    else if (second < (2 * MINUTE))
        format(ret, sizeof(ret), "a minute");
    else if (second < (45 * MINUTE))
        format(ret, sizeof(ret), "%i minutes", (second / MINUTE));
    else if (second < (90 * MINUTE))
        format(ret, sizeof(ret), "an hour");
    else if (second < (24 * HOUR))
        format(ret, sizeof(ret), "%i hours", (second / HOUR));
    else if (second < (48 * HOUR))
        format(ret, sizeof(ret), "a day");
    else if (second < (30 * DAY))
        format(ret, sizeof(ret), "%i days", (second / DAY));
    else if (second < (12 * MONTH))
    {
        new month = floatround(second / DAY / 30);
        if (month <= 1)
            format(ret, sizeof(ret), "a month");
        else
            format(ret, sizeof(ret), "%i months", month);
    }
    else
    {
        new year = floatround(second / DAY / 365);
        if (year <= 1)
            format(ret, sizeof(ret), "a year");
        else
            format(ret, sizeof(ret), "%i years", year);
    }
    return ret;
}

ReturnDate(timestamp)
{
    new year, month, day, hour, minute, second;
    TimestampToDate(timestamp, year, month, day, hour, minute, second, 7);

    static monthname[15];
    switch (month)
    {
        case 1: monthname = "January";
        case 2: monthname = "February";
        case 3: monthname = "March";
        case 4: monthname = "April";
        case 5: monthname = "May";
        case 6: monthname = "June";
        case 7: monthname = "July";
        case 8: monthname = "August";
        case 9: monthname = "September";
        case 10: monthname = "October";
        case 11: monthname = "November";
        case 12: monthname = "December";
    }

    new date[30];
    format(date, sizeof(date), "%d %s, %d - %d:%d:%d", day, monthname, year, hour, minute, second);
    return date;
}

KickEx(playerid, time = 500)
{
    SetTimerEx("_KickPlayerDelayed", time, false, "i", playerid);
    return 1;
}

UpdatePlayerData(playerid)
{
    if (pData[playerid][IsLoggedIn] == false) return 0;
    if (IsPlayerInAnyVehicle(playerid))
    {
        if (IsATruck(GetPlayerVehicleID(playerid)))
        {
            RemovePlayerFromVehicle(playerid);
            GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
            pData[playerid][pPosZ] = pData[playerid][pPosZ] + 0.4;
        }
        else
        {
            GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
        }
    }
    else
    {
        GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
    }
    GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
    GetPlayerHealth(playerid, pData[playerid][pHealth]);
    GetPlayerArmour(playerid, pData[playerid][pArmour]);
    //UpdateWeapons(playerid);

    new cQuery[5000], PlayerIP[16];
    GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));

    mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `players` SET ");
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun1` = '%d', ", cQuery, pData[playerid][pGuns][0]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun2` = '%d', ", cQuery, pData[playerid][pGuns][1]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun3` = '%d', ", cQuery, pData[playerid][pGuns][2]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun4` = '%d', ", cQuery, pData[playerid][pGuns][3]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun5` = '%d', ", cQuery, pData[playerid][pGuns][4]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun6` = '%d', ", cQuery, pData[playerid][pGuns][5]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun7` = '%d', ", cQuery, pData[playerid][pGuns][6]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun8` = '%d', ", cQuery, pData[playerid][pGuns][7]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun9` = '%d', ", cQuery, pData[playerid][pGuns][8]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun10` = '%d', ", cQuery, pData[playerid][pGuns][9]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun11` = '%d', ", cQuery, pData[playerid][pGuns][10]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun12` = '%d', ", cQuery, pData[playerid][pGuns][11]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Gun13` = '%d', ", cQuery, pData[playerid][pGuns][12]);

    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo1` = '%d', ", cQuery, pData[playerid][pAmmo][0]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo2` = '%d', ", cQuery, pData[playerid][pAmmo][1]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo3` = '%d', ", cQuery, pData[playerid][pAmmo][2]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo4` = '%d', ", cQuery, pData[playerid][pAmmo][3]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo5` = '%d', ", cQuery, pData[playerid][pAmmo][4]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo6` = '%d', ", cQuery, pData[playerid][pAmmo][5]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo7` = '%d', ", cQuery, pData[playerid][pAmmo][6]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo8` = '%d', ", cQuery, pData[playerid][pAmmo][7]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo9` = '%d', ", cQuery, pData[playerid][pAmmo][8]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo10` = '%d', ", cQuery, pData[playerid][pAmmo][9]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo11` = '%d', ", cQuery, pData[playerid][pAmmo][10]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo12` = '%d', ", cQuery, pData[playerid][pAmmo][11]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`Ammo13` = '%d', ", cQuery, pData[playerid][pAmmo][12]);

    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`characterstory` = '%d',", cQuery, pData[playerid][pCS]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`username` = '%e', ", cQuery, pData[playerid][pName]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`adminname` = '%e', ", cQuery, pData[playerid][pAdminname]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ip` = '%s', ", cQuery, PlayerIP);
    //mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`email` = '%s', ", cQuery, pData[playerid][pEmail]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`admin` = '%d', ", cQuery, pData[playerid][pAdmin]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`helper` = '%d', ", cQuery, pData[playerid][pHelper]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`level` = '%d', ", cQuery, pData[playerid][pLevel]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`levelup` = '%d', ", cQuery, pData[playerid][pLevelUp]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`vip` = '%d', ", cQuery, pData[playerid][pVip]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`vip_time` = '%d', ", cQuery, pData[playerid][pVipTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`boost` = '%d', ", cQuery, pData[playerid][pBooster]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`boost_time` = '%d', ", cQuery, pData[playerid][pBoostTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gold` = '%d', ", cQuery, pData[playerid][pGold]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`money` = '%d', ", cQuery, pData[playerid][pMoney]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`bmoney` = '%d', ", cQuery, pData[playerid][pBankMoney]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`brek` = '%d', ", cQuery, pData[playerid][pBankRek]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`phone` = '%d', ", cQuery, pData[playerid][pPhone]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`phoneoff` = '%d', ", cQuery, pData[playerid][pPhoneOff]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`phonecredit` = '%d', ", cQuery, pData[playerid][pPhoneCredit]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`phonebook` = '%d', ", cQuery, pData[playerid][pPhoneBook]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`wt` = '%d', ", cQuery, pData[playerid][pWT]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`hours` = '%d', ", cQuery, pData[playerid][pHours]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`minutes` = '%d', ", cQuery, pData[playerid][pMinutes]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`seconds` = '%d', ", cQuery, pData[playerid][pSeconds]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`paycheck` = '%d', ", cQuery, pData[playerid][pPaycheck]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`skin` = '%d', ", cQuery, pData[playerid][pSkin]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`facskin` = '%d', ", cQuery, pData[playerid][pFacSkin]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gender` = '%d', ", cQuery, pData[playerid][pGender]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`age` = '%s', ", cQuery, pData[playerid][pAge]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`indoor` = '%d', ", cQuery, pData[playerid][pInDoor]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`inhouse` = '%d', ", cQuery, pData[playerid][pInHouse]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`inbiz` = '%d', ", cQuery, pData[playerid][pInBiz]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`posx` = '%f', ", cQuery, pData[playerid][pPosX]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`posy` = '%f', ", cQuery, pData[playerid][pPosY]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`posz` = '%f', ", cQuery, pData[playerid][pPosZ] + 0.3);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`posa` = '%f', ", cQuery, pData[playerid][pPosA]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`interior` = '%d', ", cQuery, GetPlayerInterior(playerid));
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`world` = '%d', ", cQuery, GetPlayerVirtualWorld(playerid));

    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`health` = '%f', ", cQuery, pData[playerid][pHealth]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`armour` = '%f', ", cQuery, pData[playerid][pArmour]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`hunger` = '%d', ", cQuery, pData[playerid][pHunger]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`bladder` = '%d', ", cQuery, pData[playerid][pBladder]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`energy` = '%d', ", cQuery, pData[playerid][pEnergy]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`sick` = '%d', ", cQuery, pData[playerid][pSick]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`hospital` = '%d', ", cQuery, pData[playerid][pHospital]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`injured` = '%d', ", cQuery, pData[playerid][pInjured]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`duty` = '%d', ", cQuery, pData[playerid][pOnDuty]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`dutytime` = '%d', ", cQuery, pData[playerid][pOnDutyTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`faction` = '%d', ", cQuery, pData[playerid][pFaction]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`factionrank` = '%d', ", cQuery, pData[playerid][pFactionRank]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`factionlead` = '%d', ", cQuery, pData[playerid][pFactionLead]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`farm` = '%d', ", cQuery, pData[playerid][pFarm]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`farmrank` = '%d', ", cQuery, pData[playerid][pFarmRank]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`family` = '%d', ", cQuery, pData[playerid][pFamily]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`familyrank` = '%d', ", cQuery, pData[playerid][pFamilyRank]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`jail` = '%d', ", cQuery, pData[playerid][pJail]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`jail_time` = '%d', ", cQuery, pData[playerid][pJailTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`arrest` = '%d', ", cQuery, pData[playerid][pArrest]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`arrest_time` = '%d', ", cQuery, pData[playerid][pArrestTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`warn` = '%d', ", cQuery, pData[playerid][pWarn]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`job` = '%d', ", cQuery, pData[playerid][pJob]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`job2` = '%d', ", cQuery, pData[playerid][pJob2]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`sidejobtime` = '%d', ", cQuery, pData[playerid][pSideJobTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`jobtime` = '%d', ", cQuery, pData[playerid][pJobTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`sweepertime` = '%d', ", cQuery, pData[playerid][pSweeperTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`bustime` = '%d', ", cQuery, pData[playerid][pBusTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`forklifttime` = '%d', ", cQuery, pData[playerid][pForkliftTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`pizzatime` = '%d', ", cQuery, pData[playerid][pPizzaTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`exitjob` = '%d', ", cQuery, pData[playerid][pExitJob]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`taxitime` = '%d', ", cQuery, pData[playerid][pTaxiTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`medicine` = '%d', ", cQuery, pData[playerid][pMedicine]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`medkit` = '%d', ", cQuery, pData[playerid][pMedkit]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`helmet` = '%d', ", cQuery, pData[playerid][pHelmet]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`flight` = '%d', ", cQuery, pData[playerid][pFlashlight]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`snack` = '%d', ", cQuery, pData[playerid][pSnack]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`sprunk` = '%d', ", cQuery, pData[playerid][pSprunk]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`ayam` = '%d', ", cQuery, pData[playerid][pAyam]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`burger` = '%d', ", cQuery, pData[playerid][pBurger]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`nasbung` = '%d', ", cQuery, pData[playerid][pNasi]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`airmineral` = '%d', ", cQuery, pData[playerid][pMineral]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gas` = '%d', ", cQuery, pData[playerid][pGas]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`bandage` = '%d', ", cQuery, pData[playerid][pBandage]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gps` = '%d', ", cQuery, pData[playerid][pGPS]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`material` = '%d', ", cQuery, pData[playerid][pMaterial]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`component` = '%d', ", cQuery, pData[playerid][pComponent]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`food` = '%d', ", cQuery, pData[playerid][pFood]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`frozenpizza` = '%d', ", cQuery, pData[playerid][pFrozenPizza]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`seed` = '%d', ", cQuery, pData[playerid][pSeed]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`potato` = '%d', ", cQuery, pData[playerid][pPotato]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`wheat` = '%d', ", cQuery, pData[playerid][pWheat]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`orange` = '%d', ", cQuery, pData[playerid][pOrange]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price1` = '%d', ", cQuery, pData[playerid][pPrice1]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price2` = '%d', ", cQuery, pData[playerid][pPrice2]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price3` = '%d', ", cQuery, pData[playerid][pPrice3]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`price4` = '%d', ", cQuery, pData[playerid][pPrice4]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`marijuana` = '%d', ", cQuery, pData[playerid][pMarijuana]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`blindfold` = '%d', ", cQuery, pData[playerid][pBlindfold]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`armor` = '%d', ", cQuery, pData[playerid][pArmor]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`plant` = '%d', ", cQuery, pData[playerid][pPlant]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`plant_time` = '%d', ", cQuery, pData[playerid][pPlantTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fishtool` = '%d', ", cQuery, pData[playerid][pFishTool]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fish` = '%d', ", cQuery, pData[playerid][pFish]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`worm` = '%d', ", cQuery, pData[playerid][pWorm]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`mask` = '%d', ", cQuery, pData[playerid][pMask]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`fstyle` = '%d', ", cQuery, pData[playerid][pFightStyle]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`gvip` = '%d', ", cQuery, pData[playerid][pGymVip]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`idcard` = '%d', ", cQuery, pData[playerid][pIDCard]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`idcard_time` = '%d', ", cQuery, pData[playerid][pIDCardTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`licbiz` = '%d', ", cQuery, pData[playerid][pLicBiz]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`licbiz_time` = '%d', ", cQuery, pData[playerid][pLicBizTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`skck` = '%d', ", cQuery, pData[playerid][pSkck]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`skck_time` = '%d', ", cQuery, pData[playerid][pSkckTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`penebang` = '%d', ", cQuery, pData[playerid][pPenebangs]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`penebang_time` = '%d', ", cQuery, pData[playerid][pPenebangsTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`bpjs` = '%d', ", cQuery, pData[playerid][pBpjs]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`bpjs_time` = '%d', ", cQuery, pData[playerid][pBpjsTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`starter` = '%d', ", cQuery, pData[playerid][pSpack]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`drivelic` = '%d', ", cQuery, pData[playerid][pDriveLic]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`drivelic_time` = '%d', ", cQuery, pData[playerid][pDriveLicTime]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`boombox` = '%d', ", cQuery, pData[playerid][pBoombox]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`hbemode` = '%d', ", cQuery, pData[playerid][pHBEMode]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`tdmode` = '%d', ", cQuery, pData[playerid][pTDMode]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`tnames` = '%e', ", cQuery, pData[playerid][pTname]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`akuntw` = '%d', ", cQuery, pData[playerid][pTweet]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togpm` = '%d', ", cQuery, pData[playerid][pTogPM]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`toglog` = '%d', ", cQuery, pData[playerid][pTogLog]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togads` = '%d', ", cQuery, pData[playerid][pTogAds]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togwt` = '%d', ", cQuery, pData[playerid][pTogWT]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`togtweet` = '%d', ", cQuery, pData[playerid][pTogTweet]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`pegawai` = '%d', ", cQuery, pData[playerid][pWsEmplooye]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`trash` = '%d', ", cQuery, pData[playerid][pTrash]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`berry` = '%d', ", cQuery, pData[playerid][pBerry]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`borax` = '%d', ", cQuery, pData[playerid][pBorax]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`paketborax` = '%d', ", cQuery, pData[playerid][pPaketBorax]);
    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`redmoney` = '%d', ", cQuery, pData[playerid][pRedMoney]);
    // mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`truckskill` = '%d', ", cQuery, pData[playerid][pTruckSkill]);
    // mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`mechskill` = '%d', ", cQuery, pData[playerid][pMechSkill]);
    // mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`smuggskill` = '%d', ", cQuery, pData[playerid][pSmuggSkill]);

    mysql_format(g_SQL, cQuery, sizeof(cQuery), "%s`last_login` = CURRENT_TIMESTAMP() WHERE `reg_id` = '%d'", cQuery, pData[playerid][pID]);
    mysql_tquery(g_SQL, cQuery);

    // MySQL_SavePlayerToys(playerid);
    return 1;
}

IsATruck(vehicleid)
{
    switch (GetVehicleModel(vehicleid))
    {
        case 414, 455, 456, 498, 499, 609, 578:
            return 1;
        default:
            return 0;
    }

    return 0;
}

IsValidPassword(const name[])
{
    new len = strlen(name);

    for (new ch = 0; ch != len; ch++)
    {
        switch (name[ch])
        {
            case 'A' .. 'Z', 'a' .. 'z', '0' .. '9', ']', '[', '(', ')', '_', '.', '@', '#':
                continue;
            default:
                return false;
        }
    }
    return true;
}

RandomEx(min, max)
{
    return random(max - min) + min;
}

SendStaffMessage(color, const str[], {Float, _} : ...)
{
    static args,
           start,
           end,
           string[144];

	#emit LOAD.S.pri 8
	#emit STOR.pri args

    if (args > 8)
    {
		#emit ADDR.pri str
		#emit STOR.pri start

        for (end = start + (args - 8); end > start; end -= 4)
        {
			#emit LREF.pri end
			#emit PUSH.pri
        }

		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
        {
            if (pData[i][pAdmin] >= 1 || pData[i][pHelper] >= 1)
            {
                SendClientMessageEx(i, color, "[STAFF MSG]"YELLOW_E"%s", string);
            }
        }
        return 1;
    }
    foreach (new i : Player)
    {
        if (pData[i][pAdmin] >= 1 || pData[i][pHelper] >= 1)
        {
            SendClientMessageEx(i, color, "[STAFF MSG]"YELLOW_E"%s", string);
        }
    }
    return 1;
}

GetStaffRank(playerid)
{
    new name[40];
    if (pData[playerid][pAdmin] == 1)
    {
        name = ""RED_E"Moderator(1)";
    }
    else if (pData[playerid][pAdmin] == 2)
    {
        name = ""RED_E"Administator2)";
    }
    else if (pData[playerid][pAdmin] == 3)
    {
        name = ""RED_E"Senior Admin(3)";
    }
    else if (pData[playerid][pAdmin] == 4)
    {
        name = ""RED_E"Head Admin(4)";
    }
    else if (pData[playerid][pAdmin] == 5)
    {
        name = ""RED_E"Chief Executive Officer(5)";
    }
    else if (pData[playerid][pAdmin] >= 6)
    {
        name = ""RED_E"Developer(6)";
    }
    else if (pData[playerid][pHelper] == 1 && pData[playerid][pAdmin] == 0)
    {
        name = ""GREEN_E"Junior Helper";
    }
    else if (pData[playerid][pHelper] == 2 && pData[playerid][pAdmin] == 0)
    {
        name = ""GREEN_E"Senior Helper";
    }
    else if (pData[playerid][pHelper] == 3 && pData[playerid][pAdmin] == 0)
    {
        name = ""GREEN_E"Head Helper";
    }
    else
    {
        name = "None";
    }
    return name;
}

SendClientMessageToAllEx(color, const text[], {Float, _} : ...)
{
    static args,
           str[144];

    if ((args = numargs()) == 2)
    {
        SendClientMessageToAll(color, text);
    }
    else
    {
        while (--args >= 2)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit LOAD.S.pri 8
        #emit ADD.C 4
        #emit PUSH.pri
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessageToAll(color, str);

        #emit RETN
    }
    return 1;
}

stock BadaiCheck()
{
    static time[3],
           string[32];

    if (g_ServerBadai == 1 && !g_BadaiTime)
    {
        foreach (new i : Player)
        {
            UpdatePlayerData(i);
            SetPlayerName(i, pData[i][pName]);
        }
        SendRconCommand("exit");
    }
    else if (g_ServerBadai == 1)
    {
        GetElapsedTime(g_BadaiTime--, time[0], time[1], time[2]);

        format(string, 32, "~r~Kota akan Badai:~w~%02d:%02d", time[1], time[2]);
        TextDrawSetString(gServerTextdraws[1], string);
        SetWeather(15);
    }
    return 1;
}

stock RestartCheck()
{
    static time[3],
           string[32];

    if (g_ServerRestart == 1 && !g_RestartTime)
    {
        foreach (new i : Player)
        {
            UpdatePlayerData(i);
            SetPlayerName(i, pData[i][pName]);
        }
        SendRconCommand("gmx");
    }
    else if (g_ServerRestart == 1)
    {
        GetElapsedTime(g_RestartTime--, time[0], time[1], time[2]);

        format(string, 32, "~r~Server Restart:~w~%02d:%02d", time[1], time[2]);
        TextDrawSetString(gServerTextdraws[1], string);
        SetWeather(9);
    }
    return 1;
}

stock GetElapsedTime(time, &hours, &minutes, &seconds)
{
    hours = 0;
    minutes = 0;
    seconds = 0;

    if (time >= 3600)
    {
        hours = (time / 3600);
        time = (hours * 3600);
    }

    while (time >= 60)
    {
        minutes++;
        time -= 60;
    }
    return (seconds = time);
}

SetPlayerPositionEx(playerid, Float:x, Float:y, Float:z, Float:a, time = 2000)
{
    if (pData[playerid][pFreeze])
    {
        KillTimer(pData[playerid][pFreezeTimer]);
        pData[playerid][pFreeze] = 0;
        TogglePlayerControllable(playerid, 1);
    }
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, 0);
    pData[playerid][pFreeze] = 1;
    SetPlayerPos(playerid, x, y, z + 0.5);
    SetPlayerFacingAngle(playerid, a);
    pData[playerid][pFreezeTimer] = SetTimerEx("SetPlayerToUnfreeze", time, false, "iffff", playerid, x, y, z, a);
}

IsNumeric(const str[])
{
    for (new i = 0, l = strlen(str); i != l; i++)
    {
        if (i == 0 &&  str[0] == '-')
            continue;

        else if (str[i] < '0' || str[i] > '9')
            return 0;
    }
    return 1;
}

StaffCommandLog(const command[], adminid, player = INVALID_PLAYER_ID, logstr[] = '*')
{
    new logStrEscaped[128], query[512];
    if (logstr[0] == '*')
        logStrEscaped = "*", printf("AdminCommandLog: logstr detected as unnecessary, logStrEscaped = '%s' (must be '*')", logStrEscaped);
    else
        mysql_escape_string(logstr, logStrEscaped), printf("AdminCommandLog: logstr detected necessary, escaped from '%s' to '%s'", logstr, logStrEscaped);

    if (player != INVALID_PLAYER_ID)
    {
        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logstaff (command, admin, adminid, player, playerid, str, time) VALUES ('%s', '%s(%s)', '%d', '%s', UNIX_TIMESTAMP())", command, pData[adminid][pName], pData[adminid][pAdminname], pData[adminid][pID], pData[player][pName], pData[player][pID], logStrEscaped);
    }
    else
    {
        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logstaff (command, admin, adminid, str, time) VALUES ('%s','%s(%s)','%d','%s',UNIX_TIMESTAMP())", command, pData[adminid][pName], pData[adminid][pAdminname], pData[adminid][pID], logStrEscaped);
    }

    mysql_tquery(g_SQL, query);
    return 1;
}

ResetVariables(playerid)
{
    static const empty_player[E_PLAYERS];
    pData[playerid] = empty_player;

    pData[playerid][pInDoor] = -1;
    pData[playerid][pInHouse] = -1;
    pData[playerid][pInBiz] = -1;
    pData[playerid][pFamily] = -1;
    pData[playerid][IsLoggedIn] = false;
    pData[playerid][pHealth] = 100.0;
    pData[playerid][pArmour] = 0.0;
    pData[playerid][pMaskID] = random(90000) + 10000;
    pData[playerid][pSpec] = -1;

}

SendNearbyMessage(playerid, Float:radius, color, const str[], {Float, _} : ...)
{
    static args,
           start,
           end,
           string[144];

    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if (args > 16)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 16); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }

        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string

        #emit LOAD.S.pri 8
        #emit CONST.alt 4
        #emit SUB
        #emit PUSH.pri

        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        foreach (new i : Player)
        {
            if (NearPlayer(i, playerid, radius))
            {
                SendClientMessage(i, color, string);
            }
        }
        return 1;
    }

    foreach (new i : Player)
    {
        if (NearPlayer(i, playerid, radius))
        {
            SendClientMessage(i, color, str);
        }
    }
    return 1;
}

NearPlayer(playerid, targetid, Float:radius)
{
    static Float:fX,
           Float:fY,
           Float:fZ;

    GetPlayerPos(targetid, fX, fY, fZ);

    return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

ReturnName(playerid)
{
    static name[MAX_PLAYER_NAME + 1];

    GetPlayerName(playerid, name, sizeof(name));
    if (pData[playerid][pMaskOn] == 1 && pData[playerid][pAdminDuty] == 0)
        format(name, sizeof(name), "Mask_#%d", pData[playerid][pMaskID]);
    return name;
}

SetPlayerHealthEx(playerid, Float:heal)
{
    pData[playerid][pHealth] = heal;
    SetPlayerHealth(playerid, heal);
}

stock FormatMoney(amount, delimiter[2] = ".", comma[2] = ",")
{
    #define MAX_MONEY_String 16
    new MoneyAtString[MAX_MONEY_String];
    format(MoneyAtString, MAX_MONEY_String, "%d", amount);
    new l = strlen(MoneyAtString);
    if (amount < 0)
    {
        if (1 > 2) strins(MoneyAtString, delimiter, l - 2);
        if (1 > 5) strins(MoneyAtString, comma, l - 5);
        if (1 > 8) strins(MoneyAtString, comma, l - 8);
    }
    else
    {
        if (1 > 2) strins(MoneyAtString, delimiter, l - 2);
        if (1 > 5) strins(MoneyAtString, comma, l - 5);
        if (1 > 9) strins(MoneyAtString, comma, l - 8);
    }
    if (l <= 2) format(MoneyAtString, sizeof(MoneyAtString), "00,%s", MoneyAtString);
    return MoneyAtString;
}
DisplayStats(playerid, p2)
{
    new gstr[1024], header[512], scoremath = ((pData[p2][pLevel]) * 7), fac[24], fid = pData[p2][pFamily];
    header = "";
    gstr = "";

    if (pData[p2][pFaction] == 1)
    {
        fac = "San Andreas Police";
    }
    else if (pData[p2][pFaction] == 2)
    {
        fac = "San Andreas Goverment";
    }
    else if (pData[p2][pFaction] == 3)
    {
        fac = "San Andreas Medic";
    }
    else if (pData[p2][pFaction] == 4)
    {
        fac = "San Andreas News";
    }
    else if (pData[p2][pFaction] == 5)
    {
        fac = "Pedagang";
    }
    else
    {
        fac = "Penganguran";
    }

    new fname[128];
    if (fid != -1)
    {
        format(fname, 128, "Penganguran");
    }
    new atext[512];
    new boost = pData[playerid][pBooster];
    if (boost == 1)
    {
        atext = "{7fff00}YES";
    }
    else
    {
        atext = "{ff0000}NO";
    }

    new frname[128];
    /*if(pData[p2][pFarm] != -1)
    {
        format(frname, 128, "")
    }*/

    cache_get_value_name(0, "ucp", pData[p2][pUCP]);
    format(header, sizeof(header), "Stats: "GREEN_E"%s | "WHITE_E"UCP: "AQUA"%s", pData[p2][pName], pData[p2][pUCP]);
    format(gstr, sizeof(gstr), ""RED_E"In Character"WHITE_E"\n");
    format(gstr, sizeof(gstr), "%s{FFFFFF}Gender: [{FFFF00}%s{FFFFFF}] | Money: [{00FF00}$%s{FFFFFF}] | Bank: [{00FF00}%s{FFFFFF}] | Rekening Bank: [{C6E2FF}%d{FFFFFF}] | Phone Number: [{C6E2FF}%d{FFFFFF}]\n", gstr, (pData[p2][pGender] == 2) ? ("Female") : ("Male"), FormatMoney(pData[p2][pMoney]), FormatMoney(pData[p2][pBankMoney]), pData[p2][pBankRek], pData[p2][pPhone]);
    format(gstr, sizeof(gstr), "%sBirthdate: [{FFFF00}%s{FFFFFF}] | Job: [{C6E2FF}%s{FFFFFF}] | Job2: [{C6E2FF}%s{FFFFFF}] | [{C6E2FF}%s{FFFFFF}] | Family: [%s]\n", gstr, pData[p2][pAge], GetJobName(pData[p2][pJob]), GetJobName(pData[p2][pJob2]), fac, fname, frname);
    format(gstr, sizeof(gstr), "%sCharacter Story: [%s{FFFFFF}] | Health: [%f{FFFFFF}]\n\n", gstr, GetPlayerCharacterStory(p2), pData[p2][pHealth]);
    format(gstr, sizeof(gstr), "%s"RED_E"Out of Character"WHITE_E"\n", gstr);
    format(gstr, sizeof(gstr), "%sLevel Score: [{FF0000}%d/%d{FFFFFF}] | Email: [{FFFF00}%s{FFFFFF}] | Warning: [{FF0000}%d/20{FFFFFF}] | Last Login: [{FF0000}%s{FFFFFF}]\n", gstr, pData[p2][pLevelUp], scoremath, pData[p2][pEmail], pData[p2][pWarn], pData[p2][pLastLogin]);
    format(gstr, sizeof(gstr), "%sStaff: [%s{FFFFFF}] | Time Played: [{FFFF00}%d hours(s) %d minutes(s) %02d second(s){FFFFFF}] | Gold Coin: [{FFFF00}$%d{FFFFFF}]\n", gstr, GetStaffRank(p2), pData[p2][pHours], pData[p2][pMinutes], pData[p2][pSeconds], pData[p2][pGold]);
    if (pData[p2][pVipTime] != 0)
    {
        format(gstr, sizeof(gstr), "%sInterior: [{FFFF00}%d{FFFFFF}] | Virtual World: [{FFFF00}%d{FFFFFF}] | Register Date: [{C6E2FF}%s{FFFFFF}] | VIP Level: [%d{FFFFFF}] | VIP Time [{C6E2FF}%s{FFFFFF}] | Roleplay Booster: [%s{FFFFFF}] | Boost Time [{C6E2FF}%s{FFFFFF}]", gstr, GetPlayerInterior(p2), GetPlayerVirtualWorld(p2), pData[p2][pRegDate], GetVipRank(p2), ReturnTimelapse(gettime(), pData[p2][pVipTime]), boost, ReturnTimelapse(gettime(), pData[p2][pBoostTime]));
    }
    else
    {
        format(gstr, sizeof(gstr), "%sInterior: [{FFFF00}%d{FFFFFF}] | Virtual World: [{FFFF00}%d{FFFFFF}] | Register Date: [{C6E2FF}%s{FFFFFF}] | VIP Level: [%s{FFFFFF}] | VIP Time: [None] | Roleplay Booster: [%s{FFFFFF}] | Boost Time: [None]", gstr, GetPlayerInterior(p2), GetPlayerVirtualWorld(p2), pData[p2][pRegDate], GetVipRank(p2), boost);
    }
    ShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, header, gstr, "Settings", "Close");
    return 1;
}

GetJobName(type)
{
    static str[24];

    switch (type)
    {
        case 1: str = "?";
        default:
            str = "Pengganguran";
    }
    return str;
}

GetPlayerCharacterStory(playerid)
{
    new cs[512];
    if (pData[playerid][pCS] == 1)
    {
        cs = "{00FF00}Approved";
    }
    else
    {
        cs = "{FF0000}No";
    }
    return cs;
}

GetVipRank(playerid)
{
    new name[40];
    if (pData[playerid][pVip] == 1)
    {
        name = ""LG_E"Regular(1)";
    }
    else if (pData[playerid][pVip] == 2)
    {
        name = ""YELLOW_E"Premium(2)";
    }
    else if (pData[playerid][pVip] == 3)
    {
        name = ""PURPLE_E"VIP Player(3)";
    }
    else
    {
        name = "None";
    }
    return name;
}

SetPlayerPosition(playerid, Float:x, Float:y, Float:z, Float:a, inter = 0)
{
    SetPlayerInterior(playerid, inter);
    SetPlayerPos(playerid, x, y, z);
    SetPlayerFacingAngle(playerid, a);
    SetCameraBehindPlayer(playerid);
}

SetVehiclePositionEx(playerid, vehicleid, Float:x, Float:y, Float:z, Float:a, time = 2000)
{
    if (pData[playerid][pFreeze])
    {
        KillTimer(pData[playerid][pFreezeTimer]);
        pData[playerid][pFreeze] = 0;
        TogglePlayerControllable(playerid, 1);
    }
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, 0);
    pData[playerid][pFreeze] = 1;
    SetVehiclePos(vehicleid, x, y, z);
    SetVehicleZAngle(vehicleid, a);
    pData[playerid][pFreezeTimer] = SetTimerEx("SetVehicleToUnfreeze", time, false, "iiffff", playerid, vehicleid, x, y, z, a);
}

SetVehiclePosition(playerid, vehicleid, Float:x, Float:y, Float:z, Float:a, inter = 0)
{
    LinkVehicleToInterior(vehicleid, inter);
    SetVehiclePos(vehicleid, x, y, z);
    SetVehicleZAngle(vehicleid, a);
    SetCameraBehindPlayer(playerid);
}

GetWeatherName(weatherid)
{
    new cuaca[128];
    if (weatherid == 0)
    {
        cuaca = "{25CED1}EXTRASUNNY_LA";
    }
    else if (weatherid == 1)
    {
        cuaca = "{25CED1}SUNNY_LA";
    }
    else if (weatherid == 2)
    {
        cuaca = "{25CED1}EXTRASUNNY_LA";
    }
    else if (weatherid == 3)
    {
        cuaca = "{25CED1}SUNNY_SMOG_LA";
    }
    else if (weatherid == 4)
    {
        cuaca = "{25CED1}CLOUDY_LA";
    }
    else if (weatherid == 5)
    {
        cuaca = "{25CED1}SUNNY_SF";
    }
    else if (weatherid == 6)
    {
        cuaca = "{25CED1}EXTRASUNNY_SF";
    }
    else if (weatherid == 7)
    {
        cuaca = "{25CED1}CLOUDY_SF";
    }
    else if (weatherid == 8)
    {
        cuaca = "{25CED1}RAINY_SF";
    }
    else if (weatherid == 9)
    {
        cuaca = "{25CED1}FOGGY_SF";
    }
    else if (weatherid == 10)
    {
        cuaca = "{25CED1}SUNNY_VEGAS";
    }
    else if (weatherid == 11)
    {
        cuaca = "{25CED1}EXTRASUNNY_VEGAS";
    }
    else if (weatherid == 12)
    {
        cuaca = "{25CED1}CLOUDY_VEGAS";
    }
    else if (weatherid == 13)
    {
        cuaca = "{25CED1}EXTRASUNNY_COUNTRYSIDE";
    }
    else if (weatherid == 14)
    {
        cuaca = "{25CED1}SUNNY_COUNTRYSIDE";
    }
    else if (weatherid == 15)
    {
        cuaca = "{25CED1}CLOUDY_COUNTRYSIDE";
    }
    else if (weatherid == 16)
    {
        cuaca = "{25CED1}RAINY_COUNTRYSIDE";
    }
    else
    {
        cuaca = "{FFFFFF}null";
    }
    return cuaca;
}

SendAdminMessage(color, const str[], {Float, _} : ...)
{
    static args,
           start,
           end,
           string[144];

    #emit LOAD.S.pri 8
    #emit STOR.pri args

    if (args > 8)
    {
        #emit ADDR.pri str
        #emit STOR.pri start

        for (end = start + (args - 8); end > start; end -= 4)
        {
            #emit LREF.pri end
            #emit PUSH.pri
        }

        #emit PUSH.S str
        #emit PUSH.C 144
        #emit PUSH.C string

        #emit LOAD.S.pri 8
        #emit ADD.C 4
        #emit PUSH.pri

        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        foreach (new i : Player)
        {
            if (pData[i][pAdmin] >= 1)
            {
                SendClientMessageEx(i, color, "[ADMIN MSG] "YELLOW_E"%s", string);
            }
        }
        return 1;
    }
    foreach (new i : Player)
    {
        if (pData[i][pAdmin] >= 1)
        {
            SendClientMessageEx(i, color, "[ADMIN MSG] "YELLOW_E"%s", string);
        }
    }
    return 1;
}

ColouredText(text[])
{
    new pos = -1, string[144];

    strmid(string, text, 0, 128, (sizeof(string) - 16));

    while ((pos = strfind(string, "#", true, (pos + 1))) != -1)
    {
        new i = (pos + 1), hexCount;

        for (; ((string[i] != 0) && (hexCount < 6)); ++i, ++hexCount)
        {
            if (!(('a' <= string[i] <= 'f') || ('A' <= string[i] <= 'F') || ('0' <= string[i] <= '9')))
            {
                break;
            }
        }
        if ((hexCount == 6) && !(hexCount < 6))
        {
            string[pos] = '{';
            strins(string, "}", i);
        }
    }
    return string;
}