// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#pragma warning disable 239, 214 // desativar essa linha caso de algum erro

#include <a_samp>
#include <GVN>
#include <zcmd>
#include <Dini>
#include <streamer>


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
#define COR_VERMELHO 0xff0004AA
#define COR_PRETO 0x000000FF
#define COR_CINZA 0x878787FF
#define COR_AZULCLARO 0x03F2FFFF
#define COR_VERDECLARO 0x03FF35FF
#define COR_ROXO 0x7D03FFFF
#define COR_ROXOCLARO 0x9A03FFFF
#define COR_LARANJA 0xFF7403FF


// -----------------------------------------------------------------------------

#define SHORT_RADIUS 10.0
#define MID_RADIUS 20.0
#define BIG_RADIUS 50.0

// ---------------------------------------------------------------------

#define PRECO_FACA 300
#define PRECO_DEAGLE 300
#define PRECO_9MM 300
#define PRECO_SILENCED 300
#define PRECO_SHOTGUN 300
#define PRECO_SPAS12 300
#define PRECO_M4 300
#define PRECO_AK 300
#define PRECO_SNIPER 300
#define PRECO_BAZOOKA 300
#define PRECO_BKTELE 300
#define PRECO_MOLOTOV 300

// -----------------------------------------------------------------------------


enum {
    DIALOG_CADASTRO,
    DIALOG_CONECTAR,
    DIALOG_SEXUALIDADE,
    DIALOG_CIDADE_SPAWN,
    DIALOG_MOCHILA,
    DIALOG_MENU_BANCO,
    DIALOG_SAQUE_BANCO,
    DIALOG_DEPOSITO_BANCO,
    DIALOG_SALDO_BANCO,
    DIALOG_AMMU_NATION,
    DIALOG_ALUGAR_LS,
    DIALOG_ALUGAR_SF,
    DIALOG_ABRIR_MOCHILA,
    DIALOG_GUARDAR_NA_MOCHILA,
    DIALOG_TIRAR_DA_MOCHILA
};

enum pInfo {
    Senha[MAX_PASSWORD],
        UltimoLogin[24],
        // informacoes gerais
        Org,
        Sexo,
        Float:Fome,
        Float:Sede,
        Admin,
        Tentativas,
        Banco,
        Skin,
        bool:JaAlugouVeiculo,
        vid_alugado,
        // status
        bool:Logado,
        bool:Spawnou,
        bool:Cadastrou,
        bool:SpawnowLogin,
        // posicao player
        Float:pX,
        Float:pY,
        Float:pZ,
        Float:pA,

        //salariio
        Salario_minutos,
        Salario_segundos

};

enum TXDS {
    Fome_e_Sede,
    Banco,
    Salario,
    Veiculo
};

new Player[MAX_PLAYERS][pInfo];
new bool:CarregouArmas[MAX_PLAYERS];
new PlayerText:TXDDinheiro[MAX_PLAYERS], PlayerText:TXDBanco[MAX_PLAYERS], InfosTXD[MAX_PLAYERS][TXDS], Text:TXDHorario[1], PlayerText:TempoSalarioTXD[MAX_PLAYERS];
new PlayerText:SISFOME[MAX_PLAYERS][5];
new PlayerText:VInfo[MAX_PLAYERS][5];

main() {
    return 1;
}

public OnGameModeInit() {
    // Don't use these lines if it's a filterscript
    SetGameModeText("RPG");
    AddPlayerClass(0, 1128.0083, -1487.1493, 22.7690, 269.1425, 0, 0, 0, 0, 0, 0);
    UsePlayerPedAnims();
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(0);
    // ---------------------------------------------------------------------

    CreateDynamic3DTextLabel("Aperte H e alugue um veículo", COR_AZULCLARO, -1453.5293, -274.8414, 14.1411, MID_RADIUS, 0, 0);

    // ---------------------------------------------------------------------

    // CreateDynamicPickup(1274, 23, x, y, z, 10);
    // Create3DTextLabel("mensagem", CwOR , x, y, z, MID_RADIUS, 0, 0);

    // -----------------------------------------------------------------------------

    return 1;
}

public OnGameModeExit() {
    return 1;
}


public OnPlayerRequestClass(playerid, classid) {
    if (!Player[playerid][Logado]) {
        LimparChat(playerid, 30);
        PlayAudioStreamForPlayer(playerid, "https://server1.mtabrasil.com.br/youtube/play?id=YjyB6WH2KlM");
        TogglePlayerSpectating(playerid, true);
        InterpolateCameraPos(playerid, 2118.152343, 2142.547363, 43.101249, 2290.450195, 2143.153808, 36.116157, 7500);
        InterpolateCameraLookAt(playerid, 2123.133056, 2142.632324, 42.669498, 2295.448242, 2143.184570, 35.975551, 7500);

        // ---------------------------------------------------------------------

        if (!dini_Exists((Arquivo(playerid))))
            ShowPlayerDialog(playerid, DIALOG_CADASTRO, DIALOG_STYLE_PASSWORD, "Cadastro", "{FFFFFF}Insira uma senha para cadastrar-se:", "Cadastrar", "Sair");
        else
            ShowPlayerDialog(playerid, DIALOG_CONECTAR, DIALOG_STYLE_PASSWORD, "Conectando", "{FFFFFF}Insira sua senha para conectar-se:", "Conectar", "Sair");
    }

    return 1;
}


