//---- [ Include ]----
#include <a_samp>
#undef MAX_PLAYERS
#define MAX_PLAYERS	500
#include <crashdetect.inc>
#include <gvar.inc>
#include <a_mysql>
#include <a_actor>
#include <a_http>
#include <a_objects>
#include <a_zones>
#include <a_graphfunc>
#include <CTime>
#include <Dini>
#include <progress2.inc>
#include <Pawn.CMD.inc>
#include <mSelection.inc>
#include <TimestampToDate.inc>
#define ENABLE_3D_TRYG_YSI_SUPPORT
#include <streamer.inc>
#include <EVF.inc>
#include <ColAndreas>
#include <3DTryg>
#include <VehPara>
#include <YSI\y_timers>
#include <YSI\y_iterate>
#include <sscanf2.inc>
#include <yom_buttons.inc>
#include <geolocation.inc>
#include <garageblock.inc>
#include <timerfix.inc>
// #include <discord-cmd>
#include <discord-connector.inc>
// #include <sampvoice>
#include <anti-cheat>
#include "../include/gl_common.inc"
#include "../include/ui_progressbar.inc"
//---- [ Include ]----
#include "Module\Define.pwn"
#include "Module\Color.pwn"
#include "Module\TD.pwn"
//DIALOG
enum
{
    //DEALER
    DIALOG_BUYJOBCARSVEHICLE,
    DIALOG_BUYDEALERCARS_CONFIRM,
    DIALOG_BUYTRUCKVEHICLE,
    DIALOG_BUYMOTORCYCLEVEHICLE,
    DIALOG_BUYUCARSVEHICLE,
    DIALOG_BUYCARSVEHICLE,
    DIALOG_DEALER_MANAGE,
    DIALOG_DEALER_VAULT,
    DIALOG_DEALER_WITHDRAW,
    DIALOG_DEALER_DEPOSIT,
    DIALOG_DEALER_NAME,
    DIALOG_DEALER_RESTOCK,
    DIALOG_PVSAPD,
    DIALOG_PVSAMD,
    DIALOG_VEHCO,
    //Vending
    DIALOG_VENDING_BUYPROD,
    DIALOG_VENDING_MANAGE,
    DIALOG_VENDING_NAME,
    DIALOG_VENDING_VAULT,
    DIALOG_VENDING_WITHDRAW,
    DIALOG_VENDING_DEPOSIT,
    DIALOG_VENDING_EDITPROD,
    DIALOG_VENDING_PRICESET,
    DIALOG_VENDING_RESTOCK,
    //workshop
    DIALOG_MY_WS,
    WS_MENU,
    WS_SETNAME,
    WS_SETOWNER,
    WS_SETEMPLOYE,
    WS_SETEMPLOYEE,
    WS_SETOWNERCONFIRM,
    WS_SETMEMBER,
    WS_SETMEMBERE,
    WS_MONEY,
    WS_WITHDRAWMONEY,
    WS_DEPOSITMONEY,
    WS_COMPONENT,
    WS_COMPONENT2,
    WS_MATERIAL,
    WS_MATERIAL2,
    //tes
    DIALOG_NGENTOD,
    DIALOG_CHANGELOGS,
    //---[ DIALOG PUBLIC ]---
    DIALOG_UNUSED,
    DIALOG_VERIFIKASI,
    DIALOG_MAKE_CHAR,
    DIALOG_CHARLIST,
    DIALOG_LOGIN,
    DIALOG_REGISTER,
    DIALOG_AGE,
    DIALOG_GENDER,
    DIALOG_EMAIL,
    DIALOG_PASSWORD,
    DIALOG_STATS,
    DIALOG_SETTINGS,
    DIALOG_HBEMODE,
    DIALOG_TDMODE,
    DIALOG_CHANGEAGE,
    //-----------------------
    DIALOG_GOLDSHOP,
    DIALOG_GOLDNAME,
    //---[ DIALOG BISNIS ]---
    DIALOG_SELL_BISNISS,
    DIALOG_SELL_BISNIS,
    DIALOG_SEALED,
    DIALOG_UNSEALED,
    DIALOG_MY_BISNIS,
    BISNIS_MENU,
    BISNIS_INFO,
    BISNIS_NAME,
    BISNIS_VAULT,
    BISNIS_WITHDRAW,
    BISNIS_DEPOSIT,
    BISNIS_BUYPROD,
    BISNIS_EDITPROD,
    BISNIS_PRICESET,
    BISNIS_SONG,
    BISNIS_PH,
    //--[Dialog Graffity]--
    DIALOG_WELCOME,
    DIALOG_SELECT,
    DIALOG_INPUTGRAFF,
    DIALOG_COLOR,
    DIALOG_HAPPY,
    DIALOG_LIST,
    BUY_SPRAYCAN,
    DIALOG_GOMENU,
    DIALOG_GDOBJECT,
    //---[ DIALOG HOUSE ]---
    DIALOG_SELL_HOUSES,
    DIALOG_SELL_HOUSE,
    DIALOG_MY_HOUSES,
    HOUSE_INFO,
    HOUSE_STORAGE,
    HOUSE_WEAPONS,
    HOUSE_MONEY,
    HOUSE_WITHDRAWMONEY,
    HOUSE_DEPOSITMONEY,
    //---[ DIALOG PRIVATE VEHICLE ]---
    DIALOG_FINDVEH,
    DIALOG_TRACKVEH,
    DIALOG_GOTOVEH,
    DIALOG_GETVEH,
    DIALOG_DELETEVEH,
    DIALOG_BUYPV,
    DIALOG_BUYVIPPV,
    DIALOG_BUYPLATE,
    DIALOG_BUYPVCP,
    DIALOG_BUYPVCP_BIKES,
    DIALOG_BUYPVCP_CARS,
    DIALOG_BUYPVCP_UCARS,
    DIALOG_BUYPVCP_JOBCARS,
    DIALOG_BUYPVCP_VIPCARS,
    DIALOG_BUYPVCP_CONFIRM,
    DIALOG_BUYPVS_CONFIRM,
    DIALOG_BUYBOAT_CONFIRM,
    DIALOG_BUYPVCP_VIPCONFIRM,
    DIALOG_RENT_JOBCARS,
    DIALOG_RENT_JOBCARSCONFIRM,
    //job
    LIST_JOB,
    //---[ DIALOG TOYS ]---
    //Vehicle Toys
    DIALOG_VTOY,
    DIALOG_VTOYBUY,
    DIALOG_VTOYEDIT,
    DIALOG_VTOYPOSX,
    DIALOG_VTOYPOSY,
    DIALOG_VTOYPOSZ,
    DIALOG_VTOYPOSRX,
    DIALOG_VTOYPOSRY,
    DIALOG_VTOYPOSRZ,
    VSELECT_POS,
    VTOYSET_VALUE,
    VTOYSET_COLOUR,
    VTOY_ACCEPT,
    VENTOYSET_VALUE,
    VENSELECT_POS,
    //Player Toys
    DIALOG_TOY,
    DIALOG_TOYEDIT,
    DIALOG_TOYPOSISI,
    DIALOG_TOYPOSISIBUY,
    DIALOG_TOYBUY,
    DIALOG_TOYVIP,
    DIALOG_TOYPOSX,
    DIALOG_TOYPOSY,
    DIALOG_TOYPOSZ,
    DIALOG_TOYPOSRX,
    DIALOG_TOYPOSRY,
    DIALOG_TOYPOSRZ,
    DIALOG_SCALEX,
    DIALOG_SCALEY,
    DIALOG_SCALEZ,
    TSELECT_POS,
    TOYSET_VALUE,
    //butcher
    D_WORK,
    D_WORK_INFO,
    //---[ DIALOG PLAYER ]---
    DIALOG_HELP,
    DIALOG_JOBHELP,
    DIALOG_GPS,
    DIALOG_GPS_FACTION,
    DIALOG_GPS_PROPERTY,
    DIALOG_GPS_PUBLIC,
    DIALOG_GPS_DEALERSHIP,
    DIALOG_GPS_PUBLISH,
    DIALOG_TRACKWS,
    DIALOG_TRACKPARK,
    DIALOG_FIND_DEALER,
    DIALOG_FIND_BISNIS,
    DIALOG_FIND_ATM,
    DIALOG_FIND_TREES,
    DIALOG_GPS_JOB,
    DIALOG_PAY,
    DIALOG_PAYBILL,
    DIALOG_TAKEHAULING,
    DIALOG_DYNAMICLIST,
    //---[GARKOT]---//
    DIALOG_PICKUPVEH,
    //---[ DIALOG WEAPONS ]---
    DIALOG_EDITBONE,
    //---[ DIALOG FAMILY ]---
    FAMILY_SAFE,
    FAMILY_STORAGE,
    FAMILY_WEAPONS,
    FAMILY_MARIJUANA,
    FAMILY_WITHDRAWMARIJUANA,
    FAMILY_DEPOSITMARIJUANA,
    FAMILY_COMPONENT,
    FAMILY_WITHDRAWCOMPONENT,
    FAMILY_DEPOSITCOMPONENT,
    FAMILY_MATERIAL,
    FAMILY_WITHDRAWMATERIAL,
    FAMILY_DEPOSITMATERIAL,
    FAMILY_MONEY,
    FAMILY_WITHDRAWMONEY,
    FAMILY_DEPOSITMONEY,
    FAMILY_INFO,
    //---[ DIALOG OWN FARM ]---
    FARM_STORAGE,
    FARM_INFO,
    FARM_POTATO,
    FARM_WHEAT,
    FARM_ORANGE,
    FARM_MONEY,
    FARM_DEPOSITPOTATO,
    FARM_WITHDRAWPOTATO,
    FARM_DEPOSITWHEAT,
    FARM_WITHDRAWWHEAT,
    FARM_DEPOSITORANGE,
    FARM_WITHDRAWORANGE,
    FARM_DEPOSITMONEY,
    FARM_WITHDRAWMONEY,
    //---[ DIALOG FACTION ]---
    DIALOG_LOCKERSAPD,
    DIALOG_WEAPONSAPD,
    DIALOG_LOCKERSAGS,
    DIALOG_WEAPONSAGS,
    DIALOG_LOCKERSAMD,
    DIALOG_WEAPONSAMD,
    DIALOG_LOCKERSANEW,
    DIALOG_WEAPONSANEW,
    DIALOG_LOCKERPEDAGANG,
    DIALOG_GUDANGPEDAGANG,

