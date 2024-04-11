// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <Dini>

 
// -----------------------------------------------------------------------------
 
#define MAX_PASSWORD                16          // Máximo de caracteres da senha
#define MIN_PASSWORD                4           // Mínimo de caracteres da senha
#define MAX_ATTEMPS_PASSWORD        3           // Tentativas de acertar a senha
 
#define NOVATO_SKIN_MASCULINA       60
#define NOVATO_SKIN_FEMININA        56
#define NOVATO_DINHEIRO_INICIAL     1000
 
#define NOVATO_SPAWN_X              1958.3783
#define NOVATO_SPAWN_Y              1343.1572
#define NOVATO_SPAWN_Z              15.3746
#define NOVATO_SPAWN_A              270.0000
 
// -----------------------------------------------------------------------------

#define COR_AMARELO 0xFFFF00FF
#define COR_AZUL 0x058AFFFF
#define COR_ROSA 0xFF05CDFF
#define COR_VERDE 0x33AA33AA
#define COR_BRANCO 0xFFFFFFAA
#define COR_VERMELHO 0xFFFFFFFF
#define COR_PRETO 0x000000FF
#define COR_CINZA 0x878787FF
#define COR_AZULCLARO 0x03F2FFFF
#define COR_VERDECLARO 0x03FF35FF
#define COR_ROXO 0x7D03FFFF
#define COR_ROXOCLARO 0x9A03FFFF
#define COR_LARANJA 0xFF7403FF

// -----------------------------------------------------------------------------

#define SHORT_MESSAGE_RADIUS 10.0
#define MID_MESSAGE_RADIUS 30.0
#define BIG_MESSAGE_RADIUS 50.0


// -----------------------------------------------------------------------------
 
enum
{
    DIALOG_CADASTRO,
    DIALOG_CONECTAR,
    DIALOG_SEXUALIDADE
};

enum pInfo {
    Senha[MAX_PASSWORD],
    UltimoLogin[24],
 
    Sexo,
    Fome,
    Sede,
    Admin,
    Tentativas,
 
    bool:Logado,
    bool:Spawnou,
    bool:Cadastrou,
 
    Float:pX,
    Float:pY,
    Float:pZ,
    Float:pA
};

new Player[MAX_PLAYERS][pInfo];

public OnGameModeInit() {
    // Don't use these lines if it's a filterscript
    SetGameModeText("Blank Script");
    AddPlayerClass(0, 1128.0083, -1487.1493, 22.7690, 269.1425, 0, 0, 0, 0, 0, 0);
	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll();
    return 1;
}

public OnGameModeExit() {
    return 1;
}


public OnPlayerRequestClass(playerid, classid)
{
    if(!Player[playerid][Logado])
    {
        ClearLines(playerid, 30);
        TogglePlayerSpectating(playerid, true);
        InterpolateCameraPos(playerid, 2118.152343, 2142.547363, 43.101249, 2290.450195, 2143.153808, 36.116157, 7500);
        InterpolateCameraLookAt(playerid, 2123.133056, 2142.632324, 42.669498, 2295.448242, 2143.184570, 35.975551, 7500);
 
        // ---------------------------------------------------------------------
 
        if(!dini_Exists((Arquivo(playerid))))
            ShowPlayerDialog(playerid, DIALOG_CADASTRO, DIALOG_STYLE_PASSWORD, "Cadastro", "{FFFFFF}Insira uma senha para cadastrar-se:", "Cadastrar", "Sair");
        else
            ShowPlayerDialog(playerid, DIALOG_CONECTAR, DIALOG_STYLE_PASSWORD, "Conectando", "{FFFFFF}Insira sua senha para conectar-se:", "Conectar", "Sair");
    }
    return 1;
}


public OnPlayerConnect(playerid)
{
    ResetPlayerData(playerid);
    return 1;
}
 
public OnPlayerDisconnect(playerid, reason)
{
    SavePlayerData(playerid);
    return 1;
}
 
public OnPlayerSpawn(playerid)
{
    if(Player[playerid][Spawnou])
    {
        if(Player[playerid][Cadastrou])
        {
            new string[110];
            ClearLines(playerid, 50);
            Player[playerid][Spawnou] = false;
            Player[playerid][Cadastrou] = false;
 
            format(string, sizeof(string), "{98FB98}* {FFFFFF}Bem-vindo(a) {98FB98}%s{FFFFFF}, pela primeira vez ao nosso servidor.", pName(playerid));
            SendClientMessage(playerid, -1, string);
            SendClientMessage(playerid, -1, "{98FB98}* {FFFFFF}Caso tenha dúvidas e precisar de ajuda use os comandos {98FB98}/ajuda {FFFFFF}e {98FB98}/comandos{FFFFFF}.");
        }
        else
        {
            new string[135];
            ClearLines(playerid, 50);
            Player[playerid][Spawnou] = false;
 
            format(string, sizeof(string), "{98FB98}* {FFFFFF}Olá {98FB98}%s{FFFFFF}, seu último login no servidor foi: {98FB98}%s{FFFFFF}.", pName(playerid), Player[playerid][UltimoLogin]);
            SendClientMessage(playerid, -1, string);
            SendClientMessage(playerid, -1, "{98FB98}* {FFFFFF}Caso tenha dúvidas e precisar de ajuda use os comandos {98FB98}/ajuda {FFFFFF}e {98FB98}/comandos{FFFFFF}.");
        }
    }
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason) {
    return 1;
}

