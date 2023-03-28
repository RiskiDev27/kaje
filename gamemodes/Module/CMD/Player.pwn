







CMD:stats(playerid, params[])
{
    if(pData[playerid][IsLoggedIn] == false)
    {
        Error(playerid, "You must be logged in to check statistick!");
        return 1;
    }

    DisplayStats(playerid, playerid);
    return 1;
}

CMD:enter(playerid, params[])
{
    if(pData[playerid][pInjured] == 0)
    {
        foreach(new did : Doors)
        {
            if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ]))
            {
                if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
                {
                    if(dData[did][dIntPosX] == 0.0 && dData[did][dIntPosY] == 0.0 &&  dData[did][dIntPosZ] == 0.0)
                        return Error(playerid, "Interior entrance masih kosong atau tidak memiliki interior.");
                    
                    if(dData[did][dLocked])
                        return Error(playerid, "This entrance is locked at the moment");
                    
                    if(dData[did][dFaction] > 0)
                    {
                        if(dData[did][dFaction] != pData[playerid][pFaction])
                            return Error(playerid, "This door only for faction.");
                    }

                    if(dData[did][dFamily] > 0)
                    {
                        if(dData[did][dFamily] != pData[playerid][pFamily])
                            return Error(playerid, "This door only for family");
                    }

                    if(dData[did][dVip] > pData[playerid][pVip])
                        return Error(playerid, "Your VIP Level not enough to enter this door.");
                    
                    if(dData[did][dAdmin] > pData[playerid][pAdmin])
                        return Error(playerid, "Your admin level not enough to enter this door.");
                    
                    if(strlen(dData[did][dPass]))
                    {
                        if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
                        if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password");

                        if(dData[did][dCustom])
                        {
                            SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntPosX], dData[did][dIntPosY], dData[did][dIntPosZ], dData[did][dIntPosA]);
                        }
                        else
                        {
                            SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntPosX], dData[did][dIntPosY], dData[did][dIntPosZ], dData[did][dIntPosA]);
                        }
                        pData[playerid][pInDoor] = did;
                        SetPlayerInterior(playerid, dData[did][dInt]);
                        SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
                        SetCameraBehindPlayer(playerid);
                        SetPlayerWeather(playerid, 0);
                    }
                    else
                    {
                        if(dData[did][dCustom])
                        {
                            SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntPosX], dData[did][dIntPosY], dData[did][dIntPosZ], dData[did][dIntPosA]);
                        }
                        else
                        {
                            SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntPosX], dData[did][dIntPosY], dData[did][dIntPosZ], dData[did][dIntPosA]);
                        }
                        pData[playerid][pInDoor] = did;
                        SetPlayerInterior(playerid, dData[did][dInt]);
                        SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
                        SetCameraBehindPlayer(playerid);
                        SetPlayerWeather(playerid, 0);
                    }
                }
                else
                {
                    if(dData[did][dIntPosX] == 0.0 && dData[did][dIntPosY] == 0.0 && dData[did][dIntPosZ] == 0.0)
                        return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");
                    
                    if(dData[did][dLocked])
                        return Error(playerid, "This entrance is locked at the moment.");
                    
                    if(dData[did][dFaction] > 0)
                    {
                        if(dData[did][dFaction] != pData[playerid][pFaction])
                            return Error(playerid, "This is only for faction.");
                    }

                    if(dData[did][dFamily] > 0)
                    {
                        if(dData[did][dFamily] != pData[playerid][pFamily])
                            return Error(playerid, "This is only for family");
                    }

                    if(dData[did][dVip] > pData[playerid][pVip])
                        return Error(playerid, "Your VIP level not enough to enter this door.");
                    
                    if(dData[did][dAdmin] > pData[playerid][pAdmin])
                        return Error(playerid, "Your ADMIN level not enough to enter this door.");
                    
                    if(strlen(dData[did][dPass]))
                    {
                        if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
                        if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password");

                        if(dData[did][dCustom])
                        {
                            SetPlayerPositionEx(playerid, dData[did][dIntPosX], dData[did][dIntPosY], dData[did][dIntPosZ], dData[did][dIntPosA]);
                        }
                        else
                        {
                            SetPlayerPosition(playerid, dData[did][dIntPosX], dData[did][dIntPosY], dData[did][dIntPosZ], dData[did][dIntPosA]);
                        }
                        pData[playerid][pInDoor] = did;
                        SetPlayerInterior(playerid, dData[did][dInt]);
                        SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
                        SetCameraBehindPlayer(playerid);
                        SetPlayerWeather(playerid, 0);
                    }
                    else
                    {
                        if(dData[did][dCustom])
                        {
                            SetPlayerPositionEx(playerid, dData[did][dIntPosX], dData[did][dIntPosY], dData[did][dIntPosZ], dData[did][dIntPosA]);
                        }
                        else
                        {
                            SetPlayerPosition(playerid, dData[did][dIntPosX], dData[did][dIntPosY], dData[did][dIntPosZ], dData[did][dIntPosA]);
                        }
                        pData[playerid][pInDoor] = did;
                        SetPlayerInterior(playerid, dData[did][dInt]);
                        SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
                        SetCameraBehindPlayer(playerid);
                        SetPlayerWeather(playerid, 0);
                    }
                }
            }
            if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntPosX], dData[did][dIntPosY], dData[did][dIntPosZ]))
            {
                if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
                {
                    if(dData[did][dFaction] > 0)
                    {
                        if(dData[did][dFaction] != pData[playerid][pFaction])
                            return Error(playerid, "This door only for faction");
                    }

                    if(dData[did][dCustom])
                    {
                        SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ], dData[did][dExtPosA]);
                    }
                    else
                    {
                        SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ], dData[did][dExtPosA]);
                    }
                    pData[playerid][pInDoor] = -1;
                    SetPlayerInterior(playerid, dData[did][dExtInt]);
                    SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
                    SetCameraBehindPlayer(playerid);
                    SetPlayerWeather(playerid, WorldWeather);
                }
                else
                {
                    if(dData[did][dFaction] > 0)
                    {
                        if(dData[did][dFaction] != pData[playerid][pFaction])
                            return Error(playerid, "This door only for faction.");
                    }
                    if(dData[did][dCustom])
                        SetPlayerPositionEx(playerid, dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ], dData[did][dExtPosA]);
                    else
                        SetPlayerPosition(playerid, dData[did][dExtPosX], dData[did][dExtPosY], dData[did][dExtPosZ], dData[did][dExtPosA]);
                        
                    pData[playerid][pInDoor] = -1;
                    SetPlayerInterior(playerid, dData[did][dExtInt]);
                    SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
                    SetCameraBehindPlayer(playerid);
                    SetPlayerWeather(playerid, WorldWeather);
                    
                }
            }
        }
    }
    return 1;
}