    DIALOG_LOCKERVIP,
    //---[ DIALOG JOB ]---
    //MECH
    DIALOG_SERVICE,
    DIALOG_SERVICE_COLOR,
    DIALOG_SERVICE_COLOR2,
    DIALOG_SERVICE_PAINTJOB,
    DIALOG_SERVICE_WHEELS,
    DIALOG_SERVICE_SPOILER,
    DIALOG_SERVICE_HOODS,
    DIALOG_SERVICE_VENTS,
    DIALOG_SERVICE_LIGHTS,
    DIALOG_SERVICE_EXHAUSTS,
    DIALOG_SERVICE_FRONT_BUMPERS,
    DIALOG_SERVICE_REAR_BUMPERS,
    DIALOG_SERVICE_ROOFS,
    DIALOG_SERVICE_SIDE_SKIRTS,
    DIALOG_SERVICE_BULLBARS,
    DIALOG_SERVICE_NEON,
    //Trucker
    DIALOG_HAULING,
    DIALOG_RESTOCK,
    DIALOG_CONTAINER,

    //ARMS Dealer
    DIALOG_ARMS_GUN,

    //Farmer job
    DIALOG_PLANT,
    DIALOG_EDIT_PRICE,
    DIALOG_EDIT_PRICE1,
    DIALOG_EDIT_PRICE2,
    DIALOG_EDIT_PRICE3,
    DIALOG_EDIT_PRICE4,
    DIALOG_OFFER,
    //----[ Items ]-----
    DIALOG_MATERIAL,
    DIALOG_COMPONENT,
    DIALOG_DRUGS,
    DIALOG_FOOD,
    DIALOG_FOOD_BUY,
    DIALOG_SEED_BUY,
    DIALOG_PRODUCT,
    DIALOG_GASOIL,
    DIALOG_APOTEK,
    //Bank
    DIALOG_ATM,
    DIALOG_ATMWITHDRAW,
    DIALOG_BANK,
    DIALOG_BANKDEPOSIT,
    DIALOG_BANKWITHDRAW,
    DIALOG_BANKREKENING,
    DIALOG_BANKTRANSFER,
    DIALOG_BANKCONFIRM,
    DIALOG_BANKSUKSES,
    //ask
    DIALOG_ASKS,

    //reports
    DIALOG_REPORTS,
    DIALOG_SALARY,
    DIALOG_PAYCHECK,

    //Sidejob
    DIALOG_TRASH,
    DIALOG_PIZZA,
    DIALOG_SWEEPER,
    DIALOG_BUS,
    DIALOG_FORKLIFT,
    //hauling tr
    //DIALOG_CHAULINGTR,
    //DIALOG_BUYTRUCK_CONFIRM,
    //DIALOG_HAULINGTR,

    DIALOG_PB,

    //gym
    DIALOG_FSTYLE,
    DIALOG_GMENU,
    //mods
    DIALOG_MMENU,
    //box
    DIALOG_TDC,
    DIALOG_TDC_PLACE,

    //event
    DIALOG_TDM,

    //Character Story
    pCS,

