// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>
#include <vehicleutil>
#include <zcmd>
#include <Dini>
#include <streamer>

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

#define DIALOG_SPAWN_CONCE 21213

new PlayerText:ConceTXD[MAX_PLAYERS][10];

public OnGameModeInit() {
    return 1;
}

public OnGameModeExit() {
    return 1;
}


public OnPlayerRequestClass(playerid, classid) {
    return 1;
}


public OnPlayerConnect(playerid) {

    ConceTXD[playerid][0] = CreatePlayerTextDraw(playerid, 340.000000, 140.000000, "box");
    PlayerTextDrawLetterSize(playerid, ConceTXD[playerid][0], 0.000000, 29.044443);
    PlayerTextDrawTextSize(playerid, ConceTXD[playerid][0], 0.000000, 248.000000);
    PlayerTextDrawAlignment(playerid, ConceTXD[playerid][0], 2);
    PlayerTextDrawColor(playerid, ConceTXD[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, ConceTXD[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, ConceTXD[playerid][0], -16776961);
    PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][0], 255);
    PlayerTextDrawFont(playerid, ConceTXD[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][0], 1);

    ConceTXD[playerid][1] = CreatePlayerTextDraw(playerid, 220.000000, 154.000000, "");
    PlayerTextDrawTextSize(playerid, ConceTXD[playerid][1], 80.000000, 80.000000);
    PlayerTextDrawAlignment(playerid, ConceTXD[playerid][1], 1);
    PlayerTextDrawColor(playerid, ConceTXD[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][1], 255);
    PlayerTextDrawFont(playerid, ConceTXD[playerid][1], 5);
    PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][1], 0);
    PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][1], true);
    PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][1], 602);
    PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][1], 0.000000, 0.000000, 80.000000, 1.000000);

    ConceTXD[playerid][2] = CreatePlayerTextDraw(playerid, 301.000000, 154.000000, "");
    PlayerTextDrawTextSize(playerid, ConceTXD[playerid][2], 80.000000, 80.000000);
    PlayerTextDrawAlignment(playerid, ConceTXD[playerid][2], 1);
    PlayerTextDrawColor(playerid, ConceTXD[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][2], 255);
    PlayerTextDrawFont(playerid, ConceTXD[playerid][2], 5);
    PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][2], true);
    PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][2], 496);
    PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][2], 0.000000, 0.000000, 80.000000, 1.000000);

    ConceTXD[playerid][3] = CreatePlayerTextDraw(playerid, 382.000000, 154.000000, "");
    PlayerTextDrawTextSize(playerid, ConceTXD[playerid][3], 80.000000, 80.000000);
    PlayerTextDrawAlignment(playerid, ConceTXD[playerid][3], 1);
    PlayerTextDrawColor(playerid, ConceTXD[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][3], 255);
    PlayerTextDrawFont(playerid, ConceTXD[playerid][3], 5);
    PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][3], 0);
    PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][3], true);
    PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][3], 527);
    PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][3], 0.000000, 0.000000, 80.000000, 1.000000);

    ConceTXD[playerid][4] = CreatePlayerTextDraw(playerid, 220.000000, 235.000000, "");
    PlayerTextDrawTextSize(playerid, ConceTXD[playerid][4], 80.000000, 80.000000);
    PlayerTextDrawAlignment(playerid, ConceTXD[playerid][4], 1);
    PlayerTextDrawColor(playerid, ConceTXD[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][4], 255);
    PlayerTextDrawFont(playerid, ConceTXD[playerid][4], 5);
    PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][4], 0);
    PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][4], true);
    PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][4], 526);
    PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][4], 0.000000, 0.000000, 80.000000, 1.000000);

    ConceTXD[playerid][5] = CreatePlayerTextDraw(playerid, 301.000000, 235.000000, "");
    PlayerTextDrawTextSize(playerid, ConceTXD[playerid][5], 80.000000, 80.000000);
    PlayerTextDrawAlignment(playerid, ConceTXD[playerid][5], 1);
    PlayerTextDrawColor(playerid, ConceTXD[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][5], 255);
    PlayerTextDrawFont(playerid, ConceTXD[playerid][5], 5);
    PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][5], 0);
    PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][5], true);
    PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][5], 410);
    PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][5], 0.000000, 0.000000, 80.000000, 1.000000);

    ConceTXD[playerid][6] = CreatePlayerTextDraw(playerid, 382.000000, 235.000000, "");
    PlayerTextDrawTextSize(playerid, ConceTXD[playerid][6], 80.000000, 80.000000);
    PlayerTextDrawAlignment(playerid, ConceTXD[playerid][6], 1);
    PlayerTextDrawColor(playerid, ConceTXD[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][6], 255);
    PlayerTextDrawFont(playerid, ConceTXD[playerid][6], 5);
    PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][6], 0);
    PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][6], true);
    PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][6], 436);
    PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][6], 0.000000, 0.000000, 80.000000, 1.000000);

    ConceTXD[playerid][7] = CreatePlayerTextDraw(playerid, 220.000000, 316.000000, "");
    PlayerTextDrawTextSize(playerid, ConceTXD[playerid][7], 80.000000, 80.000000);
    PlayerTextDrawAlignment(playerid, ConceTXD[playerid][7], 1);
    PlayerTextDrawColor(playerid, ConceTXD[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][7], 255);
    PlayerTextDrawFont(playerid, ConceTXD[playerid][7], 5);
    PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][7], 0);
    PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][7], true);
    PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][7], 439);
    PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][7], 0.000000, 0.000000, 80.000000, 1.000000);

    ConceTXD[playerid][8] = CreatePlayerTextDraw(playerid, 301.000000, 316.000000, "");
    PlayerTextDrawTextSize(playerid, ConceTXD[playerid][8], 80.000000, 80.000000);
    PlayerTextDrawAlignment(playerid, ConceTXD[playerid][8], 1);
    PlayerTextDrawColor(playerid, ConceTXD[playerid][8], -1);
    PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][8], 255);
    PlayerTextDrawFont(playerid, ConceTXD[playerid][8], 5);
    PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][8], 0);
    PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][8], true);
    PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][8], 589);
    PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][8], 0.000000, 0.000000, 80.000000, 1.000000);

    ConceTXD[playerid][9] = CreatePlayerTextDraw(playerid, 382.000000, 316.000000, "");
    PlayerTextDrawTextSize(playerid, ConceTXD[playerid][9], 80.000000, 80.000000);
    PlayerTextDrawAlignment(playerid, ConceTXD[playerid][9], 1);
    PlayerTextDrawColor(playerid, ConceTXD[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][9], 255);
    PlayerTextDrawFont(playerid, ConceTXD[playerid][9], 5);
    PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][9], 0);
    PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][9], true);
    PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][9], 587);
    PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][9], 0.000000, 0.000000, 80.000000, 1.000000);
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    if (newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP) && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0);
    if (newkeys == 262144 && IsPlayerInRangeOfPoint(playerid, 2.0, -1453.5293, -274.8414, 14.1411)) {
        // cmd_caixa(playerid, "");
        // cmd_sair(playerid, "");
        // cmd_alugarsf(playerid, "");
    }

    return 1;
}

