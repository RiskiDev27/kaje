/*
		CREATED BY Quen#7955 (Twosix)
		
		- Don't delete the owner's name and don't acknowledge
		- No one can sell it
*/

/* Update Player Bar */
UpdatePlayerBarHbe(playerid)
{
	new Float:hunger, Float:energy, Float:health, Float:armour;
 	hunger = pData[playerid][pHunger] * 23.0/100;
	PlayerTextDrawTextSize(playerid,FiveM13[playerid], hunger, 23.0);
 	PlayerTextDrawShow(playerid, FiveM13[playerid]);
 	
 	energy = pData[playerid][pEnergy] * 23.0/100;
	PlayerTextDrawTextSize(playerid,FiveM14[playerid], energy, 23.0);
 	PlayerTextDrawShow(playerid,FiveM14[playerid]);
 	
 	health = pData[playerid][pHealth] * 35.0/100;
	PlayerTextDrawTextSize(playerid,FiveM11[playerid], health, 23.0);
 	PlayerTextDrawShow(playerid,FiveM11[playerid]);

 	armour = pData[playerid][pArmour] * 35.0/100;
	PlayerTextDrawTextSize(playerid,FiveM12[playerid], armour, 23.0);
 	PlayerTextDrawShow(playerid,FiveM12[playerid]);
	return true;
}

ptask PlayerUpdate[999](playerid)
{
    UpdatePlayerHbe(playerid) // data reduction and update player bar
    return 1;
}

/* Variable */
new PlayerText:FiveM1[MAX_PLAYERS];
new PlayerText:FiveM2[MAX_PLAYERS];
new PlayerText:FiveM3[MAX_PLAYERS];
new PlayerText:FiveM4[MAX_PLAYERS];
new PlayerText:FiveM5[MAX_PLAYERS];
new PlayerText:FiveM6[MAX_PLAYERS];
new PlayerText:FiveM7[MAX_PLAYERS];
new PlayerText:FiveM8[MAX_PLAYERS];
new PlayerText:FiveM9[MAX_PLAYERS];
new PlayerText:FiveM10[MAX_PLAYERS];
new PlayerText:FiveM11[MAX_PLAYERS];
new PlayerText:FiveM12[MAX_PLAYERS];
new PlayerText:FiveM13[MAX_PLAYERS];
new PlayerText:FiveM14[MAX_PLAYERS];
new PlayerText:FiveM15[MAX_PLAYERS];
new PlayerText:FiveM16[MAX_PLAYERS];
new PlayerText:FiveM17[MAX_PLAYERS];
new PlayerText:FiveM18[MAX_PLAYERS];

new PlayerText:SPEEDOS[MAX_PLAYERS];
new PlayerText:HEALTH[MAX_PLAYERS];
new PlayerText:KPH[MAX_PLAYERS];

new PlayerText:SEATBELT[MAX_PLAYERS];
new PlayerText:FUEL[MAX_PLAYERS];
new PlayerText:CRUISE[MAX_PLAYERS];

