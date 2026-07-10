U0 UpdateCursor()
{
  if(g_tileMenu)
    return;

  if(current_map.mapArray == NULL)
    return;



  if(keys.space)
  {
    I64 posX = cursor.pos.x / 24;
    I64 posY = cursor.pos.y / 24;
    if(!g_entityMode)
      current_map.mapArray[posX + posY * current_map.width] = g_tileIndex;
    else
      current_map.entArray[posX + posY * current_map.width] = g_tileIndex;

  }


  if(keys.left)
  {
    cursor.pos.x -= 24;
    keys.left = FALSE;
  }


  if(keys.right)
  {
    cursor.pos.x += 24;
    keys.right = FALSE;
  }

  if(keys.up)
  {
    cursor.pos.y -= 24;
    keys.up = FALSE;
  }

  if(keys.down)
  {
    cursor.pos.y += 24;
    keys.down = FALSE;
  }

  I64 max_pos_x = (current_map.width - 1) * 24;
  I64 max_pos_y = (current_map.height - 1) * 24;

  if(cursor.pos.x < 0) cursor.pos.x = 0;
  if(cursor.pos.x > max_pos_x) cursor.pos.x = max_pos_x;
  if(cursor.pos.y < 0) cursor.pos.y = 0;
  if(cursor.pos.y > max_pos_y) cursor.pos.y = max_pos_y;
}

U0 UpdateTileMenu()
{
  if(!g_tileMenu)
    return;
  I64 itemCount;
  if(g_entityMode)
    itemCount = QueCnt(&entitem_que) - 1;
  else
    itemCount = QueCnt(&tileitem_que) - 1;
  if(keys.left)
    g_tileIndex--;
    keys.left = FALSE;
  if(keys.right)
    g_tileIndex++;
    keys.right = FALSE;

  if(g_tileIndex < 0)
  {
    g_tileIndex = 0;
  }  

  if(g_tileIndex > itemCount)
  {
    g_tileIndex = itemCount;
  }

  if(keys.space)
  {
    g_tileIndex = 0;
    g_entityMode = !g_entityMode;
    keys.space = FALSE;
  }

}

U0 UpdateCamOffset()
{
  camOffset.x = cursor.pos.x - 320;
  camOffset.y = cursor.pos.y - 240;
}