    //veh control
    DIALOG_VC,
    //startjob
    DIALOG_WORK,
    //Phone
    DIALOG_ENTERNUM,
    NEW_CONTACT,
    CONTACT_INFO,
    CONTACT,
    DIAL_NUMBER,
    TEXT_MESSAGE,
    SEND_TEXT,
    SHARE_LOC,
    MY_PHONE,
    TWEET_APP,
    WHATSAPP_APP,
    TWEET_SIGNUP,
    TWEET_CHANGENAME,
    TWEET_ACCEPT_CHANGENAME,
    DIALOG_TWEETMODE,
    PHONE_NOTIF,
    PHONE_APP,
    PHONE_APP1,
    //trunk
    TRUNK_STORAGE,
    TRUNK_WEAPONS,
    TRUNK_MONEY,
    TRUNK_MARIJUANA,
    TRUNK_COMP,
    TRUNK_MATS,
    TRUNK_WITHDRAWMONEY,
    TRUNK_DEPOSITMONEY,
    TRUNK_WITHDRAWMARIJUANA,
    TRUNK_DEPOSITMARIJUANA,
    TRUNK_WITHDRAWCOMP,
    TRUNK_DEPOSITCOMP,
    TRUNK_WITHDRAWMATS,
    TRUNK_DEPOSITMATS,
    //mech
    DIALOG_MECH_LEVEL,

    //MDC
    DIALOG_TRACK,
    DIALOG_TRACK_PH,

    DIALOG_INFO_BIS,
    DIALOG_INFO_HOUSE,

    //bb
    DIALOG_BOOMBOX,
    DIALOG_BOOMBOX1,
}

// Player data
enum E_PLAYERS
{
    pID,
    pVerfi[64],
    pVerifikasi,
    pUCP[22],
    pExtraChar,
    pTempPass[64],
    pChar,
    pName[MAX_PLAYER_NAME],
    pAdminname[MAX_PLAYER_NAME],
    pIP[16],
    pPassword[65],
    pSalt[17],
    pEmail[40],
    pAdmin,
    pHelper,
    pLevel,
    pLevelUp,
    pVip,
    pVipTime,
    // Roleplay Booster
    pBooster,
    pBoostTime,
    pGold,
    pRegDate[50],
    pLastLogin[50],
    pMoney,
    pBankMoney,
    pBankRek,
    //phone
    pContact,
    pPhone,
    pPhoneOff,
    pPhoneCredit,
    pPhoneBook,
    pSMS,
    pCall,
    pCallTime,
    // WS
    pMenuType,
    pInWs,
    pTransferWS,
    //--
    pWT,
    pHours,
    pMinutes,
    pSeconds,
    pPaycheck,
    pSkin,
    pFacSkin,
    pGender,
    pAge[50],
    pInDoor,
    pInHouse,
    pInBiz,
    pInVending,
    pInDealer,
    Float:
        pPosX,
        Float:
        pPosY,
        Float:
        pPosZ,
        Float:
        pPosA,
        pInt,
        pWorld,
        Float:pHealth,
        Float:pArmour,
        pHunger,
        pBladder,
        pEnergy,
        pHungerTime,
        pEnergyTime,
        pBladderTime,
        pSick,
        pSickTime,
        pHospital,
        pHospitalTime,
        pInjured,
        pOnDuty,
        pOnDutyTime,
        pFaction,
        pFactionRank,
        pFactionLead,
        pTazer,
        pBroadcast,
        pNewsGuest,
        pFarm,
        pFarmRank,
        pFamily,
        pFamilyRank,
        pJail,
        pJailTime,
        pArrest,
        pArrestTime,
        pWarn,
        pJob,
        pJob2,
        pExitJob,
        pMedicine,
        pMedkit,
        pMask,
        pFightStyle,
        pGymVip,
        pFitnessTimer,
        pFitnessType,
        pBorax,
        pGetBorax,
        pPaketBorax,
        pProsesBorax,
        pRedMoney,
        pSeatBelt,
        pHelmet,
        pSnack,
        pFlashlight,
        pUsedFlashlight,
        pSprunk,
        pMineral,
        pAyam,
        pBurger,
        pNasi,
        pTrash,
        pBerry,
        pGas,
        pBandage,
        pGPS,
        pMaterial,
        pComponent,
        pFood,
        pFrozenPizza,
        pSeed,
        pPotato,
        pWheat,
        pOrange,
        pPrice1,
        pPrice2,
        pPrice3,
        pPrice4,
        pMarijuana,
        pBlindfold,
        pArmor,
        pPlant,
        pPlantTime,
        pFishTool,
        pWorm,
        pFish,
        pInFish,
        pIDCard,
        pIDCardTime,
        pLicBiz,
        pLicBizTime,
        pSkck,
        pSkckTime,
        pPenebangs,
        pPenebangsTime,
        pBpjs,
        pBpjsTime,
        pSpack,
        pDriveLic,
        pDriveLicTime,
        pSekolahSim,
        pRobb,
        pBoatLic,
        pBoatLicTime,
        pFlyLic,
        pFlyLicTime,
        pGuns[13],
        pAmmo[13],
        pWeapon,
        pJetpack,
        pBoombox,
        //garkot
        pPark,
        pLoc,
        //Not Save
        Cache:Cache_ID,
        bool:
        IsLoggedIn,
        LoginAttempts,
        LoginTimer,
        pSpawned,
        pAdminDuty,
        pFreezeTimer,
        pFreeze,
        pMaskID,
        pMaskOn,
        pSPY,
        pTname[MAX_PLAYER_NAME],
        pTweet,
        pTogTweet,
        pToggleAtm,
        pTogPM,
        pTogLog,
        pTogAds,
        pTogWT,
        pUsingWT,
        pClickMap,
        // Suspect
        pSuspectTimer,
        pSuspect,
        Text3D:pAdoTag,
        Text3D:pCatTag,
        bool:pAdoActive,
        pFlare,
        bool:pFlareActive,
        pTrackCar,
        pBuyPvModel,
        pTrackHouse,
        pTrackBisnis,
        pFacInvite,
        pFacOffer,
        pFamInvite,
        pFamOffer,
        pFarmInvite,
        pFarmOffer,
        pFindEms,
        pCuffed,
        toySelected,
        venSelected,
        TEditStatus,
        bool:PurchasedToy,
        pEditingItem,
        pProductModify,
        pEditingVendingItem,
        pVendingProductModify,
        pCurrSeconds,
        pCurrMinutes,
        pCurrHours,
        pSpec,
        playerSpectated,
        pInspectOffer,
        Float:pBodyCondition[6],
        pFriskOffer,
        pDragged,
        pDraggedBy,
        pDragTimer,
        pHBEMode,
        pTDMode,
        pHelmetOn,
        pReportTime,
        pAskTime,
        //Player Progress Bar
        PlayerBar:fuelbar,
        PlayerBar:damagebar,
        PlayerBar:hungrybar,
        PlayerBar:energybar,
        PlayerBar:BarHp,
        PlayerBar:BarArmour,
        PlayerBar:bladdybar,
        PlayerBar:spfuelbar,
        PlayerBar:spdamagebar,
        PlayerBar:sphungrybar,
        PlayerBar:spenergybar,
        PlayerBar:spbladdybar,
        PlayerBar:activitybar,
        pProducting,
        pCooking,
        pArmsDealer,
        pMechanic,
        pActivity,
        pActivityTime,
        //Delay sidejob
        pSweeperTime,
        pBusTime,
        pForkliftTime,
        pPizzaTime,
        //Jobs
        pSideJob,
        pSideJobTime,
        pJobTime,
        pGetJob,
        pGetJob2,
        pTaxiDuty,
        pTaxiTime,
        pFare,
        pFareTimer,
        pTotalFare,
        Float:pFareOldX,
        Float:pFareOldY,
        Float:pFareOldZ,
        Float:pFareNewX,
        Float:pFareNewY,
        Float:pFareNewZ,
        pMechDuty,
        pMechVeh,
        pMechColor1,
        pMechColor2,
        //ATM
        EditingATMID,
        //Graffity
        EditingGraffity,
        // Vending
        EditingVending,
        //Vehicle Toys
        EditingVtoys,
        //Limit Speed
        Float:pLimitSpeed,
        LimitSpeedTimer,
        pLsVehicle,
        //lumber job
        EditingTreeID,
        CuttingTreeID,
        bool:CarryingLumber,
        //Berry Farmers
        EditingBerryID,
        HarvestBerryID,
        //Miner job
        EditingOreID,
        MiningOreID,
        CarryingLog,
        LoadingPoint,
        //production
        CarryProduct,
        //trucker
        pMission,
        pDealerMission,
        pHauling,
        pRestock,
        //Farmer
        pHarvest,
        pHarvestID,
        pOffer,
        //Smuggler
        pSmugglerTimer,
        pPacket,
        //Bank
        pTransfer,
        pTransferRek,
        pTransferName[128],
        //Gas Station
        pFill,
        pFillTime,
        pFillPrice,
        //Gate
        gEditID,
        gEdit,
        //Workshop
        pWsEmplooye[4],
        pWsVeh,
        pWorkshop,
        //auto rp
        pSavedRp[70],
        //Skill
        pTruckSkill,
        pMechSkill,
        pSmuggSkill,
        //Vehicle Toys
        EditStatus,
        VehicleID
        //
    };
