





//Info textdraw
new PlayerText:InfoTD[MAX_PLAYERS];



new Text:gServerTextdraws[2];

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

CreatePlayerTextDraws(playerid)
{
    //Info textdraw
    InfoTD[playerid] = CreatePlayerTextDraw(playerid, 148.888, 361.385, "Welcome!");
    PlayerTextDrawLetterSize(playerid, InfoTD[playerid], 0.326, 1.654);
    PlayerTextDrawAlignment(playerid, InfoTD[playerid], 1);
    PlayerTextDrawColor(playerid, InfoTD[playerid], -1);
    PlayerTextDrawSetOutline(playerid, InfoTD[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, InfoTD[playerid], 0x000000FF);
    PlayerTextDrawFont(playerid, InfoTD[playerid], 1);
    PlayerTextDrawSetProportional(playerid, InfoTD[playerid], 1);

    // test
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
}

CreatePublicTextDraws()
{
    //
    gServerTextdraws[1] = TextDrawCreate(237.000000, 409.000000, "~r~Kota Badai:~w~ 00:00");
    TextDrawBackgroundColor(gServerTextdraws[1], 255);
    TextDrawFont(gServerTextdraws[1], 1);
    TextDrawLetterSize(gServerTextdraws[1], 0.480000, 1.300000);
    TextDrawColor(gServerTextdraws[1], -1);
    TextDrawSetOutline(gServerTextdraws[1], 1);
    TextDrawSetProportional(gServerTextdraws[1], 1);
    TextDrawSetSelectable(gServerTextdraws[1], 0);
}

