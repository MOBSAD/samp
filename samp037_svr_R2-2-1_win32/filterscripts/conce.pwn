#include <a_samp>
#include <Dini>
#include <zcmd>
#include <sscanf2>

#define PATH "Players"

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

new SVCarPLAYER[MAX_PLAYERS];
new BuyCarCk[MAX_VEHICLES];

public OnFilterScriptInit() {
    print("\n ====================================================================");
    print(" |                                                                    |");
    print(" |        FilterScript Concessionaria dini Versao 1.0 iniciado...     |");
    print(" |                                                                    |");
    print(" |                          * Creator:Vict9r . *                      |");
    print(" |                         * Melhorias: MOBSAD.*                      |");
    print(" |                                                                    |");
    print(" ====================================================================\n");
    //========[ Concessionaria ]======||
    AddStaticPickup(1274, 1, 2131.4729, -1149.9431, 24.2078);
    Create3DTextLabel("Concessionaria (LS)\n/conce", COR_AZULCLARO, 2131.4729, -1149.9431, 24.2078, 30.0, 0);
    return 1;
}

public OnFilterScriptExit() {
    return 1;
}

public OnPlayerConnect(playerid) {
    DestroyVehicle(SVCarPLAYER[playerid]);
    SVCarPLAYER[playerid] = 0;
    BuyCarCk[playerid] = 0;
    return 1;
}

public OnPlayerDisconnect(playerid, reason) {
    DestroyVehicle(SVCarPLAYER[playerid]);
    return 1;
}

CMD:conce(playerid, params[]) {
    new item[16];
    new DIALOGCONCE[550], string[250];
    if (!sscanf(params, "s[550]", item)) {
        if (strcmp(item, "462", true) == 0) {
            if (IsPlayerInRangeOfPoint(playerid, 7.0, 2131.4729, -1149.9431, 24.2078)) // 24/7
            {
                if (GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid, -1, "Voce nao tem R$5000.");
                DestroyVehicle(SVCarPLAYER[playerid]);
                GivePlayerMoney(playerid, -5000);
                SVCarPLAYER[playerid] = AddStaticVehicleEx(462, 2124.9561, -1132.2983, 25.4612 + 5.0, 350.3899, 0, 0, -1);
                BuyCarCk[SVCarPLAYER[playerid]] = playerid;
                SendClientMessage(playerid, 0xFF0000FF, "Veiculo Comprado com sucesso!");
                return 1;
            }
        } else if (strcmp(item, "463", true) == 0) {
            if (IsPlayerInRangeOfPoint(playerid, 7.0, 2131.4729, -1149.9431, 24.2078)) // 24/7
            {
                if (GetPlayerMoney(playerid) < 10500) return SendClientMessage(playerid, -1, "Voce nao tem R$10500.");
                DestroyVehicle(SVCarPLAYER[playerid]);
                GivePlayerMoney(playerid, -10500);
                SVCarPLAYER[playerid] = AddStaticVehicleEx(463, 2124.9561, -1132.2983, 25.4612 + 5.0, 350.3899, 0, 0, -1);
                BuyCarCk[SVCarPLAYER[playerid]] = playerid;
                SendClientMessage(playerid, 0xFF0000FF, "Veiculo Comprado com sucesso!");
                return 1;
            }
        } else if (strcmp(item, "468", true) == 0) {
            if (IsPlayerInRangeOfPoint(playerid, 7.0, 2131.4729, -1149.9431, 24.2078)) // 24/7
            {
                if (GetPlayerMoney(playerid) < 45000) return SendClientMessage(playerid, -1, "Voce nao tem R$45000.");
                DestroyVehicle(SVCarPLAYER[playerid]);
                GivePlayerMoney(playerid, -45000);
                SVCarPLAYER[playerid] = AddStaticVehicleEx(468, 2124.9561, -1132.2983, 25.4612 + 5.0, 350.3899, 0, 0, -1);
                BuyCarCk[SVCarPLAYER[playerid]] = playerid;
                SendClientMessage(playerid, 0xFF0000FF, "Veiculo Comprado com sucesso!");
                return 1;
            }
        } else if (strcmp(item, "410", true) == 0) {
            if (IsPlayerInRangeOfPoint(playerid, 7.0, 2131.4729, -1149.9431, 24.2078)) // 24/7
            {
                if (GetPlayerMoney(playerid) < 25000) return SendClientMessage(playerid, -1, "Voce nao tem R$25000.");
                DestroyVehicle(SVCarPLAYER[playerid]);
                GivePlayerMoney(playerid, -25000);
                SVCarPLAYER[playerid] = AddStaticVehicleEx(410, 2124.9561, -1132.2983, 25.4612 + 5.0, 350.3899, 0, 0, -1);
                BuyCarCk[SVCarPLAYER[playerid]] = playerid;
                SendClientMessage(playerid, 0xFF0000FF, "Veiculo Comprado com sucesso!");
                return 1;
            }
        } else if (strcmp(item, "412", true) == 0) {
            if (IsPlayerInRangeOfPoint(playerid, 7.0, 2131.4729, -1149.9431, 24.2078)) // 24/7
            {
                if (GetPlayerMoney(playerid) < 30000) return SendClientMessage(playerid, -1, "Voce nao tem R$30000.");
                DestroyVehicle(SVCarPLAYER[playerid]);
                GivePlayerMoney(playerid, -30000);
                SVCarPLAYER[playerid] = AddStaticVehicleEx(412, 2124.9561, -1132.2983, 25.4612 + 5.0, 350.3899, 0, 0, -1);
                BuyCarCk[SVCarPLAYER[playerid]] = playerid;
                SendClientMessage(playerid, 0xFF0000FF, "Veiculo Comprado com sucesso!");
                return 1;
            }
        } else if (strcmp(item, "415", true) == 0) {
            if (IsPlayerInRangeOfPoint(playerid, 7.0, 2131.4729, -1149.9431, 24.2078)) // 24/7
            {
                if (GetPlayerMoney(playerid) < 45000) return SendClientMessage(playerid, -1, "Voce nao tem R$45000.");
                DestroyVehicle(SVCarPLAYER[playerid]);
                GivePlayerMoney(playerid, -45000);
                SVCarPLAYER[playerid] = AddStaticVehicleEx(415, 2124.9561, -1132.2983, 25.4612 + 5.0, 350.3899, 0, 0, -1);
                BuyCarCk[SVCarPLAYER[playerid]] = playerid;
                SendClientMessage(playerid, 0xFF0000FF, "Veiculo Comprado com sucesso!");
                return 1;
            }
        }
        SendClientMessage(playerid, -1, "Esse veiculo nao esta disponivel na concessionaria!!");
        return 1;
    }
    format(string, sizeof(string), "{FFFFFF}De /conce [ID DO VEICULO!] para comprar\n\n");
    strcat(DIALOGCONCE, string);
    format(string, sizeof(string), "462 - Faggio ({00CC00}R$5000{FFFFFF})\n");
    strcat(DIALOGCONCE, string);
    format(string, sizeof(string), "463 - Freeway ({00CC00}R$10500{FFFFFF})\n");
    strcat(DIALOGCONCE, string);
    format(string, sizeof(string), "468 - Sanchez ({00CC00}R$45000{FFFFFF})\n");
    strcat(DIALOGCONCE, string);
    format(string, sizeof(string), "410 - Manana ({00CC00}R$25000{FFFFFF})\n");
    strcat(DIALOGCONCE, string);
    format(string, sizeof(string), "412 - Voodoo ({00CC00}R$30000{FFFFFF})\n");
    strcat(DIALOGCONCE, string);
    format(string, sizeof(string), "415 - Cheetah ({00CC00}R$45000{FFFFFF})\n");
    strcat(DIALOGCONCE, string);
    ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_MSGBOX, "Model Veiculos", DIALOGCONCE, "OK", "Sair");
    return 1;
}

