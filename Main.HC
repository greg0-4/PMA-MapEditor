#include "Globals.HC";


U0 DrawIt(CTask *task, CDC *dc)
{

}


U0 Main()
{
  Init;
  WinMax;
  SettingsPush;
  DocClear;
  WinBorder;
  DocCursor;
  I64 input1, input2;
  while(g_Gaming)
  {
    switch(GetMsg(&input1, &input2, 1<<MSG_KEY_DOWN+1<<MSG_KEY_UP))
    {
      case MSG_KEY_UP:
	switch(input1)
        { 
	  case 0:
	  switch(input2.u8[0])
	  {
	    case '\n':
	      // Do nothing
	    break;
	    case SC_CURSOR_UP: keys.up = FALSE; break;
	    case SC_CURSOR_DOWN: keys.down = FALSE; break;
	    case SC_CURSOR_LEFT: keys.left = FALSE; break;
	    case SC_CURSOR_RIGHT: keys.right = FALSE; break;
	  }
	  break;
	}
      break;
      case MSG_KEY_DOWN:
	switch(input1)
        {
	  case CH_ESC: g_Gaming = FALSE; break;
	  case 's': SaveFormFunc; break;
	  case 'n': MapFormFunc; break;
	  case 0:
	  switch(input2.u8[0])
	  {
	    case '\n':
	      // Do nothing
	    break;
	    case SC_CURSOR_UP: keys.up = TRUE; break;
	    case SC_CURSOR_DOWN: keys.down = TRUE; break;
	    case SC_CURSOR_LEFT: keys.left = TRUE; break;
	    case SC_CURSOR_RIGHT: keys.right = TRUE; break;

	  }
	  break;
	}
      break;

    }

  }
  SettingsPop; 
}

Main;