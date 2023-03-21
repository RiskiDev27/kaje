#define MAX_CHARS 3

new PlayerChar[MAX_PLAYERS][MAX_CHARS][MAX_PLAYER_NAME + 1];
new tempUCP[64];
new TempPass[MAX_PLAYERS];

stock CheckUCP(playerid)
{
	new query[256];
	format(query, sizeof(query), "SELECT * FROM `playerucp` WHERE `ucp` = '%s' LIMIT 1", GetName(playerid));
	mysql_tquery(g_SQL, query, "CheckPlayerUCP", "d", playerid);
	return 1;
}

function CheckPlayerUCP(playerid)
{
	new rows = cache_num_rows() > 0;
	new str[256];
	if (rows)
	{
        cache_get_value_name_int(0, "verdi", pData[playerid][pVerifikasi]);
        cache_get_value_name(0, "verifikasi", pData[playerid][pVerfi], 64);
		if(pData[playerid][pVerifikasi] == 1)
		{
            print("called logged");
            cache_get_value_name(0, "password", pData[playerid][pPassword], 65);
            cache_get_value_name(0, "salt", pData[playerid][pSalt], 17);
		    //cache_get_value_name(0, "UCP", tempUCP[playerid]);
		    //cache_get_value_name(0, "temppass", pData[playerid][pTempPass], 64);
		    //TempPass[playerid] = pData[playerid][pTempPass];
            format(str, sizeof(str), "Welcome Back to Roleplay Server!\n\nYour UCP: %s\nPlease insert your Password below to logged in:", GetName(playerid));
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "UCP - Login", str, "Login", "Exit");
		}
		else
		{
            print("yyyu");
            OnPlayerPassDone(playerid);
		}
	}
	else
	{
        // CheckPutih(playerid);
        OnPlayerPassDone(playerid);
	}
	return 1;
}

function CheckPlayerChar(playerid)
{
	cache_get_value_name_int(0, "extrac", pData[playerid][pExtraChar]);
	new query[256];
	format(query, sizeof(query), "SELECT `username` FROM `players` WHERE `ucp` = '%s' LIMIT %d;", GetName(playerid), MAX_CHARS + pData[playerid][pExtraChar]);
	mysql_tquery(g_SQL, query, "LoadCharacter", "d", playerid);
	return 1;
}

function LoadCharacter(playerid)
{
	for (new i = 0; i < MAX_CHARS; i ++)
	{
		PlayerChar[playerid][i][0] = EOS;
	}
	for (new i = 0; i < cache_num_rows(); i ++)
	{
		cache_get_value_name(i, "username", PlayerChar[playerid][i]);
	}
  	ShowCharacterList(playerid);
  	return 1;
}

ShowCharacterList(playerid)
{
	new name[256], count, sgstr[128];
	for (new i; i < MAX_CHARS; i ++) if(PlayerChar[playerid][i][0] != EOS)
	{
	    format(sgstr, sizeof(sgstr), "%s\n", PlayerChar[playerid][i]);
		strcat(name, sgstr);
		count++;
	}
	if(count < MAX_CHARS)
		strcat(name, ""BLUE_E"Create Character");
	ShowPlayerDialog(playerid, DIALOG_CHARLIST, DIALOG_STYLE_LIST, "Character List", name, "Select", "Quit");
	return 1;
}

function OnDass(playerid)
{
	print("Called Function Register");
	ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register Password", "Cretae your password account UCP", "input", "quit");
	return 1;
}
function OnPlayerPassDone(playerid)
{
	//CheckUCP(playerid);
	ShowPlayerDialog(playerid, DIALOG_VERIFIKASI, DIALOG_STYLE_INPUT, "Verifikasi Login Exotic", "Masukan Kode "RED_E"Verifikasi"WHITE_E"\nYang Dikirim Kan Di Direct Message Akun Discord Anda.", "Input", "Cancel");
	return 1;
}