new pData[MAX_PLAYERS][E_PLAYERS];
// MySQL connection handle
new MySQL:
g_SQL;
new g_MysqlRaceCheck[MAX_PLAYERS];
new online;
new togtextdraws[MAX_PLAYERS];

//Model Selection
new SpawnMale = mS_INVALID_LISTID,
    SpawnFemale = mS_INVALID_LISTID,
    MaleSkins = mS_INVALID_LISTID,
    FemaleSkins = mS_INVALID_LISTID,
    VIPMaleSkins = mS_INVALID_LISTID,
    VIPFemaleSkins = mS_INVALID_LISTID,
    SAPDMale = mS_INVALID_LISTID,
    SAPDFemale = mS_INVALID_LISTID,
    SAPDWar = mS_INVALID_LISTID,
    SAGSMale = mS_INVALID_LISTID,
    SAGSFemale = mS_INVALID_LISTID,
    SAMDMale = mS_INVALID_LISTID,
    SAMDFemale = mS_INVALID_LISTID,
    SANEWMale = mS_INVALID_LISTID,
    SANEWFemale = mS_INVALID_LISTID,
    toyslist = mS_INVALID_LISTID,
    rentjoblist = mS_INVALID_LISTID,
    sportcar = mS_INVALID_LISTID,
    boatlist = mS_INVALID_LISTID,
    viptoyslist = mS_INVALID_LISTID,
    vtoylist = mS_INVALID_LISTID;

new g_ServerRestart;
new g_ServerBadai;
new g_RestartTime;
new g_BadaiTime;
new WorldWeather = 24;
stock const g_aWeatherRotations[] =
{
    14, 1, 7, 3, 5, 12, 9, 8, 15
};

// DISCORD BOT
new DCC_Channel:g_discord_server;
new DCC_Channel:g_discord_logServer;
new DCC_Channel:g_discord_note;
// Faction Vehicle
#define VEHICLE_RESPAWN 7200

new SAGSVehicle[30];

new SAGSLobbyBtn[2],
    SAGSLobbyDoor;

IsGovCar(carid)
{
    for (new v = 0; v < sizeof(SAGSVehicle); v++)
    {
        if (carid == SAGSVehicle[v]) return 1;
    }
    return 1;
}
main()
{
    print("Test Script");
    //
    SetTimer("WeatherRotator", 400000, true);
    // SetTimerEx("WeatherRotator",300000, true, "d", playerid);
}

#include "Module\Native.pwn"
#include "UCP.pwn"
#include "Module\Dialog.pwn"
#include "Module\Report.pwn"
#include "Module\Vehicle.pwn"
#include "Module\Door.pwn"
#include "Module\Server.pwn"
#include "Module\DynamicLocker.pwn"
#include "Module\CMD\Admin.pwn"
#include "Module\CMD\Player.pwn"
#include "Module\CMD\Faction.pwn"
#include "Module\Function.pwn"

public OnGameModeInit()
{
new MySQLOpt:
    option_id = mysql_init_options();

    mysql_set_option(option_id, AUTO_RECONNECT, true);

    g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);
    if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
    {
        print("MySQL connection failed. Server is shutting down.");
        SendRconCommand("");
        return 1;
    }
    print("MySQL connection is successful.");

    mysql_tquery(g_SQL, "SELECT * FROM `doors`", "LoadDoors");
    mysql_tquery(g_SQL, "SELECT * FROM `lockers`", "LoadLocker");

    SpawnMale = LoadModelSelectionMenu("spawnmale.txt");
    SpawnFemale = LoadModelSelectionMenu("spawnfemale.txt");

    CreatePublicTextDraws();
    CreateServerPoint();

    SetTimer("PlayerCheck", 1000, true);
    SetGameModeText(TEXT_GAMEMODE);
    new rcon[50];
    format(rcon, sizeof(rcon), "hostname %s", SERVER_NAME);
    SendRconCommand(rcon);

    EnableStuntBonusForAll(0);
    ManualVehicleEngineAndLights();
    DisableInteriorEnterExits();
    WeatherRotator();
    print("Gamemode Ready to Play!");

    g_discord_server = DCC_FindChannelById("1089051513671917598");
    g_discord_logServer = DCC_FindChannelById("1081536963603087390");
    g_discord_note = DCC_FindChannelById("1085910215515439185");

    SAGSLobbyBtn[0] = CreateButton(1388.987670, -25.291969, 1001.358520, 180.000000);
    SAGSLobbyBtn[1] = CreateButton(1391.275756, -25.481920, 1001.358520, 0.000000);
    SAGSLobbyDoor = CreateDynamicObject(1569, 1389.375000, -25.387500, 999.978210, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);

    printf("[Object] >>  Number of Dynamic object loaded: %d", CountDynamicObjects());
    new DCC_Channel:channel, DCC_Embed:logss;
    new y, m, d, timestamp[200];
    getdate(y, m, d);
    channel = DCC_FindChannelById("1088678869390856203"); //
    format(timestamp, sizeof(timestamp), "%02i%02i%02i", y, m, d);
    logss = DCC_CreateEmbed("Jateng Pride Roleplay");
    DCC_SetEmbedTitle(logss, "JATENG PRIDE ROLEPLAY");
    DCC_SetEmbedTimestamp(logss, timestamp);
    DCC_SetEmbedColor(logss, 0x99D5C9);
    DCC_SetEmbedFooter(logss, "JATENG PRIDE ROLEPLAY", "");
    new string1[5000], string2[50000];
    format(string1, sizeof(string1), "Server Kembali mengudara @everyone");
    format(string2, sizeof(string2), "jika ada masalah /report admin\nSmoega aman terkendali.@everyone");
    DCC_AddEmbedField(logss, "KOTA SUDAH MENGUDARA KEMBALI✈", string2, true);
    DCC_SendChannelEmbedMessage(channel, logss);


    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i)) continue;
        OnPlayerConnect(i);
    }
    return 1;
}

