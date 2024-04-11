// ========================================================================== //
/*
                    Sistema de casa By [G]uizin[CF] #7165
                         ___    _____  ___    _____
                        (  _`\ (  _  )(  _`\ (  _  )
                        | ( (_)| (_) || (_(_)| (_) |
                        | |  _ |  _  |`\__ \ |  _  |
                        | (_( )| | | |( )_) || | | |
                        (____/'(_) (_)`\____)(_) (_)

                    Sistema de casa By [G]uizin[CF] YT
*/
// ========================================================================== //
/*
        INFORMAÇÔES: Você precisa criar a pasta ("Casas") em scriptfiles ...

        COMANDOS: /gzMenu [casa] /gzCriar [casa]

        Versão: 0.0.1 [ BETA ]
*/
// ========================================================================== //
#include <A_SAMP>
#include <DOF2>
#include <SSCANF2>
#include <STREAMER>
#include <ZCMD>
// ========================================================================== //
#define DIALOG_GZCRIAR                      0
#define DIALOG_GZCRIAR_CASAID               1
#define DIALOG_GZCRIAR_CASAIX               2
#define DIALOG_GZCRIAR_CASAIY               3
#define DIALOG_GZCRIAR_CASAIZ               4
#define DIALOG_GZCRIAR_CASA_VALOR            5
#define DIALOG_GZCRIAR_CASA_ALUGUEL         6

#define VALOR_ALUGUEL                       800
#define VALOR_LUZ                           220
#define VALOR_AGUA                          120
#define MAX_CASAS                           300

#define PASTA_CASAS                         "Casas/%i.ini"
// ========================================================================== //
forward LimparChatEntrou(playerid);
// ========================================================================== //
new CasaDono[MAX_PLAYER_NAME], CasaAluguel, CasaInterior, Float:CasaX;
new Float:CasaY, Float:CasaZ, Float:CasaIX, CasaMorador[MAX_PLAYER_NAME];
new Float:CasaIY, Float:CasaIZ, /*CasaCarro,*/ CasaValor, MapIcon, Pickup;
new /*Float:CasaCX, Float:CasaCY, Float:CasaCZ, Float:CasaCA,*/ CasaID;
new /*CasaComprada, CasaAlugada,*/ Texto[1000], UsandoComando;
// ========================================================================== //
main() {

    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");

}
// ========================================================================== //
public OnGameModeInit()
{
    UsePlayerPedAnims();
    AddPlayerClass(50, 1743.1335, -1863.9971, 13.5744, 355.0605, 0, 0, 0, 0, 0, 0);
   
    for(new c; c < MAX_CASAS + 1; c++)
    {
        format(Texto, sizeof(Texto), PASTA_CASAS, c);
        
        if(DOF2::FileExists(Texto))
        {
            new Textozinho[3000];
              format(Textozinho, sizeof(Textozinho), "{00FF00}Casa de: {FFFFFF}%s\n{00FF00}Morador: {FFFFFF}%s\n{00FF00}Valor da casa: {FFFFFF}%i\n{00FF00}Valor do aluguel: {FFFFFF}%i\n{00FF00}ID do interior: {FFFFFF}%i\n{00FF00}ID da casa: {FFFFFF}%i", DOF2::GetString(Texto, "Dono"), DOF2::GetString(Texto, "Morador"), DOF2::GetInt(Texto, "Valor"), DOF2::GetInt(Texto, "Aluguel"), DOF2::GetInt(Texto, "Interior"), DOF2::GetInt(Texto, "ID"));
             Create3DTextLabel(Textozinho, 0x00FF00FF, DOF2::GetFloat(Texto, "CasaX"), DOF2::GetFloat(Texto, "CasaY"), DOF2::GetFloat(Texto, "CasaZ"), 10.0, 0, 0);
               CreateDynamicMapIcon(DOF2::GetFloat(Texto, "CasaX"), DOF2::GetFloat(Texto, "CasaY"), DOF2::GetFloat(Texto, "CasaZ"), 31, -1, -1, -1, -1, 500.0, MAPICON_LOCAL);
             CreateDynamicPickup(1273, 1, DOF2::GetFloat(Texto, "CasaX"), DOF2::GetFloat(Texto, "CasaY"), DOF2::GetFloat(Texto, "CasaZ"), -1, -1, -1, 100.0, STREAMER_TAG_AREA);
        }
    }
    return 1;
}

