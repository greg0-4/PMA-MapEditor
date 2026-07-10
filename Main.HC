#include "SpriteLoad.HC";
#include "Globals.HC";
#include "Forms.HC";

#include "Update.HC";
#include "Draw.HC";


// incase someone has custom theme on
public CBGR48 gr_palette_std_a[COLORS_NUM]={
0x000000000000,0x00000000AAAA,0x0000AAAA0000,0x0000AAAAAAAA,
0xAAAA00000000,0xAAAA0000AAAA,0xAAAA55550000,0xAAAAAAAAAAAA,
0x555555555555,0x55555555FFFF,0x5555FFFF5555,0x5555FFFFFFFF,
0xFFFF55555555,0xFFFF5555FFFF,0xFFFFFFFF5555,0xFFFFFFFFFFFF};

GrPaletteSet(gr_palette_std_a);



U0 DrawIt(CTask *task, CDC *dc)
{
  UpdateCursor;
  UpdateTileMenu;
  UpdateCamOffset;


  DrawSky(dc);
  DrawMap(dc);
  DrawCursor(dc);
  DrawTileMenu(dc);
}


U0 Main()
{
  Init;
  WinMax;
  SettingsPush;
  AutoComplete;
  MenuPush("
  File 
  {
    New(, 'N');
    Save(, 'S');
    Load(, 'L');
  }
  ");
  DocClear;
  WinBorder;
  DocCursor;
  I64 input1, input2;
  while(g_Gaming)
  {
    Fs->draw_it = &DrawIt;
    switch(GetMsg(&input1, &input2, 1<<MSG_KEY_DOWN+1<<MSG_KEY_UP))
    {
      case MSG_KEY_UP:
	switch(input1)
        {
	  case CH_SPACE: keys.space = FALSE; break;
	  case 0:
	  switch(input2.u8[0])
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
	  case CH_SPACE: keys.space = TRUE; break;
	  case 't':
	    g_tileMenu = !g_tileMenu;
	  break;
	  case 'S': SaveFormFunc; break;
	  case 'N': MapFormFunc; break;
	  case 'L': LoadFormFunc; break;
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
  GrPaletteSet(gr_palette_std);
}

Main;