public OnGameModeExit()
{
    print("------------------[Auto Restart]--------------");
    new count = 0, count1 = 0, user = 0;

    foreach (new i : Player)
    {
        user++;
        UpdatePlayerData(i);
    }
    printf("[Database] User Saved: %d", user);
    print("------------------[Auto Restart]--------------");
    SendClientMessageToAll(COLOR_RED, "{FFFFFF}[!]{D88C9A}Server is Maintenance/Restart.{00FFFF} >> RISKI BOTS");

    mysql_close(g_SQL);
    new DCC_Channel:channel, DCC_Embed:loll;
    new y, m, d, timestamp[200];
    getdate(y, m, d);
    channel = DCC_FindChannelById("1088678869390856203");
    format(timestamp, sizeof(timestamp), "%02i%02i%02i", y, m, d);
    loll = DCC_CreateEmbed("Jateng Pride Roleplay");
    DCC_SetEmbedTitle(loll, "JATENG PRIDE ROLEPLAY");
    DCC_SetEmbedTimestamp(loll, timestamp);
    DCC_SetEmbedColor(loll, 0xFF0000);
    DCC_SetEmbedFooter(loll, "JATENG PRIDE ROLEPLAY", "");
    new string1[5000];
    format(string1, sizeof(string1), "Warga diharap berteduh dan bersiap mencari tempat aman terimkasih @everyone");
    DCC_AddEmbedField(loll, "KOTA SEDANG MENGALAMI BADAI", string1, true);
    DCC_SendChannelEmbedMessage(channel, loll);
    return 1;
}

