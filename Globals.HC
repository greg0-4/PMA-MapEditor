Bool g_Gaming = TRUE;

class Keys
{
  Bool up,down,left,right;
  Bool space;
} keys;

class Vector2
{
  F64 x,y;
};

class Cursor
{
  Vector2 pos;
} cursor;

Bool g_entityMode;
Bool g_tileMenu;
Bool g_tileEntity;
I64 g_tileIndex;

Vector2 camOffset;

class Map
{
  I64 *mapArray;
  I64 *entArray;
  I64 width;
  I64 height;
} current_map;

class TileItem : CQue
{
  I64 index;
  Bool isEntity;
  I64 page;
  CDC *curSprite;
} tileitem_que;

TileItem entitem_que;

TileItem *NewTileItem(I64 index, CDC *sprite, Bool entity = FALSE, I64 page = 1)
{
  TileItem *new = CAlloc(sizeof(TileItem));
  new->index = index;
  new->isEntity = entity;
  new->curSprite = sprite;
  new->page = page;
  if(!entity)
    QueIns(new, tileitem_que);
  else
    QueIns(new, entitem_que);
  return new;
}

U0 DelTileItem(TileItem *a)
{
  QueRem(a);
  Free(a);
}

U0 InitTileItems()
{
  NewTileItem(0, tex_Tile_NoTile);
  NewTileItem(1, tex_Tile);


  NewTileItem(0, tex_Tile_NoTile, TRUE);
  NewTileItem(1, tex_Ent_Collider, TRUE);
  NewTileItem(2, tex_Ent_Player, TRUE);
  NewTileItem(3, tex_Ent_Slug, TRUE);
  NewTileItem(4, tex_Ent_Turtle, TRUE);
  NewTileItem(5, tex_Ent_Shroom, TRUE);
  NewTileItem(6, tex_Ent_Brick, TRUE);
  NewTileItem(7, tex_Ent_Question, TRUE);
  NewTileItem(8, tex_Ent_QuestionHidden, TRUE);
  NewTileItem(9, tex_Ent_QuestionPowerup, TRUE);
  NewTileItem(10, tex_Ent_Coin, TRUE);
}


U0 Init()
{
  QueInit(&tileitem_que);
  QueInit(&entitem_que);
  InitTileItems;
  keys.up = FALSE;
  keys.down = FALSE;
  keys.left = FALSE;
  keys.right = FALSE;
  keys.space = FALSE;
}

U0 InitMapArrays()
{
  I64 width = current_map.width;
  I64 height = current_map.height;
  current_map.mapArray = CAlloc(width * height * sizeof(I64));
  current_map.entArray = CAlloc(width * height * sizeof(I64));
  I64 x;
  for(x=0;x<width;x++)
  {
    if(height - 2 > 0)
    {
      current_map.mapArray[x + (height - 2) * width] = 1;
      current_map.entArray[x + (height - 2) * width] = 1;

    }
    current_map.mapArray[x + (height - 1) * width] = 1;
    current_map.entArray[x + (height - 1) * width] = 1;
  }
}
