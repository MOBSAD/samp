#define FILTERSCRIPT
#include <a_samp>
#include <DOF2>
#if defined FILTERSCRIPT
/*----------------------------------------------------------------------------*/
new bool:LoadedWeapons[MAX_PLAYERS];
/*----------------------------------------------------------------------------*/
forward CarregarArmas(playerid);
forward SalvarArmas(playerid);
/*----------------------------------------------------------------------------*/
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Criado por: SkayBr [FS] Salvar Armas");
	print("--------------------------------------\n");
	return 1;
}
/*----------------------------------------------------------------------------*/
public OnFilterScriptExit()
{
    DOF2_Exit();
	return 1;
}
/*----------------------------------------------------------------------------*/
public OnPlayerDisconnect(playerid, reason)
{
    SalvarArmas(playerid);
	return 1;
}
/*----------------------------------------------------------------------------*/
public OnPlayerSpawn(playerid)
{
	if(LoadedWeapons[playerid]) CarregarArmas(playerid);
	return 1;
}
/*----------------------------------------------------------------------------*/
public SalvarArmas(playerid) // *PUBLIC CRIADA* //
{
    /*-----------------------------------------*/
	new Slot,Bala,Local[200],Slot1[20],Bala1[20];
	/*-----------------------------------------*/
    Local = PachWeapon(playerid);
    /*-----------------------------------------*/
    //
    if(!DOF2_FileExists(Local)) DOF2_CreateFile(Local); // Se nao existir o arquivo do player na pasta Weapons vai ser criado.
    //
    for(new i = 0; i < 13; i++)
	{
	    /*-----------------------------------*/
	    GetPlayerWeaponData(playerid,i,Slot,Bala);
	    /*-----------------------------------*/
		format(Slot1,sizeof(Slot1),"Slot%d",i);
	    format(Bala1,sizeof(Bala1),"Bala%d",i);
	    /*-----------------------------------*/
	    DOF2_SetInt(Local, Slot1, Slot);
		DOF2_SetInt(Local, Bala1, Bala);
		/*-----------------------------------*/
		DOF2_SaveFile();
		/*-----------------------------------*/
	}
	return 1;
}
public CarregarArmas(playerid) // *PUBLIC CRIADA* //
{
    /*-----------------------------------------*/
	new Slot,Bala,Local[200],Slot1[20],Bala1[20];
	/*-----------------------------------------*/
    Local = PachWeapon(playerid);
    /*-----------------------------------------*/
    for(new i = 0; i < 13; i++)
	{
	    /*-----------------------------------*/
	    format(Slot1,sizeof(Slot1),"Slot%d",i);
	    format(Bala1,sizeof(Bala1),"Bala%d",i);
	    /*-----------------------------------*/
	    Slot = DOF2_GetInt(Local, Slot1);
	    Bala = DOF2_GetInt(Local, Bala1);
	    /*-----------------------------------*/
	    GivePlayerWeapon(playerid, Slot, Bala);
	    /*-----------------------------------*/
	}
	return 1;
}
PachWeapon(playerid) // Responsavel por definir a pasta das armas
{
	new string[100];
	format(string, 100, "Armas/%s.ini", PlayerName(playerid));
	return string;
}
PlayerName(playerid) // Responsavel por guetar o nome do player
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	return name;
}
#endif
 