public OnPlayerDisconnect(playerid, reason) {
    for (new l = 0; l <= 10; l++) {
        PlayerTextDrawHide(playerid, PlayerText:ConceTXD[playerid][l]);
    }
    return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    new str[90];
    if(playertextid == ConceTXD[playerid][1])
    {
        format(str, sizeof(str), "Este %s custa %d, deseja comprar?");
        ShowPlayerDialog(playerid, DIALOG_SPAWN_CONCE, DIALOG_STYLE_MSGBOX, str, "Comprar", "Cancelar");
        // finalizar esse sistema depois
    }
    return 1;
}




CMD:cv(playerid, params[]) {
    new veiculo, vid, Float:x, Float:y, Float:z, Float:r;
    veiculo = strval(params[0]);
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, r);
    vid = CreateVehicle(veiculo, x, y, z, r, -1, -1, 0, 0);
    PutPlayerInVehicle(playerid, vid, 0);
    return 1;
}

stock pName(playerid) {
    new nome[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nome, sizeof(nome));
    return nome;
}

CMD:tp(playerid, params[]) {
    SetPlayerPos(playerid, 1766.7963, -1178.8922, 23.8313);
    return 1;
}

CMD:kill(playerid, params[]) {
    SetPlayerHealth(playerid, -0);
    return 1;
}

CMD:lojadearmas(playerid, params[]) {
    // ShowMenuForPlayer(Menu:menuid, playerid);
    return 1;
}
CMD:som(playerid, params[]) {
    new Float:x, Float:y, Float:z, sound;
    GetPlayerPos(playerid, x, y, z);
    sound = strval(params[0]);
    PlayerPlaySound(playerid, sound, x, y, z);
    return 1;
}

CMD:skin(playerid, params[]) {
    new skinid = strval(params[0]);
    SetPlayerSkin(playerid, skinid);
    return 1;
}

CMD:carrosom(playerid, params[]) {
    new Float:P[3], vid;
    if (!IsPlayerInAnyVehicle(playerid)) return 0;
    vid = GetPlayerVehicleID(playerid);
    GetVehiclePos(vid, P[0], P[1], P[2]);
    PlayAudioStreamForPlayer(playerid, "https://server1.mtabrasil.com.br/youtube/play?id=INDnA8xUKVE", P[0], P[1], P[2], 50, 1);
    return 1;
}
CMD:tpconce(playerid, params[]) {
    SetPlayerPos(playerid, 2131.4729, -1149.9431, 24.2078);
    return 1;
}
CMD:dinteste(playerid, params[]) {
    GivePlayerMoney(playerid, 200000);
    return 1;
}

CMD:txdon(playerid, params[]) {
    for (new l = 0; l <= 10; l++) {
        PlayerTextDrawShow(playerid, PlayerText:ConceTXD[playerid][l]);
    }
    SelectTextDraw(playerid, COR_VERMELHO);
    TogglePlayerControllable(playerid, 0);
    return 1;
}

CMD:txdoff(playerid, params[]) {
    for (new l = 0; l <= 10; l++) {
        PlayerTextDrawHide(playerid, PlayerText:ConceTXD[playerid][l]);
    }
    TogglePlayerControllable(playerid, 1);
    return 1;
}