public OnGameModeExit()
{
    DOF2::Exit();
    return 1;
}

public OnPlayerConnect(playerid)
{
    SetTimerEx("LimparChatEntrou", 1000, false, "i", playerid);
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_GZCRIAR)
    {
        if(response)
        {
            if(listitem == 0)
            {
                if(UsandoComando == 1) return SendClientMessage(playerid, 0xEE3B3BFF, "** Já existe alguém criando uma casa no momento !");
                ShowPlayerDialog(playerid, DIALOG_GZCRIAR_CASAID, DIALOG_STYLE_INPUT, "{00FF00}GZMenu - Casa", "{FFFFFF}Informe o (ID) do interior da casa:", "Confirmar", "Cancelar");
                UsandoComando = 1;
            }
        }
    }
    
    if(dialogid == DIALOG_GZCRIAR_CASAID)
    {
        if(response)
        {
            if(strval(inputtext))
            {
                ShowPlayerDialog(playerid, DIALOG_GZCRIAR_CASAIX, DIALOG_STYLE_INPUT, "{00FF00}GZMenu - Casa", "{FFFFFF}Informe a coordenada X do interior da casa", "Confirmar", "Cancelar");
                CasaInterior = strval(inputtext);
                CasaDono = "Ninguem";
                CasaMorador = "Ninguem";
            }
            
            if(!strval(inputtext))
            {
                ShowPlayerDialog(playerid, DIALOG_GZCRIAR_CASAID, DIALOG_STYLE_INPUT, "{00FF00}GZMenu - Casa", "{FFFFFF}Informe o (ID) do interior da casa:", "Confirmar", "Cancelar");
                SendClientMessage(playerid, 0xEE3B3BFF, "** Digite apenas números !");
            }
        }
       
        if(!response)
        {
            UsandoComando = 0;
        }
    }
    
    if(dialogid == DIALOG_GZCRIAR_CASAIX)
    {
        if(response)
        {
            if(strval(inputtext))
            {
                ShowPlayerDialog(playerid, DIALOG_GZCRIAR_CASAIY, DIALOG_STYLE_INPUT, "{00FF00}GZMenu - Casa", "{FFFFFF}Informe a coordenada Y do interior da casa", "Confirmar", "Cancelar");
                CasaIX = strval(inputtext);
            }
           
            if(!strval(inputtext))
            {
                ShowPlayerDialog(playerid, DIALOG_GZCRIAR_CASAIX, DIALOG_STYLE_INPUT, "{00FF00}GZMenu - Casa", "{FFFFFF}Informe a coordenada X do interior da casa", "Confirmar", "Cancelar");
                SendClientMessage(playerid, 0xEE3B3BFF, "** Digite apenas números !");
            }
        }
        
        if(!response)
        {
            UsandoComando = 0;
        }
    }
    
    if(dialogid == DIALOG_GZCRIAR_CASAIY)
    {
        if(response)
        {
              ShowPlayerDialog(playerid, DIALOG_GZCRIAR_CASAIZ, DIALOG_STYLE_INPUT, "{00FF00}GZMenu - Casa", "{FFFFFF}Informe a coordenada Z do interior da casa", "Confirmar", "Cancelar");
             CasaIY = strval(inputtext);
        }

        if(!response)
        {
            UsandoComando = 0;
        }
    }
    
    if(dialogid == DIALOG_GZCRIAR_CASAIZ)
    {
        if(response)
        {
            ShowPlayerDialog(playerid, DIALOG_GZCRIAR_CASA_VALOR, DIALOG_STYLE_INPUT, "{00FF00}GZMenu - Casa", "{FFFFFF}Informe o valor da casa", "Confirmar", "Cancelar");
            CasaIZ = strval(inputtext);
        }

        if(!response)
        {
            UsandoComando = 0;
        }
    }
    
    if(dialogid == DIALOG_GZCRIAR_CASA_VALOR)
    {
        if(response)
        {
            ShowPlayerDialog(playerid, DIALOG_GZCRIAR_CASA_ALUGUEL, DIALOG_STYLE_INPUT, "{00FF00}GZMenu - Casa", "{FFFFFF}Informe o valor do aluguel da casa", "Confirmar", "Cancelar");
            CasaValor = strval(inputtext);
        }

        if(!response)
        {
            UsandoComando = 0;
        }
    }
    
    if(dialogid == DIALOG_GZCRIAR_CASA_ALUGUEL)
    {
        if(response)
        {
            if(strval(inputtext))
            {
                   CasaAluguel = strval(inputtext);
                   
                   for(new c; c < MAX_CASAS + 1; c++)
                   {
                       format(Texto, sizeof(Texto), PASTA_CASAS, c);
                    if(!DOF2::FileExists(Texto))
                       {
                           new Float:Pos[3], Textozinho[3000];
                           GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
                           CasaID = c;
                          
                           format(Textozinho, sizeof(Textozinho), "** Você criou uma casa de id %i", CasaID);
                           SendClientMessage(playerid, 0x00FF00AA, Textozinho);
                          
                           CasaX = Pos[0];
                           CasaY = Pos[1];
                           CasaZ = Pos[2];
                          
                           DOF2::CreateFile(Texto);
                          
                           DOF2::SetString(Texto, "Dono", CasaDono);
                           DOF2::SetString(Texto, "Morador", CasaMorador);
                          
                           DOF2::SetInt(Texto, "Valor", CasaValor);
                           DOF2::SetInt(Texto, "Aluguel", CasaAluguel);
                           DOF2::SetInt(Texto, "Interior", CasaInterior);
                           DOF2::SetInt(Texto, "MapIcon", MapIcon);
                           DOF2::SetInt(Texto, "Pickup", Pickup);
                          
                           DOF2::SetFloat(Texto, "CasaX", CasaX);
                           DOF2::SetFloat(Texto, "CasaY", CasaY);
                           DOF2::SetFloat(Texto, "CasaZ", CasaZ);
                           DOF2::SetFloat(Texto, "CasaIX", CasaIX);
                           DOF2::SetFloat(Texto, "CasaIY", CasaIY);
                           DOF2::SetFloat(Texto, "CasaIZ", CasaIZ);

                           DOF2::SaveFile();
                          
                           format(Textozinho, sizeof(Textozinho), "{00FF00}Casa de: {FFFFFF}%s\n{00FF00}Morador: {FFFFFF}%s\n{00FF00}Valor da casa: {FFFFFF}%i\n{00FF00}Valor do aluguel: {FFFFFF}%i\n{00FF00}ID do interior: {FFFFFF}%i\n{00FF00}ID da casa: {FFFFFF}%i", CasaDono, CasaMorador, CasaValor, CasaAluguel, CasaInterior, CasaID);
                        Create3DTextLabel(Textozinho, 0x00FF00FF, Pos[0], Pos[1], Pos[2], 10.0, 0, 0);
                        MapIcon = CreateDynamicMapIcon(Pos[0], Pos[1], Pos[2], 31, -1, -1, -1, -1, 500.0, MAPICON_LOCAL);
                        Pickup = CreateDynamicPickup(1273, 1, Pos[0], Pos[1], Pos[2], -1, -1, -1, 100.0, STREAMER_TAG_AREA);
                           UsandoComando = 0;
                          
                           CasaDono = "Ninguem";
                           CasaMorador = "Ninguem";
                          
                        CasaValor = 0;
                        CasaAluguel = 0;
                        CasaInterior = 0;
                        MapIcon = 0;
                        Pickup = 0;
                        
                        CasaX = 0;
                        CasaY = 0;
                        CasaZ = 0;
                        CasaIX = 0;
                        CasaIY = 0;
                        CasaIZ = 0;
                           return 1;
                       }
                   }
            }

            if(!strval(inputtext))
            {
                ShowPlayerDialog(playerid, DIALOG_GZCRIAR_CASA_ALUGUEL, DIALOG_STYLE_INPUT, "{00FF00}GZMenu - Casa", "{FFFFFF}Informe o valor do aluguel da casa", "Confirmar", "Cancelar");
                SendClientMessage(playerid, 0xEE3B3BFF, "** Digite apenas números !");
            }
        }

        if(!response)
        {
            UsandoComando = 0;
        }
    }
    

    
    return 1;
}