public OnPlayerConnect(playerid)
{
    new hour, minute;
    gettime(hour, minute);
    online++;
    togtextdraws[playerid] = 0;
    new PlayerIP[16];
    g_MysqlRaceCheck[playerid]++;

    ResetVariables(playerid);
    CreatePlayerTextDraws(playerid);

    GetPlayerName(playerid, pData[playerid][pName], MAX_PLAYER_NAME);
    GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
    pData[playerid][pIP] = PlayerIP;
    new playerip[320], extraid;
    new kota[1401], negara[1401];
    GetPlayerCity(extraid, kota, sizeof(kota));
    GetPlayerCountry(extraid, negara, sizeof(negara));
    GetPlayerIp(extraid, playerip, sizeof(playerip));
    format(pData[extraid][pIP], 32, "%s", playerip);

    SetTimerEx("SafeLogin", 5000, 0, "i", playerid);

    /*new query[103];
    mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", pData[playerid][pName]);
    mysql_pquery(g_SQL, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);*/
    if (!IsValidRoleplayName(GetName(playerid)))
    {
        CheckUCP(playerid);
    }
    else
    {
        new query[103];
        mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `players` WHERE `username` = '%e' LIMIT 1", GetName(playerid));
        mysql_pquery(g_SQL, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
    }
    SetPlayerColor(playerid, COLOR_WHITE);
    /*PlayerTextDrawShow(playerid, LoginTD[playerid][0]);
    PlayerTextDrawShow(playerid, LoginTD[playerid][1]);
    PlayerTextDrawShow(playerid, LoginTD[playerid][2]);
    PlayerTextDrawShow(playerid, LoginTD[playerid][3]);
    PlayerTextDrawShow(playerid, LoginTD[playerid][4]);*/

    if (g_ServerRestart || g_ServerBadai)
    {
        TextDrawShowForPlayer(playerid, gServerTextdraws[1]);
    }

    foreach (new ii : Player)
    {
        if (pData[ii][pTogLog] == 0)
        {
            SendClientMessageEx(ii, -1, "{FF0000}[JOIN]"YELLOW_E"%s[%d] telah join ke dalam server.{00FFFF}(%s,%s)", pData[playerid][pName], playerid, kota, negara);
        }
    }

    // tmp
    // Remove insu
    RemoveBuildingForPlayer(playerid, 1490, 2399.409, -1552.030, 28.750, 0.250);
    RemoveBuildingForPlayer(playerid, 17862, 2458.379, -1532.439, 22.992, 0.250);
    RemoveBuildingForPlayer(playerid, 17868, 2458.379, -1532.439, 22.992, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 2333.159, -1428.930, 23.195, 0.250);
    RemoveBuildingForPlayer(playerid, 760, 2444.679, -1542.780, 23.203, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2445.800, -1543.260, 21.804, 0.250);
    RemoveBuildingForPlayer(playerid, 17851, 2457.020, -1494.719, 37.492, 0.250);
    RemoveBuildingForPlayer(playerid, 1525, 2462.270, -1541.410, 25.421, 0.250);
    RemoveBuildingForPlayer(playerid, 760, 2463.729, -1542.780, 23.203, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 2457.020, -1542.699, 21.804, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2474.100, -1544.260, 26.359, 0.250);
    RemoveBuildingForPlayer(playerid, 17974, 2467.459, -1538.250, 27.601, 0.250);
    RemoveBuildingForPlayer(playerid, 17863, 2467.459, -1538.250, 27.601, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 2442.989, -1559.079, 23.210, 0.250);
    RemoveBuildingForPlayer(playerid, 760, 2446.159, -1562.199, 23.335, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 2451.659, -1561.550, 23.312, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2459.270, -1558.729, 26.203, 0.250);
    RemoveBuildingForPlayer(playerid, 760, 2467.800, -1562.199, 23.335, 0.250);
    RemoveBuildingForPlayer(playerid, 616, 2469.409, -1562.130, 22.562, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 2495.270, -1553.079, 22.867, 0.250);
    RemoveBuildingForPlayer(playerid, 760, 2495.159, -1549.750, 23.335, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 2495.270, -1538.010, 22.867, 0.250);
    RemoveBuildingForPlayer(playerid, 760, 2494.010, -1529.219, 23.335, 0.250);
    RemoveBuildingForPlayer(playerid, 673, 2495.270, -1522.800, 22.867, 0.250);
    RemoveBuildingForPlayer(playerid, 760, 2494.209, -1521.609, 23.335, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 2491.830, -1516.510, 23.210, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2482.929, -1530.540, 26.304, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2474.629, -1518.770, 26.304, 0.250);
    RemoveBuildingForPlayer(playerid, 1267, 2445.199, -1519.390, 37.054, 0.250);
    RemoveBuildingForPlayer(playerid, 1261, 2445.199, -1519.390, 37.054, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2493.229, -1508.959, 26.304, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2459.250, -1508.959, 26.304, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2435.949, -1515.560, 26.226, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2435.949, -1542.839, 26.226, 0.250);

    // Dealer
    RemoveBuildingForPlayer(playerid, 5762, 1315.369, -887.468, 41.703, 0.250);
    RemoveBuildingForPlayer(playerid, 5852, 1315.369, -887.468, 41.703, 0.250);
    RemoveBuildingForPlayer(playerid, 1522, 1314.729, -897.265, 38.468, 0.250);

    // Burger
    RemovePlayerFromVehicle(playerid, 627, 1209.900, -1482.380, 14.140, 0.250);
    RemoveBuildingForPlayer(playerid, 627, 1230.130, -1482.380, 14.140, 0.250);
    RemoveBuildingForPlayer(playerid, 627, 1206.479, -1465.160, 14.140, 0.250);
    RemoveBuildingForPlayer(playerid, 627, 1206.479, -1454.119, 14.140, 0.250);
    RemoveBuildingForPlayer(playerid, 627, 1206.479, -1444.849, 14.140, 0.250);
    RemoveBuildingForPlayer(playerid, 627, 1206.479, -1433.810, 14.140, 0.250);
    RemoveBuildingForPlayer(playerid, 627, 1230.130, -1416.569, 14.140, 0.250);
    RemoveBuildingForPlayer(playerid, 627, 1209.900, -1416.569, 14.140, 0.250);
    RemoveBuildingForPlayer(playerid, 6052, 1247.910, -1429.969, 15.125, 0.250);
    RemoveBuildingForPlayer(playerid, 6068, 1247.910, -1429.969, 15.125, 0.250);

    // BENGKEL
    RemoveBuildingForPlayer(playerid, 3625, 1961.449, -25216.169, 14.984, 0.250);
    RemoveBuildingForPlayer(playerid, 3769, 1961.449, -2216.169, 14.984, 0.250);
    RemoveBuildingForPlayer(playerid, 1412, 1965.170, -2227.409, 13.757, 0.250);
    RemoveBuildingForPlayer(playerid, 1412, 1959.900, -2227.449, 13.726, 0.250);
    RemoveBuildingForPlayer(playerid, 3664, 1960.699, -2236.429, 19.281, 0.250);
    RemoveBuildingForPlayer(playerid, 1412, 1970.449, -2227.409, 13.757, 0.250);
    RemoveBuildingForPlayer(playerid, 1412, 1975.729, -2227.409, 13.757, 0.250);
    RemoveBuildingForPlayer(playerid, 1412, 1981.000, -2227.409, 13.757, 0.250);
    RemoveBuildingForPlayer(playerid, 1412, 1986.280, -2227.409, 13.757, 0.250);
    RemoveBuildingForPlayer(playerid, 1412, 1991.550, -2227.409, 13.757, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 1983.800, -2224.159, 12.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1215, 1983.859, -2281.709, 13.062, 0.250);
    RemoveBuildingForPlayer(playerid, 1215, 1980.920, -2355.209, 13.062, 0.250);

    new string[128];
    format(string, sizeof(string), "PLAYER ID: %d", playerid);
    new DCC_Embed:gatau;
    new str[526], strk[526];
    format(str, sizeof(str), "%s", GetPlayerNameEx(playerid));
    format(strk, sizeof(strk), "%d/%d", online, GetMaxPlayers());
    gatau = DCC_CreateEmbed("JATENG PRIDE ROLEPLAY", "Player Connect", "", "", 0x00FF00, "Join us @jatengpride.xyz", "", "", "");
    DCC_AddEmbedField(gatau, str, string, true);
    DCC_AddEmbedField(gatau, "Current Player", strk, true);
    DCC_SendChannelEmbedMessage(g_discord_server, gatau);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    /*(IsPlayerInAnyVehicle(playerid))
    {
        RemovePlayerFromVehicle(playerid);
    }*/
    //UpdateWeapons(playerid);
    if (IsPlayerInAnyVehicle(playerid))
    {
        RemovePlayerFromVehicle(playerid);
    }
    g_MysqlRaceCheck[playerid]++;
    online--;

    if (pData[playerid][IsLoggedIn] == true)
    {
        UpdatePlayerData(playerid);
    }
    Report_Clear(playerid);

    pData[playerid][pAdoActive] = false;

    if (cache_is_valid(pData[playerid][Cache_ID]))
    {
        cache_delete(pData[playerid][Cache_ID]);
        pData[playerid][Cache_ID] = MYSQL_INVALID_CACHE;
    }

    if (pData[playerid][LoginTimer])
    {
        KillTimer(pData[playerid][LoginTimer]);
        pData[playerid][LoginTimer] = 0;
    }

    pData[playerid][IsLoggedIn] = false;

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new reasonText[526];
    switch (reason)
    {
        case 1: reasonText = "Timeout/Crash";
        case 2: reasonText = "Quit";
        case 3: reasonText = "Kick/Ban";
        default:
            reasonText = "Force";
    }

    foreach (new ii : Player)
    {
        if (IsPlayerInRangeOfPoint(ii, 40.0, x, y, z))
        {
            switch (reason)
            {
                case 0:
                {
                    SendClientMessageEx(ii, COLOR_RED, "[SERVER]"YELLOW_E" %s(%d) telah keluar dari Server.{7FFFD4}(Exiting/ [/q])", pData[playerid][pName], playerid);
                }
                case 1:
                {
                    SendClientMessageEx(ii, COLOR_RED, "[SERVER]"YELLOW_E" %s(%d) telah keluar dari Server.{7FFFD4}(Disconnect)", pData[playerid][pName], playerid);
                }
                case 2:
                {
                    SendClientMessageEx(ii, COLOR_RED, "[SERVER]"YELLOW_E" %s(%d) telah keluar dari server.{7FFFD4}(Kick/Banned/Crash/Timeout)", pData[playerid][pName], playerid);
                }
            }
        }
    }

    new string[1280];
    format(string, sizeof(string), "ID %d", playerid);
    new str[5620], reason1[5260], strak[5260];


    format(string, sizeof(string), "Player ID %d", playerid);
    new DCC_Embed:out;
    format(str, sizeof(str), "%s", pData[playerid][pName]);
    format(reason1, sizeof(reason1), "%s", reasonText);
    format(strak, sizeof(strak), "%d/%d", online, GetMaxPlayers());
    out = DCC_CreateEmbed("JATENG PRIDE ROLEPLAY", "Player Disconnect", "", "", 0xFF0000, "Join us @jatengpriderp.xyz", "", "", "");
    DCC_AddEmbedField(out, str, string, true);
    DCC_AddEmbedField(out, "Reason", reason1, true);
    DCC_AddEmbedField(out, "Current Player", strak, true);
    DCC_SendChannelEmbedMessage(g_discord_server, out);
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    InterpolateCameraPos(playerid, 244.116943, -1844.963256, 41.799915, 821.013366, -1641.763793, 29.977857, 15000);
    InterpolateCameraLookAt(playerid, 247.605590, -1841.989990, 39.802570, 817.645996, -1645.395751, 29.292520, 15000);
    return 1;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    if (listid == SpawnMale)
    {
        if (response)
        {
            pData[playerid][pSkin] = modelid;
            SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1642.8126, -2333.4019, 13.5469, 359.7415, 0, 0, 0, 0, 0, 0);
            SpawnPlayer(playerid);
        }
    }
    if (listid == SpawnFemale)
    {
        if (response)
        {
            pData[playerid][pSkin] = modelid;
            SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1642.8126, -2333.4019, 13.5469, 359.7415, 0, 0, 0, 0, 0, 0);
            SpawnPlayer(playerid);
        }
    }
    return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerFightingStyle(playerid, pData[playerid][pFightStyle]);
    StopAudioStreamForPlayer(playerid);
    SetPlayerArmour(playerid, pData[playerid][pArmour]);
    SetPlayerInterior(playerid, pData[playerid][pInt]);
    SetPlayerVirtualWorld(playerid, pData[playerid][pWorld]);
    SetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
    SetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, 0);
    SetPlayerSpawn(playerid);

    SetPlayerSkillLevel(playerid, WEAPON_COLT45, 1);
    SetPlayerSkillLevel(playerid, WEAPON_SILENCED, 1);
    SetPlayerSkillLevel(playerid, WEAPON_DEAGLE, 1);
    SetPlayerSkillLevel(playerid, WEAPON_SHOTGUN, 1);
    SetPlayerSkillLevel(playerid, WEAPON_SAWEDOFF, 1);
    SetPlayerSkillLevel(playerid, WEAPON_SHOTGSPA, 1);
    SetPlayerSkillLevel(playerid, WEAPON_UZI, 1);
    SetPlayerSkillLevel(playerid, WEAPON_MP5, 1);
    SetPlayerSkillLevel(playerid, WEAPON_AK47, 1);
    SetPlayerSkillLevel(playerid, WEAPON_M4, 1);
    SetPlayerSkillLevel(playerid, WEAPON_TEC9, 1);
    SetPlayerSkillLevel(playerid, WEAPON_RIFLE, 1);
    SetPlayerSkillLevel(playerid, WEAPON_SNIPER, 1);

    if (pData[playerid][pAdmin] > 0 || pHelper > 0)
    {
        SendClientMessageEx(playerid, -1, "You logged in with Admin level: %s", GetStaffRank(playerid));
        SendClientMessage(playerid, -1, "1.REVISI LOCKER 2.REVISI WEATHER 3.REVISI BUTTONSAGS");
    }

    return 1;
}

