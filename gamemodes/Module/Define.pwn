







// MySQL configuration
#define		MYSQL_HOST 			"localhost"
#define		MYSQL_USER 			"root"
#define		MYSQL_PASSWORD 		""
#define		MYSQL_DATABASE 		"exotic"

// Message
#define SCM SendClientMessage
#define function%0(%1) forward %0(%1); public %0(%1)
#define Servers(%1,%2) SendClientMessageEx(%1, -1, ""RIKO"SERVER: "WHITE_E""%2)
#define Info(%1,%2) SendClientMessageEx(%1, -1, ""RIKO"INFO: "WHITE_E""%2)
#define Vehicle(%1,%2) SendClientMessageEx(%1, -1, ""AQUA"VEHICLE: "WHITE_E""%2)
#define Usage(%1,%2) SendClientMessage(%1, -1, ""RIKO"USAGE: "WHITE_E""%2)
#define Error(%1,%2) SendClientMessageEx(%1, -1, ""RED_E"ERROR: "WHITE_E""%2)
#define PermissionError(%0) SendClientMessage(%0, COLOR_RED, "ERROR: "WHITE"You are not allowed to use this commands!")
#define SendMe(%0,%1) \
SendClientMessageEx( % 0, COLOR_YELLOW, "»{FFFFFF} " % 1)
#define SM SendMessage

// Banneds
const BAN_MASK = (-1 << (32 - (/*this is the CIDR ip detection range [def: 26]*/26)));

// default spawn point: Las Venturas (The High Roller)
#define 	DEFAULT_POS_X 		1769.9
#define 	DEFAULT_POS_Y 		-1894.54
#define 	DEFAULT_POS_Z 		13.8526
#define 	DEFAULT_POS_A 		274.251

#define TEXT_GAMEMODE "JP:RP v.1.4.3 Vehicles"
#define SERVER_NAME   "Jateng Pride Roleplay"