public LimparChatEntrou(playerid)
{
    LimparChat(playerid);
    SendClientMessage(playerid, 0x436EEEFF, "** Digite /gzComandos para ver os comandos do sistema de casas");
    return 1;
}
// ========================================================================== //
stock pNome(playerid)
{
    new nomi[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomi, sizeof(nomi));
    return nomi;
}

stock pArquivo(playerid)
{
    new arquivo[100];
    format(arquivo, sizeof(arquivo), PASTA_CASAS, pNome(playerid));
    return arquivo;
}

stock LimparChat(playerid)
{
    for(new i; i < 100; i++)
    {
        SendClientMessage(playerid, -1, "  ");
    }
    
    return 1;
}
// ========================================================================== //
CMD:gzcomandos(playerid)
{
    LimparChat(playerid);
    SendClientMessage(playerid, 0x000000FF, "=x=x=x=x=x=x=x=x=x=x=x [ {FFFFFF}SISTEMA DE CASAS {000000}] =x=x=x=x=x=x=x=x=x=x=x");
    SendClientMessage(playerid, 0x1E90FFFF, "| /gzMenu  [casa]                                                                   ");
       SendClientMessage(playerid, 0x000000FF, "=x=x=x=x=x=x=x=x=x=x=x [ {FFFFFF}SISTEMA DE CASAS {000000}] =x=x=x=x=x=x=x=x=x=x=x");
    return 1;
}

