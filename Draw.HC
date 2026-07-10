
U0 DrawSky(CDC *dc)
{
  dc->dither_probability_u16=1;
  dc->color=ROPF_DITHER+LTBLUE<<16+WHITE;
  GrRect(dc,0,0, 640, 480);
  dc->color = BLACK;
}



U0 DrawMap(CDC *dc)
{
  if(current_map.mapArray == NULL)
    return;
  I64 x,y;
  dc->color = GREEN;
  for(x=0;x<current_map.width;x++)
  {
    for(y=0;y<current_map.height;y++)
    {
      I64 tile = current_map.mapArray[x + y * current_map.width];
      I64 posX = (x * 24) - camOffset.x;
      I64 posY = (y * 24) - camOffset.y;
      switch(tile)
      {
	case 1: GrBlot(dc, posX, posY, tex_Tile);
      }
    }
  }

  for(x=0;x<current_map.width;x++)
  {
    for(y=0;y<current_map.height;y++)
    {
      I64 ent = current_map.entArray[x + y * current_map.width];
      posX = (x * 24) - camOffset.x;
      posY = (y * 24) - camOffset.y;
      switch(ent)
      {
	case 1: GrBlot(dc, posX, posY, tex_Ent_Collider); break;
	case 2: GrBlot(dc, posX, posY, tex_Ent_Player); break;
	case 3: GrBlot(dc, posX, posY, tex_Ent_Slug); break;
	case 4: GrBlot(dc, posX, posY, tex_Ent_Turtle); break;
	case 5: GrBlot(dc, posX, posY, tex_Ent_Shroom); break;
	case 6: GrBlot(dc, posX, posY, tex_Ent_Brick); break;
	case 7: GrBlot(dc, posX, posY, tex_Ent_Question); break;
	case 8: GrBlot(dc, posX, posY, tex_Ent_QuestionHidden); break;
	case 9: GrBlot(dc, posX, posY, tex_Ent_QuestionPowerup); break;
	case 10: GrBlot(dc, posX, posY, tex_Ent_Coin); break;
	
	
	
      }
    }
  }
  dc->color = BLACK;
}

U0 DrawCursor(CDC *dc)
{
  if(current_map.mapArray == NULL)
    return;
  dc->dither_probability_u16=2;
  dc->color=ROPF_DITHER+DKGRAY<<16+TRANSPARENT;
  I64 posX = cursor.pos.x - camOffset.x;
  I64 posY = cursor.pos.y - camOffset.y;
  GrBlot(dc, posX, posY, tex_Cursor);
}

U0 DrawTileMenu(CDC *dc)
{
  if(!g_tileMenu)
    return;

  dc->dither_probability_u16=1;
  dc->color=ROPF_DITHER+DKGRAY<<16+BLACK;
  GrRect(dc, 0, 300, 640, 172);
  dc->color = WHITE;
  GrPrint(dc, 8, 308, "Tile menu");
  if(g_entityMode)
    GrPrint(dc, 104, 308, "Tile mode: Entities");
  else
    GrPrint(dc, 104, 308, "Tile mode: Tiles");
  if(!g_entityMode)
  {
    TileItem *temp = tileitem_que.next;
    while(temp != &tileitem_que)
    {
      TileItem *next = temp->next;
    
      if(temp->curSprite)
        GrBlot(dc, temp->index * 24 + 8, 318, temp->curSprite);
      if(g_tileIndex == temp->index)
        GrBlot(dc, temp->index * 24 + 8, 318, tex_SelectedTile);
      temp = next;
    }
  }
  else
  {
  temp = entitem_que.next;
  while(temp != &entitem_que)
  {
    next = temp->next;
    if(temp->curSprite)
      GrBlot(dc, temp->index * 24 + 8, 318, temp->curSprite);
    if(g_tileIndex == temp->index)
      GrBlot(dc, temp->index * 24 + 8, 318, tex_SelectedTile);
    temp = next;
  }
  }

  dc->color = BLACK;
  
}