CMD:estacionar(playerid, params[]) {
    if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Você não está em um carro!");
    new path[50], SCCarid, Float:PosSC[4];
    SCCarid = GetPlayerVehicleID(playerid);
    if (BuyCarCk[SCCarid] != playerid) return SendClientMessage(playerid, 0xFF0000FF, "Este carro não é seu, ou não foi comprado!");
    path = SaveCarNomePlay(playerid);
    if (!dini_Exists(path)) dini_Create(path);
    GetVehiclePos(SCCarid, PosSC[0], PosSC[1], PosSC[2]);
    GetVehicleZAngle(SCCarid, PosSC[3]);
    dini_IntSet(path, "CarID", GetVehicleModel(GetPlayerVehicleID(playerid)));
    dini_FloatSet(path, "VPosX", PosSC[0]);
    dini_FloatSet(path, "VPosY", PosSC[1]);
    dini_FloatSet(path, "VPosZ", PosSC[2]);
    dini_FloatSet(path, "VPosA", PosSC[3]);
    DestroyVehicle(SVCarPLAYER[playerid]);
    SVCarPLAYER[playerid] = 0;
    BuyCarCk[playerid] = 0;
    SendClientMessage(playerid, 0xFF0000FF, "Veiculo estacionado, de /pegarcarro para spawnar ele novamente!");
    return 1;
}

CMD:pegarcarro(playerid, params[]) {
    if (SVCarPLAYER[playerid] != 0) return SendClientMessage(playerid, 0xFF0000FF, "você ja pegou o seu carro!");
    new path[50], SCCarid, Float:PosSC[4];
    path = SaveCarNomePlay(playerid);
    SCCarid = dini_Int(path, "CarID");
    PosSC[0] = dini_Float(path, "VPosX");
    PosSC[1] = dini_Float(path, "VPosY");
    PosSC[2] = dini_Float(path, "VPosZ");
    PosSC[3] = dini_Float(path, "VPosA");
    DestroyVehicle(SVCarPLAYER[playerid]);
    SVCarPLAYER[playerid] = AddStaticVehicleEx(SCCarid, PosSC[0], PosSC[1], PosSC[2], PosSC[3], 0, 0, -1);
    BuyCarCk[SVCarPLAYER[playerid]] = playerid;
    SetPlayerCheckpoint(playerid, PosSC[0], PosSC[1], PosSC[2], 3.0);
    SendClientMessage(playerid, 0xFF0000FF, "Seu carro está no local estacionado!");
    return 1;
}

SaveCarNomePlay(playerid) {
    new name[24], full[50];
    GetPlayerName(playerid, name, sizeof(name));
    format(full, sizeof(full), "%s/%s.txt", PATH, name);
    return full;
}