CMD:gzmenu(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xEE3B3BFF, "** Apenas RCON'S tem permissão para utilizar este comando !");
    if(isnull(params)) return SendClientMessage(playerid, 0xEE3B3BFF, "** Digite o comando de forma correta ! /gzMenu [casa]");
    
    if(strcmp(params, "casa", true) == 0)
    {
        ShowPlayerDialog(playerid, DIALOG_GZCRIAR, DIALOG_STYLE_TABLIST, "{00FF00}GZMenu - Casa", "{FFFFFF}Criar casa \t({00FF00}Cria uma casa{FFFFFF})", "Confirmar", "Cancelar");
    }
    
    return 1;
}

CMD:entrar(playerid, params[])
{
    for(new c; c < MAX_CASAS + 1; c++)
    {
        format(Texto, sizeof(Texto), PASTA_CASAS, c);
        if(DOF2::FileExists(Texto))
        {
       
            if(IsPlayerInRangeOfPoint(playerid, 1.0, DOF2::GetFloat(Texto, "CasaX"), DOF2::GetFloat(Texto, "CasaY"), DOF2::GetFloat(Texto, "CasaZ")))
            {
                SetPlayerInterior(playerid, DOF2::GetInt(Texto, "Interior"));
                SetPlayerPos(playerid, DOF2::GetFloat(Texto, "CasaIX"), DOF2::GetFloat(Texto, "CasaIY"), DOF2::GetFloat(Texto, "CasaIZ"));
            }
        }
    }
    
    return 1;
}

CMD:sair(playerid, params[])
{
    for(new c; c < MAX_CASAS + 1; c++)
    {
        format(Texto, sizeof(Texto), PASTA_CASAS, c);
        if(DOF2::FileExists(Texto))
        {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, DOF2::GetFloat(Texto, "CasaIX"), DOF2::GetFloat(Texto, "CasaIY"), DOF2::GetFloat(Texto, "CasaIZ")))
            {
                SetPlayerInterior(playerid, 0);
                SetPlayerPos(playerid, DOF2::GetFloat(Texto, "CasaX"), DOF2::GetFloat(Texto, "CasaY"), DOF2::GetFloat(Texto, "CasaZ"));
            }
        }
    }

    return 1;
}