public OnVehicleSpawn(vehicleid) {
    return 1;
}

public OnVehicleDeath(vehicleid, killerid) {
    return 1;
}

public OnPlayerText(playerid, text[]) {
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if (strcmp("/plp", cmdtext, true) == 0) {
        return 1;
    }
    return 1;
}


public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid) {
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate) {
    return 1;
}

public OnPlayerEnterCheckpoint(playerid) {
    return 1;
}

public OnPlayerLeaveCheckpoint(playerid) {
    return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid) {
    return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid) {
    return 1;
}

public OnRconCommand(cmd[]) {
    return 1;
}

public OnPlayerRequestSpawn(playerid) {
    return 1;
}

public OnObjectMoved(objectid) {
    return 1;
}

public OnPlayerObjectMoved(playerid, objectid) {
    return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid) {
    return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid) {
    return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid) {
    return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2) {
    return 1;
}

public OnPlayerSelectedMenuRow(playerid, row) {
    return 1;
}

public OnPlayerExitedMenu(playerid) {
    return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) {
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    return 1;
}

public OnRconLoginAttempt(ip[], password[], success) {
    return 1;
}

public OnPlayerUpdate(playerid) {
    return 1;
}

public OnPlayerStreamIn(playerid, forplayerid) {
    return 1;
}

