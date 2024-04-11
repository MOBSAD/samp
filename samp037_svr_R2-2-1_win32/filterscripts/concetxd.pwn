

new PlayerText:ConceTXD[MAX_PLAYERS][10];

ConceTXD[playerid][0] = CreatePlayerTextDraw(playerid, 350.000000, 140.000000, "box");
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

ConceTXD[playerid][1] = CreatePlayerTextDraw(playerid, 227.000000, 154.000000, "");
PlayerTextDrawTextSize(playerid, ConceTXD[playerid][1], 80.000000, 80.000000);
PlayerTextDrawAlignment(playerid, ConceTXD[playerid][1], 1);
PlayerTextDrawColor(playerid, ConceTXD[playerid][1], -1);
PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][1], 0);
PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][1], 255);
PlayerTextDrawFont(playerid, ConceTXD[playerid][1], 5);
PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][1], 0);
PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][1], true);
PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][1], 0);
PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][1], 0.000000, 0.000000, 0.000000, 1.000000);

ConceTXD[playerid][2] = CreatePlayerTextDraw(playerid, 308.000000, 154.000000, "");
PlayerTextDrawTextSize(playerid, ConceTXD[playerid][2], 80.000000, 80.000000);
PlayerTextDrawAlignment(playerid, ConceTXD[playerid][2], 1);
PlayerTextDrawColor(playerid, ConceTXD[playerid][2], -1);
PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][2], 0);
PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][2], 255);
PlayerTextDrawFont(playerid, ConceTXD[playerid][2], 5);
PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][2], 0);
PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][2], true);
PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][2], 0);
PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

ConceTXD[playerid][3] = CreatePlayerTextDraw(playerid, 389.000000, 154.000000, "");
PlayerTextDrawTextSize(playerid, ConceTXD[playerid][3], 80.000000, 80.000000);
PlayerTextDrawAlignment(playerid, ConceTXD[playerid][3], 1);
PlayerTextDrawColor(playerid, ConceTXD[playerid][3], -1);
PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][3], 0);
PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][3], 255);
PlayerTextDrawFont(playerid, ConceTXD[playerid][3], 5);
PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][3], 0);
PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][3], true);
PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][3], 0);
PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

ConceTXD[playerid][4] = CreatePlayerTextDraw(playerid, 227.000000, 235.000000, "");
PlayerTextDrawTextSize(playerid, ConceTXD[playerid][4], 80.000000, 80.000000);
PlayerTextDrawAlignment(playerid, ConceTXD[playerid][4], 1);
PlayerTextDrawColor(playerid, ConceTXD[playerid][4], -1);
PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][4], 0);
PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][4], 255);
PlayerTextDrawFont(playerid, ConceTXD[playerid][4], 5);
PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][4], 0);
PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][4], true);
PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][4], 0);
PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

ConceTXD[playerid][5] = CreatePlayerTextDraw(playerid, 308.000000, 235.000000, "");
PlayerTextDrawTextSize(playerid, ConceTXD[playerid][5], 80.000000, 80.000000);
PlayerTextDrawAlignment(playerid, ConceTXD[playerid][5], 1);
PlayerTextDrawColor(playerid, ConceTXD[playerid][5], -1);
PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][5], 0);
PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][5], 255);
PlayerTextDrawFont(playerid, ConceTXD[playerid][5], 5);
PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][5], 0);
PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][5], true);
PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][5], 0);
PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

ConceTXD[playerid][6] = CreatePlayerTextDraw(playerid, 389.000000, 235.000000, "");
PlayerTextDrawTextSize(playerid, ConceTXD[playerid][6], 80.000000, 80.000000);
PlayerTextDrawAlignment(playerid, ConceTXD[playerid][6], 1);
PlayerTextDrawColor(playerid, ConceTXD[playerid][6], -1);
PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][6], 0);
PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][6], 255);
PlayerTextDrawFont(playerid, ConceTXD[playerid][6], 5);
PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][6], 0);
PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][6], true);
PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][6], 0);
PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

ConceTXD[playerid][7] = CreatePlayerTextDraw(playerid, 227.000000, 316.000000, "");
PlayerTextDrawTextSize(playerid, ConceTXD[playerid][7], 80.000000, 80.000000);
PlayerTextDrawAlignment(playerid, ConceTXD[playerid][7], 1);
PlayerTextDrawColor(playerid, ConceTXD[playerid][7], -1);
PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][7], 0);
PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][7], 255);
PlayerTextDrawFont(playerid, ConceTXD[playerid][7], 5);
PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][7], 0);
PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][7], true);
PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][7], 0);
PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][7], 0.000000, 0.000000, 0.000000, 1.000000);

ConceTXD[playerid][8] = CreatePlayerTextDraw(playerid, 308.000000, 316.000000, "");
PlayerTextDrawTextSize(playerid, ConceTXD[playerid][8], 80.000000, 80.000000);
PlayerTextDrawAlignment(playerid, ConceTXD[playerid][8], 1);
PlayerTextDrawColor(playerid, ConceTXD[playerid][8], -1);
PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][8], 0);
PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][8], 255);
PlayerTextDrawFont(playerid, ConceTXD[playerid][8], 5);
PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][8], 0);
PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][8], true);
PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][8], 0);
PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][8], 0.000000, 0.000000, 0.000000, 1.000000);

ConceTXD[playerid][9] = CreatePlayerTextDraw(playerid, 389.000000, 316.000000, "");
PlayerTextDrawTextSize(playerid, ConceTXD[playerid][9], 80.000000, 80.000000);
PlayerTextDrawAlignment(playerid, ConceTXD[playerid][9], 1);
PlayerTextDrawColor(playerid, ConceTXD[playerid][9], -1);
PlayerTextDrawSetShadow(playerid, ConceTXD[playerid][9], 0);
PlayerTextDrawBackgroundColor(playerid, ConceTXD[playerid][9], 255);
PlayerTextDrawFont(playerid, ConceTXD[playerid][9], 5);
PlayerTextDrawSetProportional(playerid, ConceTXD[playerid][9], 0);
PlayerTextDrawSetSelectable(playerid, ConceTXD[playerid][9], true);
PlayerTextDrawSetPreviewModel(playerid, ConceTXD[playerid][9], 0);
PlayerTextDrawSetPreviewRot(playerid, ConceTXD[playerid][9], 0.000000, 0.000000, 0.000000, 1.000000);