TextDrawCreate(playerid)
{
    /* Hbe Mode */
    FiveM1[playerid] = CreatePlayerTextDraw(playerid, 20.000000, 420.000000, "id_dual:white");
	PlayerTextDrawFont(playerid, FiveM1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM1[playerid], 76.000000, 2.000000);
	PlayerTextDrawSetOutline(playerid, FiveM1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM1[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM1[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM1[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM1[playerid], 0);

	FiveM2[playerid] = CreatePlayerTextDraw(playerid, 20.000000, 445.000000, "id_dual:white");
	PlayerTextDrawFont(playerid, FiveM2[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM2[playerid], 76.000000, 2.000000);
	PlayerTextDrawSetOutline(playerid, FiveM2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM2[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM2[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM2[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM2[playerid], 0);

	FiveM3[playerid] = CreatePlayerTextDraw(playerid, 100.000000, 420.000000, "id_dual:white");
	PlayerTextDrawFont(playerid, FiveM3[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM3[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM3[playerid], 55.000000, 2.000000);
	PlayerTextDrawSetOutline(playerid, FiveM3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM3[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM3[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM3[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM3[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM3[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM3[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM3[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM3[playerid], 0);

	FiveM4[playerid] = CreatePlayerTextDraw(playerid, 100.000000, 445.000000, "id_dual:white");
	PlayerTextDrawFont(playerid, FiveM4[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM4[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM4[playerid], 55.000000, 2.000000);
	PlayerTextDrawSetOutline(playerid, FiveM4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM4[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM4[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM4[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM4[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM4[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM4[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM4[playerid], 0);

	FiveM5[playerid] = CreatePlayerTextDraw(playerid, 20.000000, 420.000000, "id_dual:white");
	PlayerTextDrawFont(playerid, FiveM5[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM5[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM5[playerid], 2.000000, 25.000000);
	PlayerTextDrawSetOutline(playerid, FiveM5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM5[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM5[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM5[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM5[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM5[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM5[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM5[playerid], 0);

	FiveM6[playerid] = CreatePlayerTextDraw(playerid, 94.000000, 420.000000, "id_dual:white");
	PlayerTextDrawFont(playerid, FiveM6[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM6[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM6[playerid], 2.000000, 25.000000);
	PlayerTextDrawSetOutline(playerid, FiveM6[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM6[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM6[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM6[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM6[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM6[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM6[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM6[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM6[playerid], 0);

	FiveM7[playerid] = CreatePlayerTextDraw(playerid, 100.000000, 420.000000, "id_dual:white");
	PlayerTextDrawFont(playerid, FiveM7[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM7[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM7[playerid], 2.000000, 25.000000);
	PlayerTextDrawSetOutline(playerid, FiveM7[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM7[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM7[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM7[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM7[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM7[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM7[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM7[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM7[playerid], 0);

	FiveM8[playerid] = CreatePlayerTextDraw(playerid, 153.000000, 420.000000, "id_dual:white");
	PlayerTextDrawFont(playerid, FiveM8[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM8[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM8[playerid], 2.000000, 25.000000);
	PlayerTextDrawSetOutline(playerid, FiveM8[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM8[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM8[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM8[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM8[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM8[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM8[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM8[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM8[playerid], 0);

	FiveM9[playerid] = CreatePlayerTextDraw(playerid, 126.000000, 420.000000, "id_dual:white");
	PlayerTextDrawFont(playerid, FiveM9[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM9[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM9[playerid], 2.000000, 25.000000);
	PlayerTextDrawSetOutline(playerid, FiveM9[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM9[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM9[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM9[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM9[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM9[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM9[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM9[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM9[playerid], 0);

	FiveM10[playerid] = CreatePlayerTextDraw(playerid, 57.000000, 420.000000, "id_dual:white");
	PlayerTextDrawFont(playerid, FiveM10[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM10[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM10[playerid], 2.000000, 25.000000);
	PlayerTextDrawSetOutline(playerid, FiveM10[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM10[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM10[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM10[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM10[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM10[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM10[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM10[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM10[playerid], 0);

	FiveM11[playerid] = CreatePlayerTextDraw(playerid, 22.000000, 422.000000, "id_dual:white"); //darah
	PlayerTextDrawFont(playerid, FiveM11[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM11[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM11[playerid], 35.000000, 23.000000);
	PlayerTextDrawSetOutline(playerid, FiveM11[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM11[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM11[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM11[playerid], 0xde0711ff);
	PlayerTextDrawBackgroundColor(playerid, FiveM11[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM11[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM11[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM11[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM11[playerid], 0);

	FiveM12[playerid] = CreatePlayerTextDraw(playerid, 59.000000, 422.000000, "id_dual:white"); //armor
	PlayerTextDrawFont(playerid, FiveM12[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM12[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM12[playerid], 35.000000, 23.000000);
	PlayerTextDrawSetOutline(playerid, FiveM12[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM12[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM12[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM12[playerid], 0x080100ff);
	PlayerTextDrawBackgroundColor(playerid, FiveM12[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM12[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM12[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM12[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM12[playerid], 0);

	FiveM13[playerid] = CreatePlayerTextDraw(playerid, 102.000000, 422.000000, "id_dual:white"); //lapar
	PlayerTextDrawFont(playerid, FiveM13[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM13[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM13[playerid], 23.000000, 23.000000);
	PlayerTextDrawSetOutline(playerid, FiveM13[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM13[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM13[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM13[playerid], 0xf59e07ff);
	PlayerTextDrawBackgroundColor(playerid, FiveM13[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM13[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM13[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM13[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM13[playerid], 0);

	FiveM14[playerid] = CreatePlayerTextDraw(playerid, 128.000000, 422.000000, "id_dual:white"); //haus
	PlayerTextDrawFont(playerid, FiveM14[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM14[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM14[playerid], 23.000000, 23.000000);
	PlayerTextDrawSetOutline(playerid, FiveM14[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM14[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM14[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM14[playerid], 0x0753f5ff);
	PlayerTextDrawBackgroundColor(playerid, FiveM14[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM14[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM14[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM14[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM14[playerid], 0);

	FiveM15[playerid] = CreatePlayerTextDraw(playerid, 25.000000, 427.000000, "hud:radar_girlfriend");
	PlayerTextDrawFont(playerid, FiveM15[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM15[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM15[playerid], 12.000000, 12.000000);
	PlayerTextDrawSetOutline(playerid, FiveM15[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM15[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM15[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM15[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM15[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM15[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM15[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM15[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM15[playerid], 0);

	FiveM16[playerid] = CreatePlayerTextDraw(playerid, 62.000000, 427.000000, "hud:radar_tshirt");
	PlayerTextDrawFont(playerid, FiveM16[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM16[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM16[playerid], 12.000000, 12.000000);
	PlayerTextDrawSetOutline(playerid, FiveM16[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM16[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM16[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM16[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM16[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM16[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM16[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM16[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM16[playerid], 0);

	FiveM17[playerid] = CreatePlayerTextDraw(playerid, 108.000000, 427.000000, "hud:radar_pizza");
	PlayerTextDrawFont(playerid, FiveM17[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM17[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM17[playerid], 12.000000, 12.000000);
	PlayerTextDrawSetOutline(playerid, FiveM17[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM17[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM17[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM17[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM17[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM17[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM17[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM17[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM17[playerid], 0);

	FiveM18[playerid] = CreatePlayerTextDraw(playerid, 134.000000, 427.000000, "hud:radar_diner");
	PlayerTextDrawFont(playerid, FiveM18[playerid], 4);
	PlayerTextDrawLetterSize(playerid, FiveM18[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, FiveM18[playerid], 12.000000, 12.000000);
	PlayerTextDrawSetOutline(playerid, FiveM18[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FiveM18[playerid], 0);
	PlayerTextDrawAlignment(playerid, FiveM18[playerid], 1);
	PlayerTextDrawColor(playerid, FiveM18[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FiveM18[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FiveM18[playerid], 50);
	PlayerTextDrawUseBox(playerid, FiveM18[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FiveM18[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FiveM18[playerid], 0);

    /* Vehicle TextDraw */
    SPEEDOS[playerid] = CreatePlayerTextDraw(playerid, 118.000000, 376.000000, "100");
	PlayerTextDrawFont(playerid, SPEEDOS[playerid], 1);
	PlayerTextDrawLetterSize(playerid, SPEEDOS[playerid], 0.349999, 2.000000);
	PlayerTextDrawTextSize(playerid, SPEEDOS[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, SPEEDOS[playerid], 0);
	PlayerTextDrawSetShadow(playerid, SPEEDOS[playerid], 0);
	PlayerTextDrawAlignment(playerid, SPEEDOS[playerid], 1);
	PlayerTextDrawColor(playerid, SPEEDOS[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, SPEEDOS[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SPEEDOS[playerid], 50);
	PlayerTextDrawUseBox(playerid, SPEEDOS[playerid], 0);
	PlayerTextDrawSetProportional(playerid, SPEEDOS[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SPEEDOS[playerid], 0);

	HEALTH[playerid] = CreatePlayerTextDraw(playerid, 588.000000, 410.000000, "100%");
	PlayerTextDrawFont(playerid, HEALTH[playerid], 1);
	PlayerTextDrawLetterSize(playerid, HEALTH[playerid], 0.300000, 1.550000);
	PlayerTextDrawTextSize(playerid, HEALTH[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HEALTH[playerid], 0);
	PlayerTextDrawSetShadow(playerid, HEALTH[playerid], 0);
	PlayerTextDrawAlignment(playerid, HEALTH[playerid], 1);
	PlayerTextDrawColor(playerid, HEALTH[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HEALTH[playerid], 255);
	PlayerTextDrawBoxColor(playerid, HEALTH[playerid], 50);
	PlayerTextDrawUseBox(playerid, HEALTH[playerid], 0);
	PlayerTextDrawSetProportional(playerid, HEALTH[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HEALTH[playerid], 0);

	KPH[playerid] = CreatePlayerTextDraw(playerid, 140.000000, 384.000000, "KPH");
	PlayerTextDrawFont(playerid, KPH[playerid], 1);
	PlayerTextDrawLetterSize(playerid, KPH[playerid], 0.220833, 1.000000);
	PlayerTextDrawTextSize(playerid, KPH[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, KPH[playerid], 0);
	PlayerTextDrawSetShadow(playerid, KPH[playerid], 0);
	PlayerTextDrawAlignment(playerid, KPH[playerid], 1);
	PlayerTextDrawColor(playerid, KPH[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, KPH[playerid], 255);
	PlayerTextDrawBoxColor(playerid, KPH[playerid], 50);
	PlayerTextDrawUseBox(playerid, KPH[playerid], 0);
	PlayerTextDrawSetProportional(playerid, KPH[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, KPH[playerid], 0);

	FUEL[playerid] = CreatePlayerTextDraw(playerid, 183.000000, 384.000000, "FUEL");
	PlayerTextDrawFont(playerid, FUEL[playerid], 1);
	PlayerTextDrawLetterSize(playerid, FUEL[playerid], 0.220833, 1.000000);
	PlayerTextDrawTextSize(playerid, FUEL[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, FUEL[playerid], 0);
	PlayerTextDrawSetShadow(playerid, FUEL[playerid], 0);
	PlayerTextDrawAlignment(playerid, FUEL[playerid], 1);
	PlayerTextDrawColor(playerid, FUEL[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FUEL[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FUEL[playerid], 50);
	PlayerTextDrawUseBox(playerid, FUEL[playerid], 0);
	PlayerTextDrawSetProportional(playerid, FUEL[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FUEL[playerid], 0);

	CRUISE[playerid] = CreatePlayerTextDraw(playerid, 118.000000, 396.000000, "~r~CRUISE");
	PlayerTextDrawFont(playerid, CRUISE[playerid], 1);
	PlayerTextDrawLetterSize(playerid, CRUISE[playerid], 0.245832, 1.449999);
	PlayerTextDrawTextSize(playerid, CRUISE[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, CRUISE[playerid], 0);
	PlayerTextDrawSetShadow(playerid, CRUISE[playerid], 0);
	PlayerTextDrawAlignment(playerid, CRUISE[playerid], 1);
	PlayerTextDrawColor(playerid, CRUISE[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, CRUISE[playerid], 255);
	PlayerTextDrawBoxColor(playerid, CRUISE[playerid], 50);
	PlayerTextDrawUseBox(playerid, CRUISE[playerid], 0);
	PlayerTextDrawSetProportional(playerid, CRUISE[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, CRUISE[playerid], 0);

	SEATBELT[playerid] = CreatePlayerTextDraw(playerid, 159.000000, 396.000000, "~r~SEATBELT");
	PlayerTextDrawFont(playerid, SEATBELT[playerid], 1);
	PlayerTextDrawLetterSize(playerid, SEATBELT[playerid], 0.245832, 1.449999);
	PlayerTextDrawTextSize(playerid, SEATBELT[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, SEATBELT[playerid], 0);
	PlayerTextDrawSetShadow(playerid, SEATBELT[playerid], 0);
	PlayerTextDrawAlignment(playerid, SEATBELT[playerid], 1);
	PlayerTextDrawColor(playerid, SEATBELT[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, SEATBELT[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SEATBELT[playerid], 50);
	PlayerTextDrawUseBox(playerid, SEATBELT[playerid], 0);
	PlayerTextDrawSetProportional(playerid, SEATBELT[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, SEATBELT[playerid], 0);
}