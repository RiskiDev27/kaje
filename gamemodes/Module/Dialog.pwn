public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    printf("[OnDialogResponse]: %s(%d) has used dialog id: %d Listitem: %d", pData[playerid][pName], playerid, dialogid, listitem);
    if (dialogid == DIALOG_LOGIN)
    {
        if (!response) return Kick(playerid);

        /*new queen [256];
        format(queen, sizeof(queen), "SELECT Password FROM PlayerUCP WHERE UCP = '%s'", GetName(playerid));
        mysql_query(g_SQL, queen);
        */
        new hashed_pass[65];
        SHA256_PassHash(inputtext, pData[playerid][pSalt], hashed_pass, 65);

        if (strcmp(hashed_pass, pData[playerid][pPassword]) == 0)
        {
            new query1[512], query[512];
            /*	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", pData[playerid][pName]);
            	mysql_tquery(g_SQL, query, "AssignPlayerData", "d", playerid);
            */
            if (!IsValidRoleplayName(GetName(playerid)))
            {
                CheckPlayerChar(playerid);
            }
            else
            {
                mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", GetName(playerid));
                mysql_tquery(g_SQL, query, "AssignPlayerData", "d", playerid);
                SendClientMessage(playerid, COLOR_YELLOW, "[!] "WHITE_E"Welcome to Scatter Pride Indonesia");
                SendClientMessageEx(playerid, -1, ""YELLOW_E"[!] "WHITE_E"Dear "RED_E"%s"WHITE_E", Happy Roleplay!", pData[playerid][pName]);
                SendClientMessage(playerid, -1, ""YELLOW_E"[!] "WHITE_E"Patuhi peraturan server dan selamat bermain!");
            }
            printf("[LOGIN] %s(%d) has successfully login with password(%s)", pData[playerid][pName], playerid, inputtext);

            mysql_format(g_SQL, query1, sizeof(query1), "INSERT INTO loglogin (username,reg_id,password,time) VALUES('%s','%d','%s',CURRENT_TIMESTAMP())", pData[playerid][pName], pData[playerid][pID], inputtext);
            mysql_tquery(g_SQL, query1);
        }
        else
        {
            pData[playerid][LoginAttempts]++;

            if (pData[playerid][LoginAttempts] >= 3)
            {
                ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have mistyped your password too often (3 times).", "Okay", "");
                KickEx(playerid);
            }
            else ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Wrong password!\nPlease enter your password in the field below:", "Login", "Abort");
        }
        return 1;
    }
    if (dialogid == DIALOG_REGISTER)
    {
        if (!response) return Kick(playerid);

        if (strlen(inputtext) <= 5) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", "Your password must be longer than 5 characters!\nPlease enter your password in the field below:", "Register", "Abort");

        if (!IsValidPassword(inputtext))
        {
            Error(playerid, "Password can contain only A-Z, a-z, 0-9, _, [ ], ( )");
            ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", "Your password must be valid characters!\nPlease enter your password in the field below:", "Register", "Abort");
            return 1;
        }

        for (new i = 0; i < 16; i++) pData[playerid][pSalt][i] = random(94) + 33;
        SHA256_PassHash(inputtext, pData[playerid][pSalt], pData[playerid][pPassword], 65);

        new query[842], PlayerIP[16];
        GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
        mysql_format(g_SQL, query, sizeof query, "UPDATE `playerucp` SET `password` = '%s',`salt`= '%e', `verdi`='1' WHERE `ucp`='%s'", pData[playerid][pPassword], pData[playerid][pSalt], pData[playerid][pName]);
        mysql_tquery(g_SQL, query, "CheckPlayerChar", "i", playerid);
        format(TempPass[playerid], 64, inputtext);
        return 1;
    }
    if (dialogid == DIALOG_VERIFIKASI)
    {
        if (!response) return Kick(playerid);
        if (response)
        {
            if (isnull(inputtext)) return OnPlayerPassDone(playerid);
            if (!strcmp(inputtext, pData[playerid][pVerfi], true))
            {
                print("hj");
                OnDass(playerid);
                pData[playerid][pVerifikasi] = 1;
                Info(playerid, "Anda telah memverifikasi akun UCP anda.");
            }
            else
            {
                print("input data salah");
                Error(playerid, "Verifikasi kode salah!");
                OnPlayerPassDone(playerid);
            }
        }
    }
    if (dialogid == DIALOG_CHARLIST)
    {
        if (response)
        {
            if (PlayerChar[playerid][listitem][0] == EOS)
                return ShowPlayerDialog(playerid, DIALOG_MAKE_CHAR, DIALOG_STYLE_INPUT, "Create Character", "Insert your new Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Create", "Exit");
            pData[playerid][pChar] = listitem;
            SetPlayerName(playerid, PlayerChar[playerid][listitem]);
            new cQuery[256];
            mysql_format(g_SQL, cQuery, sizeof(cQuery), "SELECT * FROM `players` WHERE `username` = '%s' LIMIT 1;", PlayerChar[playerid][pData[playerid][pChar]]);
            mysql_tquery(g_SQL, cQuery, "AssignPlayerData", "d", playerid);

        }
    }
    if (dialogid == DIALOG_MAKE_CHAR)
    {
        if (response)
        {
            if (strlen(inputtext) < 1 || strlen(inputtext) > 24)
                return ShowPlayerDialog(playerid, DIALOG_MAKE_CHAR, DIALOG_STYLE_INPUT, "Create Character", "Insert your new Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Create", "Back");
            if (!IsValidRoleplayName(inputtext))
                return ShowPlayerDialog(playerid, DIALOG_MAKE_CHAR, DIALOG_STYLE_INPUT, "Create Character", "Insert your new Character Name\n\nExample: Finn_Xanderz, Javier_Cooper etc.", "Create", "Back");
            new characterQuery[178];
            mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "INSERT INTO `players` SET `username` = '%s', `ucp` = '%s'", inputtext, GetName(playerid));
            mysql_tquery(g_SQL, characterQuery, "OnPlayerRegister", "ds", playerid, inputtext);
            new query[824];
            mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `password` = '%s', `salt` = '%e', `temppass` = '%s' WHERE `username` = '%s'", pData[playerid][pPassword], pData[playerid][pSalt], pData[playerid][pTempPass], inputtext);
            mysql_query(g_SQL, query);
            format(pData[playerid][pName], MAX_PLAYER_NAME, inputtext);
            format(pData[playerid][pUCP], 22, GetName(playerid));
        }
    }
    if (dialogid == DIALOG_AGE)
    {
        if (!response) return ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
        if (response)
        {
            new iDay,
                iMonth,
                iYear,
                day,
                month,
                year;

            getdate(year, month, day);

            static const arrMonthDays[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

            if (sscanf(inputtext, "p</>ddd", iDay, iMonth, iYear))
            {
                ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
            }
            else if (iYear < 1900 || iYear > year)
            {
                ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tahun Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
            }
            else if (iMonth < 1 || iMonth > 12)
            {
                ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Bulan Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
            }
            else if (iDay < 1 || iDay > arrMonthDays[iMonth - 1])
            {
                ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Error! Invalid Input\nMasukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
            }
            else
            {
                format(pData[playerid][pAge], 50, inputtext);
                ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male/Laki-Laki\n2. Female/Perempuan", "Pilih", "Batal");
            }
        }
        else ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Pilih", "Batal");
        return 1;
    }
    if (dialogid == DIALOG_GENDER)
    {
        if (!response) return ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Male/Laki-Laki\n2. Female/Perempuan", "Pilih", "Batal");
        if (response)
        {
            pData[playerid][pGender] = listitem + 1;
            switch (listitem)
            {
                case 0:
                {
                    SendClientMessageEx(playerid, COLOR_LBLUE, "SERVER : "YELLOW_E"Registrasi Berhasil! Terima kasih telah bergabung ke dalam server!");
                    SendClientMessageEx(playerid, COLOR_LBLUE, "SERVER : Tanggal Lahir : "YELLOW_E"%s | "WHITE_E"Gender : "YELLOW_E"Male/Laki-Laki", pData[playerid][pAge]);
                    SendClientMessageEx(playerid, COLOR_RED, "NEWBIE : "WHITE_E"Get your starterpack to the checkpoint and type '/claimsp'.");
                    SendClientMessageEx(playerid, COLOR_RED, "NEWBIE : "WHITE_E" Use '/help' for more info and '/settings'");
                    SetPlayerCheckpoint(playerid, 1249.4832, -2059.7822, 59.7248, 2.0);
                    switch (pData[playerid][pGender])
                    {
                        case 1: ShowModelSelectionMenu(playerid, SpawnMale, "Choose your skin");
                        case 2: ShowModelSelectionMenu(playerid, SpawnFemale, "Choose your skin");
                    }
                }
                case 1:
                {
                    SendClientMessageEx(playerid, COLOR_LBLUE, "SERVER : "YELLOW_E"Registrasi Berhasil! Terima kasih telah bergabung ke dalam server!");
                    SendClientMessageEx(playerid, COLOR_LBLUE, "SERVER : Tanggal Lahir : "YELLOW_E"%s | "WHITE_E"Gender : "YELLOW_E"Male/Laki-Laki", pData[playerid][pAge]);
                    SendClientMessageEx(playerid, COLOR_RED, "NEWBIE : "WHITE_E"Get your starterpack to the checkpoint and type '/claimsp'.");
                    SendClientMessageEx(playerid, COLOR_RED, "NEWBIE : "WHITE_E" Use '/help' for more info and '/settings'");
                    SetPlayerCheckpoint(playerid, 1249.4832, -2059.7822, 59.7248, 2.0);
                    switch (pData[playerid][pGender])
                    {
                        case 1: ShowModelSelectionMenu(playerid, SpawnMale, "Choose your skin");
                        case 2: ShowModelSelectionMenu(playerid, SpawnFemale, "Choose your skin");
                    }
                }
            }
            pData[playerid][pSkin] = (listitem) ? (233) : (98);
            SetPlayerSkin(playerid, pData[playerid][pSkin]);
            SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1132.4504, -2037.0957, 69.0078, 269.9846, 0, 0, 0, 0, 0, 0);
            SpawnPlayer(playerid);
        }
        else ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Gender", "1. Laki-Laki\n2. Perempuan", "Pilih", "Batal");
        return 1;
    }

    if (dialogid == DIALOG_LOCKERSAGS)
    {
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if (pData[playerid][pOnDuty] == 1)
                    {
                        pData[playerid][pOnDuty] = 0;
                        SetPlayerColor(playerid, COLOR_WHITE);
                        SetPlayerSkin(playerid, pData[playerid][pSkin]);
                        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s places their badge and gun in their locker", ReturnName(playerid));
                    }
                    else
                    {
                        pData[playerid][pOnDuty] = 1;
                        SetFactionColor(playerid);
                        if (pData[playerid][pGender] == 1)
                        {
                            SetPlayerSkin(playerid, 295);
                            pData[playerid][pFacSkin] = 295;
                        }
                        else
                        {
                            SetPlayerSkin(playerid, 141);
                            pData[playerid][pFacSkin] = 141;
                        }
                        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s withdraws their badge and onduty from theri locker", ReturnName(playerid));
                    }
                }
            }
        }
        return 1;
    }
    return 1;
}