SetPlayerSpawn(playerid)
{
    if (IsPlayerConnected(playerid))
    {
        if (pData[playerid][pGender] == 0)
        {
            TogglePlayerControllable(playerid, 0);
            SetPlayerHealth(playerid, 100.0);
            SetPlayerArmour(playerid, 0.0);
            SetPlayerPos(playerid, 1716.1129, -1880.0715, -10.0);
            InterpolateCameraPos(playerid, 1330.757080, -1732.019042, 23.432754, 1484.328125, -1716.528442, 23.261428, 20000);
            InterpolateCameraLookAt(playerid, 1335.739990, -1732.224365, 23.073688, 1483.968627, -1721.461547, 23.993165, 19000);
            SetPlayerVirtualWorld(playerid, 0);
            ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir (Tgl/Bulan/Tahun): 15/04/1998", "Enter", "Batal");
        }
        else
        {
            SetPlayerColor(playerid, COLOR_WHITE);
            SetTimerEx("SpawnTimer", 6000, false, "i", playerid);
        }
    }
}

function SpawnTimer(playerid)
{
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, pData[playerid][pMoney]);
    SetPlayerScore(playerid, pData[playerid][pLevel]);
    SetPlayerHealth(playerid, pData[playerid][pHealth]);
    pData[playerid][pSpawned] = 1;
    TogglePlayerControllable(playerid, 1);
    SetCameraBehindPlayer(playerid);
    ShowProgressbar(playerid, "Loaded Player Data", 6);
    // AttachPlayerToys(playerid);
    // SetWeapons(playerid);
    if (pData[playerid][pJail] > 0)
    {
        JailPlayer(playerid);
    }
    if (pData[playerid][pArrestTime] > 0)
    {
        // SetPlayerArrest(playerid, pData[playerid][pArrest]);
    }
    return 1;
}