public OnPlayerConnect(playerid) {
    CarregouArmas[playerid] = false;
    ResetPlayerData(playerid);

    // variaveis de valores
    new strdinheiro[300];
    format(strdinheiro, sizeof(strdinheiro), "Dinheiro: $%d", GetPlayerMoney(playerid));

    new strbanco[300];
    format(strbanco, sizeof(strbanco), "Banco: $%d", Player[playerid][Banco]);
    StopAudioStreamForPlayer(playerid);


    //Player TextDraws: 
    // dinheiro do player
    TXDDinheiro[playerid] = CreatePlayerTextDraw(playerid, 578.000671, 439.0, strdinheiro);
    PlayerTextDrawLetterSize(playerid, TXDDinheiro[playerid], 0.166666, 0.748800);
    PlayerTextDrawTextSize(playerid, TXDDinheiro[playerid], 0.000000, 134.000000);
    PlayerTextDrawAlignment(playerid, TXDDinheiro[playerid], 2);
    PlayerTextDrawColor(playerid, TXDDinheiro[playerid], -1);
    PlayerTextDrawUseBox(playerid, TXDDinheiro[playerid], 1);
    PlayerTextDrawBoxColor(playerid, TXDDinheiro[playerid], 255);
    PlayerTextDrawSetShadow(playerid, TXDDinheiro[playerid], 0);
    PlayerTextDrawSetOutline(playerid, TXDDinheiro[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, TXDDinheiro[playerid], 255);
    PlayerTextDrawFont(playerid, TXDDinheiro[playerid], 2);
    PlayerTextDrawSetProportional(playerid, TXDDinheiro[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TXDDinheiro[playerid], 0);

    // dinehiro do player no Banco
    TXDBanco[playerid] = CreatePlayerTextDraw(playerid, 454.889129, 439.0, strbanco);
    PlayerTextDrawLetterSize(playerid, TXDBanco[playerid], 0.166666, 0.748800);
    PlayerTextDrawTextSize(playerid, TXDBanco[playerid], 0.000000, 134.000000);
    PlayerTextDrawAlignment(playerid, TXDBanco[playerid], 2);
    PlayerTextDrawColor(playerid, TXDBanco[playerid], -1);
    PlayerTextDrawUseBox(playerid, TXDBanco[playerid], 1);
    PlayerTextDrawBoxColor(playerid, TXDBanco[playerid], 255);
    PlayerTextDrawSetShadow(playerid, TXDBanco[playerid], 0);
    PlayerTextDrawSetOutline(playerid, TXDBanco[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, TXDBanco[playerid], 255);
    PlayerTextDrawFont(playerid, TXDBanco[playerid], 2);
    PlayerTextDrawSetProportional(playerid, TXDBanco[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TXDBanco[playerid], 0);



    // tempo salario
    TempoSalarioTXD[playerid] = CreatePlayerTextDraw(playerid, 500.221771, 79.493331, "Salario:__59:59");
    PlayerTextDrawLetterSize(playerid, TempoSalarioTXD[playerid], 0.235555, 1.724444);
    PlayerTextDrawTextSize(playerid, TempoSalarioTXD[playerid], 606.000000, 40.000000);
    PlayerTextDrawAlignment(playerid, TempoSalarioTXD[playerid], 1);
    PlayerTextDrawColor(playerid, TempoSalarioTXD[playerid], -1);
    PlayerTextDrawUseBox(playerid, TempoSalarioTXD[playerid], 1);
    PlayerTextDrawBoxColor(playerid, TempoSalarioTXD[playerid], 255);
    PlayerTextDrawSetShadow(playerid, TempoSalarioTXD[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, TempoSalarioTXD[playerid], -1378294017);
    PlayerTextDrawFont(playerid, TempoSalarioTXD[playerid], 2);
    PlayerTextDrawSetProportional(playerid, TempoSalarioTXD[playerid], 1);

    //Player TextDraws: vinfo



    VInfo[playerid][1] = CreatePlayerTextDraw(playerid, 129.133331, 342.766021, "");
    PlayerTextDrawTextSize(playerid, VInfo[playerid][1], 80.000000, 80.000000);
    PlayerTextDrawAlignment(playerid, VInfo[playerid][1], 1);
    PlayerTextDrawColor(playerid, VInfo[playerid][1], -2139062017);
    PlayerTextDrawSetShadow(playerid, VInfo[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, VInfo[playerid][1], -0);
    PlayerTextDrawFont(playerid, VInfo[playerid][1], 5);
    PlayerTextDrawSetProportional(playerid, VInfo[playerid][1], 0);
    PlayerTextDrawSetPreviewModel(playerid, VInfo[playerid][1], 500);
    PlayerTextDrawSetPreviewRot(playerid, VInfo[playerid][1], -10.000000, 0.000000, -7.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, VInfo[playerid][1], 1, 1);

    VInfo[playerid][2] = CreatePlayerTextDraw(playerid, 183.133331, 361.766021, "Nome_veiculo");
    PlayerTextDrawLetterSize(playerid, VInfo[playerid][2], 0.400000, 1.600000);
    PlayerTextDrawAlignment(playerid, VInfo[playerid][2], 1);
    PlayerTextDrawColor(playerid, VInfo[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, VInfo[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, VInfo[playerid][2], 255);
    PlayerTextDrawFont(playerid, VInfo[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, VInfo[playerid][2], 1);

    VInfo[playerid][3] = CreatePlayerTextDraw(playerid, 183.133331, 375.766021, "Velocidade:_100kmh");
    PlayerTextDrawLetterSize(playerid, VInfo[playerid][3], 0.400000, 1.600000);
    PlayerTextDrawAlignment(playerid, VInfo[playerid][3], 1);
    PlayerTextDrawColor(playerid, VInfo[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, VInfo[playerid][3], 0);
    PlayerTextDrawFont(playerid, VInfo[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, VInfo[playerid][3], 1);

    VInfo[playerid][4] = CreatePlayerTextDraw(playerid, 183.133331, 389.766021, "Lataria:_100%");
    PlayerTextDrawLetterSize(playerid, VInfo[playerid][4], 0.400000, 1.600000);
    PlayerTextDrawAlignment(playerid, VInfo[playerid][4], 1);
    PlayerTextDrawColor(playerid, VInfo[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, VInfo[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, VInfo[playerid][4], 255);
    PlayerTextDrawFont(playerid, VInfo[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, VInfo[playerid][4], 1);


    //Player TextDraws sistema de fome: 

    SISFOME[playerid][0] = CreatePlayerTextDraw(playerid, 450.444702, 376.666717, "box");
    PlayerTextDrawLetterSize(playerid, SISFOME[playerid][0], 0.000000, 3.333334);
    PlayerTextDrawTextSize(playerid, SISFOME[playerid][0], 523.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, SISFOME[playerid][0], 1);
    PlayerTextDrawColor(playerid, SISFOME[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, SISFOME[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, SISFOME[playerid][0], 255);
    PlayerTextDrawSetShadow(playerid, SISFOME[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, SISFOME[playerid][0], 255);
    PlayerTextDrawFont(playerid, SISFOME[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, SISFOME[playerid][0], 1);

    SISFOME[playerid][1] = CreatePlayerTextDraw(playerid, 452.555267, 379.497863, "hud:radar_burgerShot");
    PlayerTextDrawTextSize(playerid, SISFOME[playerid][1], 10.000000, 10.000000);
    PlayerTextDrawAlignment(playerid, SISFOME[playerid][1], 1);
    PlayerTextDrawColor(playerid, SISFOME[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, SISFOME[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, SISFOME[playerid][1], 255);
    PlayerTextDrawFont(playerid, SISFOME[playerid][1], 4);
    PlayerTextDrawSetProportional(playerid, SISFOME[playerid][1], 0);

    SISFOME[playerid][2] = CreatePlayerTextDraw(playerid, 452.999755, 394.431182, "hud:radar_dateDrink");
    PlayerTextDrawTextSize(playerid, SISFOME[playerid][2], 10.000000, 10.000000);
    PlayerTextDrawAlignment(playerid, SISFOME[playerid][2], 1);
    PlayerTextDrawColor(playerid, SISFOME[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, SISFOME[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, SISFOME[playerid][2], 255);
    PlayerTextDrawFont(playerid, SISFOME[playerid][2], 4);
    PlayerTextDrawSetProportional(playerid, SISFOME[playerid][2], 0);

    SISFOME[playerid][3] = CreatePlayerTextDraw(playerid, 465.555511, 379.155426, "FOME:_100");
    PlayerTextDrawLetterSize(playerid, SISFOME[playerid][3], 0.336444, 1.132088);
    PlayerTextDrawAlignment(playerid, SISFOME[playerid][3], 1);
    PlayerTextDrawColor(playerid, SISFOME[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, SISFOME[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, SISFOME[playerid][3], 255);
    PlayerTextDrawFont(playerid, SISFOME[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, SISFOME[playerid][3], 1);

    SISFOME[playerid][4] = CreatePlayerTextDraw(playerid, 465.555511, 393.591003, "SEDE:_100");
    PlayerTextDrawLetterSize(playerid, SISFOME[playerid][4], 0.336444, 1.132088);
    PlayerTextDrawAlignment(playerid, SISFOME[playerid][4], 1);
    PlayerTextDrawColor(playerid, SISFOME[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, SISFOME[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, SISFOME[playerid][4], 255);
    PlayerTextDrawFont(playerid, SISFOME[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, SISFOME[playerid][4], 1);


    //Global TextDraws: 
    // horario

    TXDHorario[0] = TextDrawCreate(600.666870, 35.159992, "00:00:00~n~");
    TextDrawLetterSize(TXDHorario[0], 0.400000, 1.600000);
    TextDrawTextSize(TXDHorario[0], 0.000000, 572.333496);
    TextDrawAlignment(TXDHorario[0], 2);
    TextDrawColor(TXDHorario[0], -1378294017);
    TextDrawSetShadow(TXDHorario[0], 1);
    TextDrawSetOutline(TXDHorario[0], 1);
    TextDrawBackgroundColor(TXDHorario[0], 255);
    TextDrawFont(TXDHorario[0], 3);
    TextDrawSetProportional(TXDHorario[0], 1);

    return 1;
}

public OnPlayerDisconnect(playerid, reason) {
    TextDrawDestroy(Text:TXDDinheiro[playerid]);
    TextDrawDestroy(Text:TXDBanco[playerid]);
    for (new i = 0; i < 6; i++) {
        PlayerTextDrawDestroy(playerid, (SISFOME[playerid][i]));
    }
    SalvarDados(playerid);
    KillTimer(InfosTXD[playerid][Banco]); //mata o temporizador 
    KillTimer(InfosTXD[playerid][Salario]); //mata o temporizador 
    KillTimer(InfosTXD[playerid][Veiculo]); //mata o temporizador 
    if (Player[playerid][JaAlugouVeiculo] && Player[playerid][vid_alugado] != 0) {
        DestroyVehicle(Player[playerid][vid_alugado]);
        printf("Veiculo destruido");
    }
    return 1;
}

public OnPlayerSpawn(playerid) {
    StopAudioStreamForPlayer(playerid);
    ResetPlayerWeapons(playerid);
    if (Player[playerid][Spawnou]) {
        if (Player[playerid][Cadastrou]) {
            new string[110];
            LimparChat(playerid, 50);
            Player[playerid][Spawnou] = false;
            Player[playerid][Cadastrou] = false;

            format(string, sizeof(string), "{98FB98}* {FFFFFF}Bem-vindo(a) {98FB98}%s{FFFFFF}, pela primeira vez ao nosso servidor.", pName(playerid));
            SendClientMessage(playerid, -1, string);
            SendClientMessage(playerid, -1, "{98FB98}* {FFFFFF}Caso tenha dúvidas e precisar de ajuda use os comandos {98FB98}/ajuda {FFFFFF}e {98FB98}/comandos{FFFFFF}.");
        } else {
            new string[135];
            LimparChat(playerid, 50);
            Player[playerid][Spawnou] = false;

            format(string, sizeof(string), "{98FB98}* {FFFFFF}Olá {98FB98}%s{FFFFFF}, seu último login no servidor foi: {98FB98}%s{FFFFFF}.", pName(playerid), Player[playerid][UltimoLogin]);
            SendClientMessage(playerid, -1, string);
            SendClientMessage(playerid, -1, "{98FB98}* {FFFFFF}Caso tenha dúvidas e precisar de ajuda use os comandos {98FB98}/ajuda {FFFFFF}e {98FB98}/comandos{FFFFFF}.");
            // update txd
            // -----------------------------------------------------------------------------
            InfosTXD[playerid][Banco] = SetTimerEx("updatemonetary", 1000, true, "i", playerid); //cri um novo temporizador
            InfosTXD[playerid][Salario] = SetTimerEx("updatepayday", 1000, true, "i", playerid); //cri um novo temporizador
            InfosTXD[playerid][Fome_e_Sede] = SetTimerEx("updatefomeesede", 60000 * 5, true, "i", playerid); //cri um novo temporizador
            // InfosTXD[playerid][Veiculo] = SetTimerEx("updatevehicleinfo", 1000, true, "i", playerid); //cri um novo temporizador

            // -----------------------------------------------------------------------------
            // print("spawnow");
        }


    }

    // anti SK
    // -----------------------------------------------------------------------------
    SetPlayerHealth(playerid, 9999);
    SetTimerEx("AntiSk", 5000, false, "i", playerid);
    // -----------------------------------------------------------------------------

    // if (Player[playerid][SpawnowLogin] == false) return CarregarDados(playerid);

    return 1;
}

public OnPlayerDeath(playerid, killerid, reason) {
    ResetPlayerWeapons(playerid);
    return 1;
}

public OnVehicleSpawn(vehicleid) {
    new engine, lights, alarm, doors, bonnet, boot, objective;
    SetVehicleParamsEx(vehicleid, engine = 0, lights, alarm, doors, bonnet, boot, objective); // Desliga o motor
    return 1;
}

public OnVehicleDeath(vehicleid, killerid) {
    DestroyVehicle(vehicleid);
    if (Player[killerid][JaAlugouVeiculo] && Player[killerid][vid_alugado] == vehicleid) {
        SendClientMessage(killerid, COR_VERMELHO, "[Aluguel] - Voce destruiu o veiculo alugado e foram retirados $1000 seus para arcar com os custos.");
        Player[killerid][JaAlugouVeiculo] = false;
        Player[killerid][vid_alugado] = 0;
        GivePlayerMoney(killerid, -1000);
    }
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
    // if (ispassenger) return 1; // Ignora se o jogador for passageiro
    // InfosTXD[playerid][Veiculo] = SetTimerEx("updatevehicleinfo", 1000, true, "i", playerid); //cri um novo temporizador
    // updatevehicleinfo(playerid);
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid) {
    // KillTimer(InfosTXD[playerid][Veiculo]);
    // PlayerTextDrawHide(playerid, Vinfo[playerid]);
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate) {
    if (oldstate == PLAYER_STATE_ONFOOT && (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)) return InfosTXD[playerid][Veiculo] = SetTimerEx("updatevehicleinfo", 100, true, "i", playerid), PlayerTextDrawSetPreviewModel(playerid, VInfo[playerid][1], GetVehicleModel(GetPlayerVehicleID(playerid))), PlayerTextDrawSetPreviewVehCol(playerid, VInfo[playerid][1], -1, -1), PlayerTextDrawShow(playerid, VInfo[playerid][1]); //cri um novo temporizador apos entrar no carro como motorista ou passageiro

    if ((oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER) && (newstate == PLAYER_STATE_ONFOOT || newstate == PLAYER_STATE_EXIT_VEHICLE)) {
        KillTimer(InfosTXD[playerid][Veiculo]);
        for (new l = 0; l < 5; l++) {
            PlayerTextDrawHide(playerid, VInfo[playerid][l]); //mata update apos sair de veículo
        }
    }

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
    if (newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP) && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0);
    if (newkeys == 262144 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
        // cmd_caixa(playerid, "");
        // cmd_sair(playerid, "");
    }

    if (newkeys == 262144 && IsPlayerInRangeOfPoint(playerid, 2.0, -1453.5293, -274.8414, 14.1411)) { //aluguel spawn sf
        // cmd_caixa(playerid, "");
        // cmd_sair(playerid, "");
        cmd_alugarsf(playerid, "");
    }
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

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    switch (dialogid) {
        case DIALOG_CADASTRO:  {
            if (!response)
                return Kick(playerid);

            if (!(MIN_PASSWORD <= strlen(inputtext) <= MAX_PASSWORD)) {
                new dialog[100];
                format(dialog, sizeof(dialog), "{FFFFFF}Insira uma senha para cadastrar-se:\n\n{FF0000}* Insira uma senha entre %i a %i caracteres.", MIN_PASSWORD, MAX_PASSWORD);
                ShowPlayerDialog(playerid, DIALOG_CADASTRO, DIALOG_STYLE_PASSWORD, "Cadastro", dialog, "Cadastrar", "Sair");
            } else {
                format(Player[playerid][Senha], MAX_PASSWORD, inputtext);
                format(Player[playerid][UltimoLogin], 24, formatTime());

                // -------------------------------------------------------------

                dini_Create(Arquivo(playerid));
                dini_Set(Arquivo(playerid), "Senha", Player[playerid][Senha]);
                dini_Set(Arquivo(playerid), "UltimoLogin", Player[playerid][UltimoLogin]);
                dini_Set(Arquivo(playerid), "IP", formatIP(playerid));
                dini_IntSet(Arquivo(playerid), "Dinheiro", 0);
                dini_IntSet(Arquivo(playerid), "Level", 0);
                dini_IntSet(Arquivo(playerid), "Skin", 0);
                dini_IntSet(Arquivo(playerid), "Interior", 0);
                dini_IntSet(Arquivo(playerid), "VirtualWorld", 0);
                dini_IntSet(Arquivo(playerid), "Estrelas", 0);
                dini_FloatSet(Arquivo(playerid), "Vida", 100.0);
                dini_FloatSet(Arquivo(playerid), "Colete", 0.0);

                dini_IntSet(Arquivo(playerid), "Org", Player[playerid][Org] = 0);
                dini_IntSet(Arquivo(playerid), "Sexo", Player[playerid][Sexo] = 0);
                dini_FloatSet(Arquivo(playerid), "Fome", Player[playerid][Fome] = 30);
                dini_FloatSet(Arquivo(playerid), "Sede", Player[playerid][Sede] = 30);
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
        case DIALOG_SEXUALIDADE:  {
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
        case DIALOG_CONECTAR:  {
            if (!response)
                return Kick(playerid);

            if (!strlen(inputtext))
                return ShowPlayerDialog(playerid, DIALOG_CONECTAR, DIALOG_STYLE_PASSWORD, "Conectando", "{FFFFFF}Insira sua senha para conectar-se:", "Conectar", "Sair");

            format(Player[playerid][Senha], MAX_PASSWORD, dini_Get(Arquivo(playerid), "Senha"));
            format(Player[playerid][UltimoLogin], 24, dini_Get(Arquivo(playerid), "UltimoLogin"));

            if (!strcmp(Player[playerid][Senha], inputtext)) {

                CarregarDados(playerid);
                //SpawnPlayer(playerid); isso duplica
            } else {
                Player[playerid][Tentativas]++;
                if (Player[playerid][Tentativas] >= MAX_ATTEMPS_PASSWORD) return Kick(playerid);

                new dialog[90];
                format(dialog, sizeof(dialog), "{FFFFFF}Insira sua senha para conectar-se:\n\n{FF0000}* Senha incorreta (%i/%i).", Player[playerid][Tentativas], MAX_ATTEMPS_PASSWORD);
                ShowPlayerDialog(playerid, DIALOG_CONECTAR, DIALOG_STYLE_PASSWORD, "Conectando", dialog, "Conectar", "Sair");
            }
        }
        case DIALOG_CIDADE_SPAWN:  {
            if (!response) return selecionarspawn(playerid), SendClientMessage(playerid, COR_VERMELHO, "[ SERVIDOR ] Selecione onde vai spawnar.");
            if (response) {
                switch (listitem) {
                    case 0 :  {
                        SetSpawnInfo(playerid, Player[playerid][Org], GetPlayerSkin(playerid), 1682.2435, -2283.8828, 13.5109, 1.6417, 0, 0, 0, 0, 0, 0);
                    }
                    case 1 :  {
                        SetSpawnInfo(playerid, Player[playerid][Org], GetPlayerSkin(playerid), -1421.9773, -288.7412, 14.1484, 145.9196, 0, 0, 0, 0, 0, 0);
                    }
                    case 2 :  {
                        SetSpawnInfo(playerid, Player[playerid][Org], GetPlayerSkin(playerid), Player[playerid][pX], Player[playerid][pY], Player[playerid][pZ], Player[playerid][pA], 0, 0, 0, 0, 0, 0);
                    }
                }
                TogglePlayerSpectating(playerid, false);
                SetCameraBehindPlayer(playerid);
            }
        }
        case DIALOG_ALUGAR_LS:  {

        }
        case DIALOG_ALUGAR_SF:  {
            if (!response) return 1;
            //481
            //509
            //510
            //462
            new vid;
            if (listitem == 0 && !Player[playerid][JaAlugouVeiculo]) return vid = CreateVehicle(481, -1458.2435, -277.9483, 13.9926, 75.7904, COR_BRANCO, COR_BRANCO, 0, 0), PutPlayerInVehicle(playerid, vid, 0), Player[playerid][JaAlugouVeiculo] = true, Player[playerid][vid_alugado] = vid;
            if (listitem == 1 && !Player[playerid][JaAlugouVeiculo]) return vid = CreateVehicle(509, -1458.2435, -277.9483, 13.9926, 75.7904, COR_BRANCO, COR_BRANCO, 0, 0), PutPlayerInVehicle(playerid, vid, 0), Player[playerid][JaAlugouVeiculo] = true, Player[playerid][vid_alugado] = vid;
            if (listitem == 2 && !Player[playerid][JaAlugouVeiculo]) return vid = CreateVehicle(510, -1458.2435, -277.9483, 13.9926, 75.7904, COR_BRANCO, COR_BRANCO, 0, 0), PutPlayerInVehicle(playerid, vid, 0), Player[playerid][JaAlugouVeiculo] = true, Player[playerid][vid_alugado] = vid;
            if (listitem == 3 && !Player[playerid][JaAlugouVeiculo]) return vid = CreateVehicle(462, -1458.2435, -277.9483, 13.9926, 75.7904, COR_BRANCO, COR_BRANCO, 0, 0), PutPlayerInVehicle(playerid, vid, 0), Player[playerid][JaAlugouVeiculo] = true, Player[playerid][vid_alugado] = vid;
            if (listitem == 4) {
                if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COR_VERMELHO, "[Aluguel] - Voce nao está em um veiculo");
                // if (!Player[playerid][JaAlugouVeiculo]) return SendClientMessage(playerid, COR_AMARELO, "[Aluguel] - Voce nao alugou um veiculo.");
                if (GetPlayerVehicleID(playerid) != Player[playerid][vid_alugado]) return SendClientMessage(playerid, COR_VERMELHO, "[Aluguel] - Este nao e o veiculo que voce alugou.");
                if (Player[playerid][JaAlugouVeiculo] && GetPlayerVehicleID(playerid) == Player[playerid][vid_alugado]) return SendClientMessage(playerid, COR_VERDECLARO, "[Aluguel] - Voce devolveu o veiculo alugado"), DestroyVehicle(Player[playerid][vid_alugado]), Player[playerid][JaAlugouVeiculo] = false, Player[playerid][vid_alugado] = 0;

                if (!Player[playerid][JaAlugouVeiculo]) return SendClientMessage(playerid, COR_VERMELHO, "[Aluguel] - Voce nao alugou um veiculo");
            }
            if (Player[playerid][JaAlugouVeiculo]) return SendClientMessage(playerid, COR_AMARELO, "[Aluguel] - Voce alugou um veiculo recentemente, devolva-o para alugar outro.");
        }
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source) {
    return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
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
        if (IsPlayerInRangeOfPoint(id, SHORT_RADIUS, x, y, z)) {
            SendClientMessage(playerid, COR_ROXOCLARO, msg);
        }
    }
    return 1;
}

CMD:loja(playerid, params[]) {
    new str[500];
    format(str, sizeof(str), "Faca\t%d\n9MM\t%d\nDesert Eagle\t%d", PRECO_FACA, PRECO_9MM, PRECO_DEAGLE);
    ShowPlayerDialog(playerid, DIALOG_AMMU_NATION, DIALOG_STYLE_LIST, "Selecione uma arma para comprar", str, "Comprar", "Sair");
    return 1;
}

CMD:clr(playerid, params[]) {
    LimparChat(playerid, 50);
    return 1;
}

CMD:radio(playerid, params[]) {

    return 1;
}

CMD:alugarsf(playerid, params[]) {
    ShowPlayerDialog(playerid, DIALOG_ALUGAR_SF, DIALOG_STYLE_LIST, "Alugar veículo", "Alugar BMX\nAlugar Bike\nAlugar Mountain Bike\nAlugar Faggio\n{ff0000}Devolver veiculo", "Selecionar", "Cancelar");
    return 1;
}

CMD:comer(playerid, params[]) {
    SendClientMessage(playerid, COR_VERDECLARO, "[Necessidades] - Voce comeu uma fatia de pizza e recuperou 10%% de fome");
    Player[playerid][Fome] += 10.0;
    return 1;
}

CMD:beber(playerid, params[]) {
    SendClientMessage(playerid, COR_VERDECLARO, "[Necessidades] - Voce bebeu uma garrafa de agua mineral e recuperou 10%% de sede");
    Player[playerid][Sede] += 10.0;
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

stock ArquivoVeiculos() {
    new filerr[100];
    format(filerr, sizeof(filerr), "Veiculos_Servidor/veiculos.ini");
    return filerr;
}

// -----------------------------------------------------------------------------



formatIP(playerid) {
    new ip[16];
    GetPlayerIp(playerid, ip, 16);
    return ip;
}


Float:formatHealth(playerid) {
    new Float:health;
    GetPlayerHealth(playerid, health);
    return health;
}

Float:formatArmour(playerid) {
    new Float:armour;
    GetPlayerArmour(playerid, armour);
    return armour;
}

formatTime() {
    new output[24], date[3], hour[3];
    getdate(date[2], date[1], date[0]);
    gettime(hour[0], hour[1], hour[2]);
    format(output, sizeof(output), "%02d/%02d/%04d - %02d:%02d:%02d", date[0], date[1], date[2], hour[0], hour[1], hour[2]);
    return output;
}

LimparChat(playerid, lines)
for (new i; i != lines; i++)
    SendClientMessage(playerid, -1, #);

// -----------------------------------------------------------------------------

SalvarDados(playerid) {
    if (Player[playerid][Logado]) {
        if (dini_Exists(Arquivo(playerid))) {
            format(Player[playerid][UltimoLogin], 24, formatTime());
            GetPlayerPos(playerid, Player[playerid][pX], Player[playerid][pY], Player[playerid][pZ]);
            GetPlayerFacingAngle(playerid, Player[playerid][pA]);

            dini_Set(Arquivo(playerid), "UltimoLogin", Player[playerid][UltimoLogin]);
            dini_Set(Arquivo(playerid), "IP", formatIP(playerid));
            dini_IntSet(Arquivo(playerid), "Dinheiro", GetPlayerMoney(playerid));
            dini_IntSet(Arquivo(playerid), "Level", GetPlayerScore(playerid));
            dini_IntSet(Arquivo(playerid), "Skin", GetPlayerSkin(playerid));
            dini_IntSet(Arquivo(playerid), "Interior", GetPlayerInterior(playerid));
            dini_IntSet(Arquivo(playerid), "VirtualWorld", GetPlayerVirtualWorld(playerid));
            dini_IntSet(Arquivo(playerid), "Estrelas", GetPlayerWantedLevel(playerid));
            dini_FloatSet(Arquivo(playerid), "Vida", formatHealth(playerid));
            dini_FloatSet(Arquivo(playerid), "Colete", formatArmour(playerid));

            dini_IntSet(Arquivo(playerid), "Org", Player[playerid][Org]);
            dini_IntSet(Arquivo(playerid), "Skin", GetPlayerSkin(playerid));
            dini_IntSet(Arquivo(playerid), "Sexo", Player[playerid][Sexo]);
            dini_FloatSet(Arquivo(playerid), "Fome", Player[playerid][Fome]);
            dini_FloatSet(Arquivo(playerid), "Sede", Player[playerid][Sede]);
            dini_IntSet(Arquivo(playerid), "Admin", Player[playerid][Admin]);
            dini_IntSet(Arquivo(playerid), "Banco", Player[playerid][Banco]);

            dini_FloatSet(Arquivo(playerid), "X", Player[playerid][pX]);
            dini_FloatSet(Arquivo(playerid), "Y", Player[playerid][pY]);
            dini_FloatSet(Arquivo(playerid), "Z", Player[playerid][pZ]);
            dini_FloatSet(Arquivo(playerid), "A", Player[playerid][pA]);

            dini_IntSet(Arquivo(playerid), "Salario_minutos", Player[playerid][Salario_minutos]);
            dini_IntSet(Arquivo(playerid), "Salario_segundos", Player[playerid][Salario_segundos]);
            new wid, wammo, str[90];
            for (new i = 0; i < 13; i++) {
                GetPlayerWeaponData(playerid, i, wid, wammo);
                format(str, sizeof(str), "Arma%d", i);
                dini_IntSet(Arquivo(playerid), str, wid);
                format(str, sizeof(str), "Municao%d", i);
                dini_IntSet(Arquivo(playerid), str, wammo);
            }
        }
    }
}

CarregarDados(playerid) {
    GivePlayerMoney(playerid, dini_Int(Arquivo(playerid), "Dinheiro"));
    SetPlayerScore(playerid, dini_Int(Arquivo(playerid), "Level"));
    SetPlayerSkin(playerid, dini_Int(Arquivo(playerid), "Skin"));
    SetPlayerInterior(playerid, dini_Int(Arquivo(playerid), "Interior"));
    SetPlayerVirtualWorld(playerid, dini_Int(Arquivo(playerid), "VirtualWorld"));
    SetPlayerWantedLevel(playerid, dini_Int(Arquivo(playerid), "Estrelas"));
    SetPlayerHealth(playerid, dini_Float(Arquivo(playerid), "Vida"));
    SetPlayerArmour(playerid, dini_Float(Arquivo(playerid), "Colete"));

    Player[playerid][Org] = dini_Int(Arquivo(playerid), "Org");
    Player[playerid][Sexo] = dini_Int(Arquivo(playerid), "Sexo");
    Player[playerid][Fome] = dini_Float(Arquivo(playerid), "Fome");
    Player[playerid][Sede] = dini_Float(Arquivo(playerid), "Sede");
    Player[playerid][Admin] = dini_Int(Arquivo(playerid), "Admin");
    Player[playerid][Banco] = dini_Int(Arquivo(playerid), "Banco");

    Player[playerid][pX] = dini_Float(Arquivo(playerid), "X");
    Player[playerid][pY] = dini_Float(Arquivo(playerid), "Y");
    Player[playerid][pZ] = dini_Float(Arquivo(playerid), "Z");
    Player[playerid][pA] = dini_Float(Arquivo(playerid), "A");

    Player[playerid][Logado] = true;
    Player[playerid][Spawnou] = true;
    SendClientMessage(playerid, -1, "{98FB98}* {FFFFFF}Entrada efetuada com sucesso.");

    Player[playerid][Salario_minutos] = dini_Int(Arquivo(playerid), "Salario_minutos");
    Player[playerid][Salario_segundos] = dini_Int(Arquivo(playerid), "Salario_segundos");
    new wid, wammo, str[90];
    for (new i = 0; i < 13; i++) {
        format(str, sizeof(str), "Arma%d", i);
        wid = dini_Int(Arquivo(playerid), str);
        format(str, sizeof(str), "Municao%d", i);
        wammo = dini_Int(Arquivo(playerid), str);
        GivePlayerWeapon(playerid, wid, wammo);
    }
    CarregouArmas[playerid] = true;

    selecionarspawn(playerid);
    // TogglePlayerSpectating(playerid, false);
    // SetCameraBehindPlayer(playerid);

    // Player[playerid][SpawnowLogin] = false;

    return 1;
}

ResetPlayerData(playerid) {
    ResetPlayerMoney(playerid);
    SetPlayerScore(playerid, 0);
    SetPlayerSkin(playerid, 0);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerWantedLevel(playerid, 0);
    SetPlayerHealth(playerid, 100.0);
    SetPlayerArmour(playerid, 0);

    Player[playerid][Sexo] = Player[playerid][Admin] = Player[playerid][Tentativas] = 0;
    Player[playerid][pX] = Player[playerid][pY] = Player[playerid][pZ] = Player[playerid][pA] = Player[playerid][Fome] = Player[playerid][Sede] = 0.0;
    Player[playerid][Logado] = Player[playerid][Spawnou] = Player[playerid][Cadastrou] = false;
}

// -----------------------------------------------------------------------------
forward AntiSk(playerid);
public AntiSk(playerid) {
    // define a vida para 100
    SetPlayerHealth(playerid, 100);
    return 1;
}

forward updatemonetary(playerid);
public updatemonetary(playerid) {

    // variaveis de valores
    new strdinheiro[300];
    format(strdinheiro, sizeof(strdinheiro), "Dinheiro: $%d", GetPlayerMoney(playerid));

    new strbanco[300];
    format(strbanco, sizeof(strbanco), "Banco: $%d", Player[playerid][Banco]);

    new horario[100], hora, minuto, segundo;
    gettime(hora, minuto, segundo);
    format(horario, sizeof(horario), "%02d:%02d:%02d", hora, minuto, segundo);
    SetWorldTime(hora + 3);

    // mostra o horario na tela
    TextDrawSetString(TXDHorario[0], horario);
    TextDrawShowForAll(TXDHorario[0]);


    PlayerTextDrawSetString(playerid, TXDDinheiro[playerid], strdinheiro);
    PlayerTextDrawSetString(playerid, TXDBanco[playerid], strbanco);

    PlayerTextDrawShow(playerid, TXDBanco[playerid]);
    PlayerTextDrawShow(playerid, TXDDinheiro[playerid]);
    return 1;
}

forward updatepayday(playerid);
public updatepayday(playerid) {

    // variaveis de valores
    new str[300];

    // Reduz o contador de segundos
    Player[playerid][Salario_segundos]--;

    // Se os segundos chegarem a 0
    if (Player[playerid][Salario_segundos] <= 0) {
        // Reduz o contador de minutos
        Player[playerid][Salario_minutos]--;

        // Se os minutos também chegarem a 0
        if (Player[playerid][Salario_minutos] <= 0) {
            // Envia uma mensagem de pagamento
            SendClientMessage(playerid, -1, "Pagamento!");

            // Reseta os contadores de minutos e segundos
            Player[playerid][Salario_minutos] = 59;
            Player[playerid][Salario_segundos] = 59;
        } else {
            // Reseta o contador de segundos
            Player[playerid][Salario_segundos] = 60;
        }
    }

    format(str, sizeof(str), "Salario: %02d:%02d", Player[playerid][Salario_minutos], Player[playerid][Salario_segundos]);

    PlayerTextDrawSetString(playerid, TempoSalarioTXD[playerid], str);

    PlayerTextDrawShow(playerid, TempoSalarioTXD[playerid]);
    return 1;
}

forward updatevehicleinfo(playerid);
public updatevehicleinfo(playerid) { // Função que atualiza as informações do veículo
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
        new str[300]; // Cria uma nova string com capacidade para 300 caracteres
        new vehicleid; // Cria uma nova variável para armazenar o ID do veículo
        vehicleid = GetPlayerVehicleID(playerid); // Obtém o ID do veículo que o jogador está dirigindo
        GetVehicleName(vehicleid); // Obtém o nome do veículo
        new Float:x, Float:y, Float:z; // Cria novas variáveis para armazenar a velocidade do veículo em cada eixo
        new Float:health; // Cria uma nova variável para armazenar a saúde do veículo
        GetVehicleVelocity(vehicleid, x, y, z); // Obtém a velocidade do veículo
        new veiculovelocidade = floatround(floatsqroot((x * x) + (y * y) + (z * z)) * 1.61 * 100); // Calcula a velocidade do veículo em km/h

        GetVehicleHealth(vehicleid, health); // Obtém a saúde do veículo
        new Float:lataria = health / 10; // Calcula a saúde da lataria do veículo
        if (lataria <= 25) { // Se a saúde da lataria for menor que 25%
            new engine, lights, alarm, doors, bonnet, boot, objective; // Cria novas variáveis para armazenar os parâmetros do veículo
            GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective); // Obtém os parâmetros do veículo
            if (engine) { // Se o motor estiver ligado
                SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective); // Desliga o motor
                SendClientMessage(playerid, -1, "O motor do veículo foi desligado por estar muito danificado"); // Envia uma mensagem para o jogador
                SetVehicleHealth(vehicleid, 55);
            }
        }

        // format(str, sizeof(str), "Veículo:_%s~n~Velocidade:_%dKm~n~Lataria:_%.1f%%", GetVehicleName(GetVehicleModel(vehicleid)), veiculovelocidade, lataria); // Formata a string com as informações do veículo

        //0 box
        //1 veiculo
        //2 nome
        //3 velocidade
        //4 lataria

        format(str, sizeof(str), "%s", GetVehicleName(GetVehicleModel(vehicleid))); // Formata a string com as informações do veículo
        PlayerTextDrawSetString(playerid, VInfo[playerid][2], str); // Define a string do texto do jogador

        format(str, sizeof(str), "Velocidade:_%dKM/h", veiculovelocidade); // Formata a string com as informações do veículo
        PlayerTextDrawSetString(playerid, VInfo[playerid][3], str); // Define a string do texto do jogador

        format(str, sizeof(str), "Lataria:_%.1f%%", lataria); // Formata a string com as informações do veículo
        PlayerTextDrawSetString(playerid, VInfo[playerid][4], str); // Define a string do texto do jogador

        PlayerTextDrawShow(playerid, VInfo[playerid][2]); // Mostra o texto para o jogador
        PlayerTextDrawShow(playerid, VInfo[playerid][3]); // Mostra o texto para o jogador
        PlayerTextDrawShow(playerid, VInfo[playerid][4]); // Mostra o texto para o jogador
        // Mostra o texto para o jogador
    }
    return 1; // Retorna 1 para indicar que a função foi executada com sucesso
}

forward updatefomeesede(playerid);
public updatefomeesede(playerid) {
    new str[20], Float:health, vida; //vars

    //reduz valores
    Player[playerid][Sede] -= 0.01388;
    Player[playerid][Fome] -= 0.00925;

    //checa
    if (Player[playerid][Fome] <= 0) {
        vida = GetPlayerHealth(playerid, health), SetPlayerHealth(playerid, vida - 1), SendClientMessage(playerid, COR_VERMELHO, "[Necessidades] - Voce tomou dano por estar com muita Fome");
        Player[playerid][Fome] = 0; //se for menor que zero zera
    }
    if (Player[playerid][Sede] <= 0) {
        vida = GetPlayerHealth(playerid, health), SetPlayerHealth(playerid, vida - 1), SendClientMessage(playerid, COR_VERMELHO, "[Necessidades] - Voce tomou dano por estar com muita sede");
        Player[playerid][Sede] = 0; //se for menor que zero zera
    }

    if (Player[playerid][Fome] < 10) {
        SendClientMessage(playerid, COR_VERMELHO, "[Necessidades] - Voce esta com fome, coma algo!");
    }
    if (Player[playerid][Sede] < 10) {
        SendClientMessage(playerid, COR_VERMELHO, "[Necessidades] - Voce esta com sede, beba algo!");
    }

    format(str, sizeof(str), "Fome:_%.1f%%", Player[playerid][Fome]);
    PlayerTextDrawSetString(playerid, SISFOME[playerid][3], str); //3
    format(str, sizeof(str), "Sede:_%.1f%%", Player[playerid][Sede]);
    PlayerTextDrawSetString(playerid, SISFOME[playerid][4], str); //4

    for (new j = 0; j < 5; j++) {
        PlayerTextDrawShow(playerid, SISFOME[playerid][j]);
    }

    return 1;
}


forward selecionarspawn(playerid);
public selecionarspawn(playerid) {
    ShowPlayerDialog(playerid, DIALOG_CIDADE_SPAWN, DIALOG_STYLE_LIST, "SELECIONE A CIDADE DE SPAWN", "Los santos\nSan Fierro\nUltima posicao", "Selecionar", "");
    return 1;
}