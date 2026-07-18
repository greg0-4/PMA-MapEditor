class SaveForm
{
  U8 *directory format "$$DA+M,A=\"Directory:\"$$";
};

class MapForm
{
  I64 width format "$$DA,A=\"Map Width:%d\"$$\n";
  I64 height format "$$DA,A=\"Map Height:%d\"$$";
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

    for(i=0;i<arraySize;i++)
    {
      strBuffer = MStrPrint("%s %d ", strBuffer,current_map.entArray[i]);
      if( (i+1) % current_map.width == 0)
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
  Fs->draw_it = NULL;
  SaveForm newForm;
  newForm.directory = NULL;
  if(DocForm(&newForm))
  {
    U8 *buffer = FileRead(newForm.directory);
    if(buffer == NULL)
    {
      return;
    }
    U8 *ptr = buffer;

    I64 width = Str2I64(ptr, 10 , &ptr);
    ptr++;
    I64 height = Str2I64(ptr, 10, &ptr);


    I64 *mapArray = MAlloc(width * height * sizeof(I64));
    I64 *entityArray = MAlloc(width * height * sizeof(I64));
    I64 x, y;
    for(y=0;y<height;y++)
    {
      for(x=0;x<width;x++)
      {
        while(*ptr == ' ' || *ptr == '\n' || *ptr == '\r')
        {
          ptr++;
        }
        mapArray[x + y * width] = Str2I64(ptr, 10, &ptr);
      }
    }

    for(y=0;y<height;y++)
    {
      for(x=0;x<width;x++)
      {
        while(*ptr == ' ' || *ptr == '\n' || *ptr == '\r') ptr++;
        entityArray[x + y * width] = Str2I64(ptr, 10, &ptr);
      }
    }

    Free(buffer);
    current_map.mapArray = mapArray;
    current_map.entArray = entityArray;
    current_map.width = width;
    current_map.height = height;
  }
  Free(newForm.directory);
}