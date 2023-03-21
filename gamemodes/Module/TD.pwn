//Info textdraw
new PlayerText:InfoTD[MAX_PLAYERS];



new Text:gServerTextdraws[2];



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