public OnPlayerText(playerid, text[])
{
    if (isnull(text)) return 0;
    printf("[CHAT] %s(%d): %s", pData[playerid][pName], playerid, text);

    if (pData[playerid][pSpawned] == 0 && pData[playerid][IsLoggedIn] == false)
    {
        Error(playerid, "You must be spawned or logged in to use chat.");
        return 0;
    }

    text[0] = toupper(text[0]);
    if (!strcmp(text, "rpgun", true) || !strcmp(text, "gunrp", true))
    {
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s take the weapon off the belt and ready to shoot anytime.", ReturnName(playerid));
        return 1;
    }
    return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if (result == -1)
    {
        Error(playerid, "the command '/%s' not found on the server se '(/help)'.", cmd);
        return 0;
    }
    printf("[CMD]: %s(%d) has used to command '%s' (%s)", pData[playerid][pName], cmd, params);
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof(name));
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if (killerid != INVALID_PLAYER_ID)
    {
        new reasontext[526];
        switch (reason)
        {
            case 0: reasontext = "Fist";
            case 1: reasontext = "Brass Knuckles";
            case 2: reasontext = "Golf Club";
            case 3: reasontext = "Nite Stick";
            case 4: reasontext = "Knife";
            case 5: reasontext = "Baseball Bat";
            case 6: reasontext = "Shovel";
            case 7: reasontext = "Pool Cue";
            case 8: reasontext = "Katana";
            case 9: reasontext = "Chain Saw";
            case 14: reasontext = "Cane";
            case 18: reasontext = "Molotov";
            case 22..24: reasontext = "Pistol";
            case 25..27: reasontext = "Shotgun";
            case 28..34: reasontext = "SMG";
            case 49: reasontext = "VDM";
            case 50: reasontext = "Helicopter Blades";
            case 51: reasontext = "Explosion";
            case 53: reasontext = "Drowned";
            case 54: reasontext = "Splat";
            case 255: reasontext = "Suicide";
        }
        new h, m, s;
        new day, month, year;
        gettime(h, m, s);
        getdate(year, month, day);

    }
    else
    {
        new reasontext[526];
        switch (reason)
        {
            case 0: reasontext = "Fist";
            case 1: reasontext = "Brass Knuckles";
            case 2: reasontext = "Golf Club";
            case 3: reasontext = "Nite Stick";
            case 4: reasontext = "Knife";
            case 5: reasontext = "Baseball Bat";
            case 6: reasontext = "Shovel";
            case 7: reasontext = "Pool Cue";
            case 8: reasontext = "Katana";
            case 9: reasontext = "Chain Saw";
            case 14: reasontext = "Cane";
            case 18: reasontext = "Molotov";
            case 22..24: reasontext = "Pistol";
            case 25..27: reasontext = "Shotgun";
            case 28..34: reasontext = "SMG";
            case 49: reasontext = "VDM";
            case 50: reasontext = "Helicopter Blades";
            case 51: reasontext = "Explosion";
            case 53: reasontext = "Drowned";
            case 54: reasontext = "Splat";
            case 255: reasontext = "Suicide";
        }
        new h, m, s;
        new day, month, year;
        gettime(h, m, s);
        getdate(year, month, day);
        new name[MAX_PLAYER_NAME + 1];
        GetPlayerName(playerid, name, sizeof(name));
    }

    DeletePVar(playerid, "UsingSprunk");
    SetPVarInt(playerid, "GiveUptime", -1);
    pData[playerid][pSpawned] = 0;

    DisablePlayerCheckpoint(playerid);
    DisablePlayerRaceCheckpoint(playerid);
    SetPlayerColor(playerid, COLOR_WHITE);
    GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
    UpdatePlayerData(playerid);
    foreach (new ii : Player)
    {
        if (pData[ii][pAdmin] > 0)
        {
            SendDeathMessageToPlayer(ii, killerid, playerid, reason);
        }
    }
    return 1;
}


public OnPlayerPressButton(playerid, buttonid)
{
    if (buttonid == SAGSLobbyBtn[0] || buttonid == SAGSLobbyBtn[1])
    {
        if (pData[playerid][pFaction] == 2)
        {
            MoveDynamicObject(SAGSLobbyDoor, 1387.9232, -25.3887, 999.9782, 3);
            SetTimer("SAGSLobbyDoorClose", 5000, 0);
        }
        else
        {
            Error(playerid, "Access Denied!");
            return 1;
        }
    }
    return 1;
}

// tmp
CMD:tmp(playerid, params[])
{
    if (!pData[playerid][pAdmin] == 6)
        return PermissionError(playerid);

    SetPlayerPos(playerid, 389.375000, -25.387500, 999.978210);
    SendClientMessageEx(playerid, COLOR_BAN, "[TMP]: Admin "LRED_E"%s"WHITE_E" Teleported to Area Temp", pData[playerid][pAdminname]);
    return 1;
}

CMD:acars(playerid, params[])
{
    if (!pData[playerid][pAdmin] == 6)
        return PermissionError(playerid);

    if (!pData[playerid][pAdminDuty])
        return Error(playerid, "You're not On Duty Admin!");


    new vehicleid, model[32], string[300];
    vehicleid = GetPlayerVehicleID(playerid);
    format(string, sizeof(string), "VEHICLE: %d\n", vehicleid);
    SendClientMessageEx(playerid, -1, string);
    return 1;
}


CMD:setweather(playerid, params[])
{
    if (!pData[playerid][pAdmin] == 6)
        return PermissionError(playerid);

    if (!pData[playerid][pAdminDuty])
        return Error(playerid, "You're not On Duty Admin!");

    new cuaca;
    if (sscanf(params, "d", cuaca))
        return Usage(playerid, "/setweather [name]");

    SetWeather(cuaca);
    SendClientMessageEx(playerid, COLOR_RED, "[ADMIN]: %s has change weather %s", pData[playerid][pAdminname], GetWeatherName(cuaca));
    return 1;
}

CMD:gotocar(playerid, params[])
{
    if (!pData[playerid][pAdmin] == 6)
        return PermissionError(playerid);

    if (!pData[playerid][pAdminDuty])
        return Error(playerid, "You're not On Duty Admin");

    new vehicleid;

    if (sscanf(params, "d", vehicleid))
        return Usage(playerid, "/gotocar [vehicleid]");

    if (vehicleid < 1 || !IsValidVehicle(vehicleid))
        return Error(playerid, "You have specified an invalid vehicle ID");

    static Float:x, Float:y, Float:z;

    GetVehiclePos(vehicleid, x, y, z);
    SetPlayerPos(playerid, x, y - 2, z + 2);
    return 1;
}

CMD:note(playerid, params[])
{
    if (!pData[playerid][pAdmin] == 6)
        return PermissionError(playerid);

    if (!pData[playerid][pAdminDuty])
        return Error(playerid, "You're not On Duty Admin!");
    new string[100], note1[300];
    if (sscanf(params, "s[100]", string))
        return Usage(playerid, "/note [string]");

    SendClientMessageEx(playerid, 0xA6D49F, "Admin %s >> Create note %s berhasil", pData[playerid][pAdminname], params);
    format(string, sizeof(string), "%s", params);
    format(note1, sizeof(note1), "***Note***\n> %s", params);
    new DCC_Embed:note;
    note = DCC_CreateEmbed("JATENG PRIDE ROLEPLAY", "Note", "", "", 0x00FF00, "Join us @JPRP.xyz", "", "", "");
    DCC_AddEmbedField(note, "Note", string);
    DCC_SendChannelEmbedMessage(g_discord_note, note);
    DCC_SendChannelMessage(g_discord_note, note1);
    return 1;
}

CMD:tmtd(playerid, params[])
{
    PlayerTextDrawShow(playerid, FiveM1[playerid]);
    // SetTimerEx("HideTD", 3000, false, "d", playerid);
    PlayerTextDrawShow(playerid, FiveM2[playerid]);
    PlayerTextDrawShow(playerid, FiveM3[playerid]);
    PlayerTextDrawShow(playerid, FiveM4[playerid]);
    PlayerTextDrawShow(playerid, FiveM5[playerid]);
    return 1;
}

function HideTD(playerid)
{
    PlayerTextDrawHide(playerid, FiveM1[playerid]);
    return 1;
}