public OnPlayerStreamOut(playerid, forplayerid) {
    return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid) {
    return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid) {
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_CADASTRO:
        {
            if(!response)
                return Kick(playerid);
 
            if(!(MIN_PASSWORD <= strlen(inputtext) <= MAX_PASSWORD))
            {
                new dialog[100];
                format(dialog, sizeof(dialog), "{FFFFFF}Insira uma senha para cadastrar-se:\n\n{FF0000}* Insira uma senha entre %i a %i caracteres.", MIN_PASSWORD, MAX_PASSWORD);
                ShowPlayerDialog(playerid, DIALOG_CADASTRO, DIALOG_STYLE_PASSWORD, "Cadastro", dialog, "Cadastrar", "Sair");
            }
            else
            {
                format(Player[playerid][Senha], MAX_PASSWORD, inputtext);
                format(Player[playerid][UltimoLogin], 24, formatTime());
 
                // -------------------------------------------------------------
 
                dini_Create(Arquivo(playerid));
                dini_Set(Arquivo(playerid), "Senha", Player[playerid][Senha]);
                dini_Set(Arquivo(playerid), "ÚltimoLogin", Player[playerid][UltimoLogin]);
                dini_Set(Arquivo(playerid), "IP", formatIP(playerid));
                dini_IntSet(Arquivo(playerid), "Dinheiro", 0);
                dini_IntSet(Arquivo(playerid), "Level", 0);
                dini_IntSet(Arquivo(playerid), "Skin", 0);
                dini_IntSet(Arquivo(playerid), "Interior", 0);
                dini_IntSet(Arquivo(playerid), "VirtualWorld", 0);
                dini_IntSet(Arquivo(playerid), "Estrelas", 0);
                dini_FloatSet(Arquivo(playerid), "Vida", 100.0);
                dini_FloatSet(Arquivo(playerid), "Colete", 0.0);
 
                dini_IntSet(Arquivo(playerid), "Sexo", Player[playerid][Sexo] = 0);
                dini_IntSet(Arquivo(playerid), "Fome", Player[playerid][Fome] = 30);
                dini_IntSet(Arquivo(playerid), "Sede", Player[playerid][Sede] = 30);
                dini_IntSet(Arquivo(playerid), "Admin", Player[playerid][Admin] = 0);
 
                dini_FloatSet(Arquivo(playerid), "X", Player[playerid][pX] = NOVATO_SPAWN_X);
                dini_FloatSet(Arquivo(playerid), "Y", Player[playerid][pY] = NOVATO_SPAWN_Y);
                dini_FloatSet(Arquivo(playerid), "Z", Player[playerid][pZ] = NOVATO_SPAWN_Z);
                dini_FloatSet(Arquivo(playerid), "A", Player[playerid][pA] = NOVATO_SPAWN_A);
 
                // -------------------------------------------------------------
 
                SendClientMessage(playerid, -1, "{98FB98}* {FFFFFF}Cadastro efetuado com sucesso.");
                ShowPlayerDialog(playerid, DIALOG_SEXUALIDADE, DIALOG_STYLE_MSGBOX, "Sexualidade", "{FFFFFF}Informe seu sexo abaixo:", "Masculino", "Feminino");
            }
        }
        case DIALOG_SEXUALIDADE:
        {
            Player[playerid][Logado] = true;
            Player[playerid][Spawnou] = true;
            Player[playerid][Cadastrou] = true;
            Player[playerid][Sexo] = (response ? 1 : 2);
 
            TogglePlayerSpectating(playerid, false);
            GivePlayerMoney(playerid, NOVATO_DINHEIRO_INICIAL);
            SendClientMessage(playerid, -1, (response ? "{98FB98}* {FFFFFF}Sexo definido como Masculino." : "{98FB98}* {FFFFFF}Sexo definido como Feminino."));
 
            SetSpawnInfo(playerid, NO_TEAM, (response ? NOVATO_SKIN_MASCULINA : NOVATO_SKIN_FEMININA), Player[playerid][pX], Player[playerid][pY], Player[playerid][pZ], Player[playerid][pA], 0, 0, 0, 0, 0, 0);
            SetCameraBehindPlayer(playerid);
            SpawnPlayer(playerid);
        }
        case DIALOG_CONECTAR:
        {
            if(!response)
                return Kick(playerid);
 
            if(!strlen(inputtext))
                return ShowPlayerDialog(playerid, DIALOG_CONECTAR, DIALOG_STYLE_PASSWORD, "Conectando", "{FFFFFF}Insira sua senha para conectar-se:", "Conectar", "Sair");
 
            format(Player[playerid][Senha], MAX_PASSWORD, dini_Get(Arquivo(playerid), "Senha"));
            format(Player[playerid][UltimoLogin], 24, dini_Get(Arquivo(playerid), "ÚltimoLogin"));
 
            if(!strcmp(Player[playerid][Senha], inputtext))
            {
                GivePlayerMoney(playerid, dini_Int(Arquivo(playerid), "Dinheiro"));
                SetPlayerScore(playerid, dini_Int(Arquivo(playerid), "Level"));
                SetPlayerSkin(playerid, dini_Int(Arquivo(playerid), "Skin"));
                SetPlayerInterior(playerid, dini_Int(Arquivo(playerid), "Interior"));
                SetPlayerVirtualWorld(playerid, dini_Int(Arquivo(playerid), "VirtualWorld"));
                SetPlayerWantedLevel(playerid, dini_Int(Arquivo(playerid), "Estrelas"));
                SetPlayerHealth(playerid, dini_Float(Arquivo(playerid), "Vida"));
                SetPlayerArmour(playerid, dini_Float(Arquivo(playerid), "Colete"));
				
 
                Player[playerid][Sexo] = dini_Int(Arquivo(playerid), "Sexo");
                Player[playerid][Fome] = dini_Int(Arquivo(playerid), "Fome");
                Player[playerid][Sede] = dini_Int(Arquivo(playerid), "Sede");
                Player[playerid][Admin] = dini_Int(Arquivo(playerid), "Admin");
 
                Player[playerid][pX] = dini_Float(Arquivo(playerid), "X");
                Player[playerid][pY] = dini_Float(Arquivo(playerid), "Y");
                Player[playerid][pZ] = dini_Float(Arquivo(playerid), "Z");
                Player[playerid][pA] = dini_Float(Arquivo(playerid), "A");
 
                Player[playerid][Logado] = true;
                Player[playerid][Spawnou] = true;
                SendClientMessage(playerid, -1, "{98FB98}* {FFFFFF}Entrada efetuada com sucesso.");
 
                SetSpawnInfo(playerid, NO_TEAM, GetPlayerSkin(playerid), Player[playerid][pX], Player[playerid][pY], Player[playerid][pZ], Player[playerid][pA], 0, 0, 0, 0, 0, 0);
                TogglePlayerSpectating(playerid, false);
                SetCameraBehindPlayer(playerid);
                SpawnPlayer(playerid);
            }
            else
            {
                Player[playerid][Tentativas]++;
                if(Player[playerid][Tentativas] >= MAX_ATTEMPS_PASSWORD) return Kick(playerid);
 
                new dialog[90];
                format(dialog, sizeof(dialog), "{FFFFFF}Insira sua senha para conectar-se:\n\n{FF0000}* Senha incorreta (%i/%i).", Player[playerid][Tentativas], MAX_ATTEMPS_PASSWORD);
                ShowPlayerDialog(playerid, DIALOG_CONECTAR, DIALOG_STYLE_PASSWORD, "Conectando", dialog, "Conectar", "Sair");
            }
        }
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source) {
    return 1;
}


// -----------------------------------------------------------------------------

