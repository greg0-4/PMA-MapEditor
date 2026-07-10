class SaveForm
{
  U8 *directory format "$$DA+M,A=\"Directory:\"$$";
};

class MapForm
{
  I64 width format "$$DA,A=\"Map Width:%d\"$$\n";
  I64 height format "$$DA,A=\"Map Height:%d\"$$";
};

U0 MapFormFunc()
{
  Fs->draw_it = NULL;
  MapForm newForm;
  newForm.width = 20;
  newForm.height = 20;
  if(DocForm(&newForm))
  {
     current_map.width = newForm.width;
     current_map.height = newForm.height;
     InitMapArrays;
  }
  else
  {
    "\nCancel";
  }
}

U0 SaveFormFunc()
{
  Fs->draw_it = NULL;
  SaveForm newForm;
  newForm.directory = NULL;
  if(DocForm(&newForm))
  {
    U8 *strBuffer = "";
    I64 arraySize = current_map.width * current_map.height;
    I64 i;
    strBuffer = MStrPrint("%s %d %d\n", strBuffer, current_map.width, current_map.height);
    for(i=0;i<arraySize;i++)
    {
      strBuffer = MStrPrint("%s %d ",strBuffer,current_map.mapArray[i]);
      if((i + 1) % current_map.width == 0)
      {
        strBuffer = MStrPrint("%s %c",strBuffer, '\n');
      }
    }
    FileWrite(newForm.directory, strBuffer, StrLen(strBuffer));
  
//    g_Gaming = FALSE;

  }
  else
  {
    "Cancel\n";
  }
  Free(newForm.directory); 
}

U0 LoadFormFunc()
{

}