Bool g_Gaming = TRUE;

class Keys
{
  Bool up,down,left,right;
} keys;

class Vector2
{
  F64 x,y;
};

class Cursor
{
  Vector2 pos;
};

class SaveForm
{
  U8 *directory format "$$DA+M,A=\"Directory:\"$$";
};

class MapForm
{
  I64 width format "$$DA,A=\"Map Width:%d\"$$\n";
  I64 height format "$$DA,A=\"Map Height:%d\"$$";
};

U0 Init()
{
  keys.up = FALSE;
  keys.down = FALSE;
  keys.left = FALSE;
  keys.right = FALSE;
}

U0 MapFormFunc()
{
  MapForm newForm;
  newForm.width = 20;
  newForm.height = 20;
  if(DocForm(&newForm))
  {
    "\nForm output: [%d] [%d]\n",newForm.width,newForm.height;
  }
  else
  {
    "\nCancel";
  }
}

U0 SaveFormFunc()
{
  SaveForm newForm;
  newForm.directory = NULL;
  if(DocForm(&newForm))
  {
    g_Gaming = FALSE;
    "\nForm output\n %s\n",newForm.directory;
  }
  else
  {
    "Cancel\n";
  }
  Free(newForm.directory); 
}