CMD:command_name(playerid, params[]) {

    return 1;
}

CMD:eu(playerid, params[]) {
    new Float:x, Float:y, Float:z, msg[200];
    // pega posição player que digitou
    GetPlayerPos(playerid, x, y, z);
    format(msg, sizeof(msg), "%s %s", pName(playerid), params[0]);
    for (new id = 0; id <= MAX_PLAYERS; id++) {
        if (IsPlayerInRangeOfPoint(id, SHORT_MESSAGE_RADIUS, x, y, z)) {
            SendClientMessage(playerid, COR_ROXOCLARO, msg);
        }
    }
    return 1;
}

// -----------------------------------------------------------------------------

stock pName(playerid) {
    new nome[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nome, sizeof(nome));
    return nome;
}

stock Arquivo(playerid) {
    new filerr[100];
    format(filerr, sizeof(filerr), "Players/%s.ini", pName(playerid));
    return filerr;
}


// -----------------------------------------------------------------------------



formatIP(playerid)
{
    new ip[16];
    GetPlayerIp(playerid, ip, 16);
    return ip;
}


Float:formatHealth(playerid)
{
    new Float:health;
    GetPlayerHealth(playerid, health);
    return health;
}
 
Float:formatArmour(playerid)
{
    new Float:armour;
    GetPlayerArmour(playerid, armour);
    return armour;
}
 
formatTime()
{
    new output[24], date[3], hour[3];
    getdate(date[2], date[1], date[0]);
    gettime(hour[0], hour[1], hour[2]);
    format(output, sizeof(output), "%02d/%02d/%04d - %02d:%02d:%02d", date[0], date[1], date[2], hour[0], hour[1], hour[2]);
    return output;
}
 
ClearLines(playerid, lines)
    for(new i; i != lines; i++)
        SendClientMessage(playerid, -1, #);
 
// -----------------------------------------------------------------------------
 
SavePlayerData(playerid)
{
    if(Player[playerid][Logado])
    {
        if(dini_Exists(Arquivo(playerid)))
        {
            format(Player[playerid][UltimoLogin], 24, formatTime());
            GetPlayerPos(playerid, Player[playerid][pX], Player[playerid][pY], Player[playerid][pZ]);
            GetPlayerFacingAngle(playerid, Player[playerid][pA]);
 
            dini_Set(Arquivo(playerid), "ÚltimoLogin", Player[playerid][UltimoLogin]);
            dini_Set(Arquivo(playerid), "IP", formatIP(playerid));
            dini_IntSet(Arquivo(playerid), "Dinheiro", GetPlayerMoney(playerid));
            dini_IntSet(Arquivo(playerid), "Level", GetPlayerScore(playerid));
            dini_IntSet(Arquivo(playerid), "Skin", GetPlayerSkin(playerid));
            dini_IntSet(Arquivo(playerid), "Interior", GetPlayerInterior(playerid));
            dini_IntSet(Arquivo(playerid), "VirtualWorld", GetPlayerVirtualWorld(playerid));
            dini_IntSet(Arquivo(playerid), "Estrelas", GetPlayerWantedLevel(playerid));
            dini_FloatSet(Arquivo(playerid), "Vida", formatHealth(playerid));
            dini_FloatSet(Arquivo(playerid), "Colete", formatArmour(playerid));
 
            dini_IntSet(Arquivo(playerid), "Sexo", Player[playerid][Sexo]);
            dini_IntSet(Arquivo(playerid), "Fome", Player[playerid][Fome]);
            dini_IntSet(Arquivo(playerid), "Sede", Player[playerid][Sede]);
            dini_IntSet(Arquivo(playerid), "Admin", Player[playerid][Admin]);
 
            dini_FloatSet(Arquivo(playerid), "X", Player[playerid][pX]);
            dini_FloatSet(Arquivo(playerid), "Y", Player[playerid][pY]);
            dini_FloatSet(Arquivo(playerid), "Z", Player[playerid][pZ]);
            dini_FloatSet(Arquivo(playerid), "A", Player[playerid][pA]);
        }
    }
}
 
ResetPlayerData(playerid)
{
    ResetPlayerMoney(playerid);
    SetPlayerScore(playerid, 0);
    SetPlayerSkin(playerid, 0);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerWantedLevel(playerid, 0);
    SetPlayerHealth(playerid, 100.0);
    SetPlayerArmour(playerid, 0.0);
 
    Player[playerid][Sexo] = Player[playerid][Admin] = Player[playerid][Fome] = Player[playerid][Sede] = Player[playerid][Tentativas] = 0;
    Player[playerid][pX] = Player[playerid][pY] = Player[playerid][pZ] = Player[playerid][pA] = 0.0;
    Player[playerid][Logado] = Player[playerid][Spawnou] = Player[playerid][Cadastrou] = false;
}