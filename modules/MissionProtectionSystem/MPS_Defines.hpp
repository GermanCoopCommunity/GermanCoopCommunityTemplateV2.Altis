// by Fabi


//#ifndef GeCo_GUI_BASE
//#define GeCo_GUI_BASE
//---------------------------------
// Common defines
//---------------------------------

#define GeCo_true 					1
#define GeCo_false 				0

#define GeCo_ReadAndWrite 			0 //! any modifications enabled
#define GeCo_ReadAndCreate 		1 //! only adding new class members is allowed
#define GeCo_ReadOnly 				2 //! no modifications enabled
#define GeCo_ReadOnlyVerified 		3 //! no modifications enabled, CRC test applied

//---------------------------------
// Control types
//---------------------------------

#define GeCo_CT_STATIC           	0
#define GeCo_CT_BUTTON           	1
#define GeCo_CT_EDIT             	2
#define GeCo_CT_SLIDER           	3
#define GeCo_CT_COMBO           		4
#define GeCo_CT_LISTBOX          	5
#define GeCo_CT_TOOLBOX          	6
#define GeCo_CT_CHECKBOXES       	7
#define GeCo_CT_PROGRESS         	8
#define GeCo_CT_HTML             	9
#define GeCo_CT_STATIC_SKEW      	10
#define GeCo_CT_ACTIVETEXT       	11
#define GeCo_CT_TREE             	12
#define GeCo_CT_STRUCTURED_TEXT  	13
#define GeCo_CT_CONTEXT_MENU     	14
#define GeCo_CT_CONTROLS_GROUP   	15
#define GeCo_CT_SHORTCUTBUTTON   	16

// Todo: verify these
	#define GeCo_CT_3DSTATIC     	20
	#define GeCo_CT_3DACTIVETEXT 	21
	#define GeCo_CT_3DLISTBOX    	22
	#define GeCo_CT_3DHTML       	23
	#define GeCo_CT_3DSLIDER     	24
	#define GeCo_CT_3DEDIT       	25
// End of "ToDo Verify These"

#define GeCo_CT_XKEYDESC         	40
#define GeCo_CT_XBUTTON          	41
#define GeCo_CT_XLISTBOX         	42
#define GeCo_CT_XSLIDER          	43
#define GeCo_CT_XCOMBO           	44
#define GeCo_CT_ANIMATED_TEXTURE 	45
#define GeCo_CT_CHECKBOX         	77
// 3D Controls
#define GeCo_CT_OBJECT           	80
#define GeCo_CT_OBJECT_ZOOM      	81
#define GeCo_CT_OBJECT_CONTAINER 	82
#define GeCo_CT_OBJECT_CONT_ANIM 	83
#define GeCo_CT_LINEBREAK        	98
#define GeCo_CT_USER             	99
#define GeCo_CT_MAP              	100
#define GeCo_CT_MAP_MAIN         	101
#define GeCo_CT_LISTNBOX         	102


//---------------------------------
// Control styles
//---------------------------------
//many of these can be combined; eg: style = GeCo_ST_RIGHT + GeCo_ST_SHADOW;

#define GeCo_ST_UNDEFINED      		0		// Not Sure what this is
#define GeCo_ST_POS            		0x0F
#define GeCo_ST_HPOS           		0x03
#define GeCo_ST_VPOS           		0x0C
#define GeCo_ST_LEFT           		0x00	//left aligned text
#define GeCo_ST_RIGHT          		0x01	//left aligned text
#define GeCo_ST_CENTER         		0x02	//center aligned text
#define GeCo_ST_DOWN           		0x04
#define GeCo_ST_UP             		0x08
#define GeCo_ST_VCENTER        		0x0C

#define GeCo_ST_TYPE           		0xF0
#define GeCo_ST_SINGLE         		0x00	//single line textbox
#define GeCo_ST_MULTI          		0x10	//multi-line textbox (text will wrap, and newline character can be used). There is no scrollbar, but mouse wheel/arrows can scroll it. Control will be outlined with a line (color = text color).
#define GeCo_ST_TITLE_BAR      		0x20
#define GeCo_ST_PICTURE        		0x30  	//turns a static control into a picture control. 'Text' will be used as picture path. Picture will be stretched to fit the control.
#define GeCo_ST_FRAME          		0x40	//control becomes a frame. Background is clear and text is placed along the top edge of the control. Control is outlined with text color (as in GeCo_ST_MULTI)
#define GeCo_ST_BACKGROUND     		0x50
#define GeCo_ST_GROUP_BOX      		0x60
#define GeCo_ST_GROUP_BOX2     		0x70
#define GeCo_ST_HUD_BACKGROUND 		0x80	//control is rounded and outlined (just like a hint box)
#define GeCo_ST_TILE_PICTURE   		0x90
#define GeCo_ST_WITH_RECT      		0xA0
#define GeCo_ST_LINE           		0xB0	//a line is drawn between the top left and bottom right of the control (color = text color). Background is clear. Control can still have text, however.

#define GeCo_ST_SHADOW         		0x100	//text or image is given a shadow
#define GeCo_ST_NO_RECT        		0x200	//when combined with GeCo_ST_MULTI, it eliminates the outline around the control. Might combine with other styles for similar effect.
#define GeCo_ST_KEEP_ASPECT_RATIO  	0x800	//used for pictures, it makes the displayed picture keep its aspect ratio.

#define GeCo_ST_TITLE          		GeCo_ST_TITLE_BAR + GeCo_ST_CENTER

// Slider styles
#define GeCo_SL_DIR            		0x400
#define GeCo_SL_VERT           		0
#define GeCo_SL_HORZ           		0x400

#define GeCo_SL_TEXTURES       		0x10

// progress bar 
#define GeCo_ST_VERTICAL       		0x01
#define GeCo_ST_HORIZONTAL     		0

// Listbox styles
#define GeCo_LB_TEXTURES       		0x10	//removes all extra lines from listbox, leaving only a gradiant scrollbar. Useful when LB has a painted background behind it.
#define GeCo_LB_MULTI          		0x20	//allows multiple elements of the LB to be selected (by holding shift / ctrl)

// Tree styles
#define GeCo_TR_SHOWROOT       		1
#define GeCo_TR_AUTOCOLLAPSE   		2

// MessageBox styles
#define GeCo_MB_BUTTON_OK      		1
#define GeCo_MB_BUTTON_CANCEL  		2
#define GeCo_MB_BUTTON_USER    		4

//---------------------------------
// Hardcoded IDCs
//---------------------------------

#define IDC_OK            				1
#define IDC_CANCEL        				2
#define IDC_AUTOCANCEL    				3
#define IDC_ABORT         				4
#define IDC_RESTART      				5

///////////////////
//     FONTS     //
///////////////////
/*
	"EtelkaMonospacePro"
	"EtelkaMonospaceProBold"
	"EtelkaNarrowMediumPro"
	"LucidaConsoleB"
	"PuristaBold"
	"PuristaLight"
	"PuristaMedium"
	"PuristaSemibold"
	"TahomaB"
*/

#define GeCo_FONT_LIGHT				"PuristaLight"
#define GeCo_FONT_NORMAL				"PuristaMedium"
#define GeCo_FONT_BOLD				"PuristaSemibold"
#define GeCo_FONT_HEAVY				"PuristaBold"
#define GeCo_FONT_MONO				"EtelkaMonospaceProBold"


/////////////////////
//     COLOURS     //
/////////////////////

#define GeCo_RGB_WHITE				{1,1,1,1}
#define GeCo_RGB_WHITE_50%			{1,1,1,0.5}

#define GeCo_RGB_BLACK				{0,0,0,1}
#define GeCo_RGB_RED					{1,0,0,1}
#define GeCo_RGB_GREEN				{0,1,0,1}
#define GeCo_RGB_BLUE				{0,0,1,1}

#define GeCo_RGB_DARKCYAN			{0,0.5,0.5,1}

#define GeCo_HEX_WHITE				"#ffffff"
#define GeCo_HEX_BLACK				"#000000"


///////////////////////////////////////////////////////////////////////////
/// Base Classes
///////////////////////////////////////////////////////////////////////////
  class GeCo_RscText
  {
	idc 	= -1;
	access 	= 0;
	type 	= GeCo_CT_STATIC;
	style 	= GeCo_ST_UNDEFINED;
	x 		= 0;
	y 		= 0;
	h 		= 0.037;
	w 		= 0.3;
	deletable 			= 0;
	fade 				= 0;
	shadow 				= 1;
	text 				= "";
	font 				= GeCo_FONT_NORMAL;
	fixedWidth 			= 0;
	SizeEx 				= "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing 		= 1;
	colorBackground[] 	={0,0,0,0};
	colorText[] 		={1,1,1,1};
	colorShadow[] 		= {0,0,0,0.5};
	tooltipColorText[] 	= {1,1,1,1};
	tooltipColorBox[] 	= {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
  };

  //Multi-line text.
  class GeCo_RscTextMulti: GeCo_RscText
  {
	linespacing = 1;
	style = GeCo_ST_LEFT + GeCo_ST_MULTI
  };

  class GeCo_RscFrame
  {
	type 	= GeCo_CT_STATIC;
	idc = -1;
	style = 64;
	shadow = 2;
	colorBackground[] ={0,0,0,0};
	colorText[] ={1,1,1,1};
	font = GeCo_FONT_NORMAL;
	sizeEx = 0.02;
	text = "";
  };

  //Standard active text (text that can be clicked like a button)
   class GeCo_RscActiveText
  {
	idc 			= -1;
	access			= GeCo_ReadAndWrite;
	type 			= GeCo_CT_ACTIVETEXT;
	style 			= 2;  //dont know what style 2 is
	color[] 		= GeCo_RGB_WHITE;
	colorActive[] 	= {1,0.5,0,1};
	colorDisabled[] = {1,1,1,0.25};
	default = 0;
	deletable = 0;
	fade = 0;
	font 			= GeCo_FONT_NORMAL;
	h = 0.05;
	w = 0.15;
	shadow = 0;
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	soundClick[] 	= {"",0.1,1};
	soundEnter[] 	= {"",0.1,1};
	soundEscape[] 	= {"",0.1,1};
	soundPush[] 	= {"",0.1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};
	text = "";
  };

  class GeCo_RscStructuredText
  {
  	idc 	= -1;
	access 	= 0;
	type 	= GeCo_CT_STRUCTURED_TEXT;
	//style 	= 0; Default BIS value not documented
	style 	= GeCo_ST_UNDEFINED;
	x 		= 0;
	y 		= 0;
	h 		= 0.035;
	w 		= 0.1;
	deletable 		= 0;
	fade 			= 0;
	shadow 			= 1;
	text 			= "";
	size 			= "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] 	= {1,1,1,1};
	class Attributes
	{
		font 	= GeCo_FONT_NORMAL;
		color 	= "#ffffff";
		align 	= "left";
		shadow 	= 1;
	};
  };

    class GeCo_RscHTML
  {
	idc 		= -1;
	access		= GeCo_ReadAndWrite;
	type 		= GeCo_CT_HTML;
	style 		= GeCo_ST_SINGLE;
	filename 	= "";
	shadow 		= 0;
	colorBackground[] 		= GeCo_RGB_BLACK;
	colorText[] 			= GeCo_RGB_WHITE;
	colorBold[] 			= {0,0,0.2,1};
	colorLink[] 			= {1,0.5,0,1};
	colorLinkActive[] 		= {1,0.5,0,1};
	colorPicture[] 			= GeCo_RGB_WHITE;
	colorPictureLink[] 		= GeCo_RGB_WHITE;
	colorPictureSelected[] 	= GeCo_RGB_WHITE;
	colorPictureBorder[] 	= GeCo_RGB_BLACK;
	tooltipColorText[] 		= GeCo_RGB_BLACK;
	tooltipColorBox[] 		= {0,0,0,0.5};
	tooltipColorShade[] 	= {1,1,0.7,1};
	prevPage 				= "#(argb,8,8,3)color(1,1,1,1)";
	nextPage 				= "#(argb,8,8,3)color(1,1,1,1)";
	class H1
	{
		font 		= GeCo_FONT_NORMAL;
		fontBold 	= GeCo_FONT_BOLD;
		sizeEx 		= 0.1;
	};
	class H2
	{
		font 		= GeCo_FONT_NORMAL;
		fontBold 	= GeCo_FONT_BOLD;
		sizeEx 		= 0.09;
	};
	class H3
	{
		font 		= GeCo_FONT_NORMAL;
		fontBold 	= GeCo_FONT_BOLD;
		sizeEx 		= 0.08;
	};
	class H4
	{
		font 		= GeCo_FONT_NORMAL;
		fontBold 	= GeCo_FONT_BOLD;
		sizeEx 		= 0.07;
	};
	class H5
	{
		font 		= GeCo_FONT_NORMAL;
		fontBold 	= GeCo_FONT_BOLD;
		sizeEx 		= 0.06;
	};
	class H6
	{
		font 		= GeCo_FONT_NORMAL;
		fontBold 	= GeCo_FONT_BOLD;
		sizeEx 		= 0.05;
	};
	class P
	{
		font 		= GeCo_FONT_NORMAL;
		fontBold 	= GeCo_FONT_BOLD;
		sizeEx 		= 0.04;
	};
  };

  // Todo NEEDS CHECKING WITH WIKI
  class GeCo_RscProgress
  {
	idc 		= -1;
	access		= GeCo_ReadAndWrite;
	type	 	= GeCo_CT_PROGRESS;
	style 		= GeCo_ST_SINGLE;
	deletable = 0;
	fade = 0;
	x 			= 0;
	y 			= 0;
	w 			= 1.2;
	h 			= 0.03;
	shadow 		= 2;
	colorFrame[]= GeCo_RGB_WHITE;
	colorBar[] 	= GeCo_RGB_WHITE;
	texture 	= "#(argb,8,8,3)color(1,1,1,1)";
  };

  // Todo NEEDS CHECKING WITH WIKI
  class GeCo_RscProgressNotFreeze
  {
	idc 		= -1;
	access		= GeCo_ReadAndWrite;
	type 		= GeCo_CT_ANIMATED_TEXTURE;
	style 		= GeCo_ST_SINGLE;
	deletable 	= 0;
	fade 	= 0;
	x 		= 0;
	y 		= 0;
	w 		= 0.5;
	h 		= 0.1;
	shadow 		= 0;
	texture 	= "#(argb,8,8,3)color(0,0,0,0)";
  };

  class GeCo_RscPicture
  {
	idc 		= -1;
	access 		= 0;
	type 		= GeCo_CT_STATIC;
	style 		= GeCo_ST_PICTURE;
	x 			= 0;
	y 			= 0;
	w 			= 0.2;
	h 			= 0.15;
	deletable 			= 0;
	fade 				= 0;
	font 				= "TahomaB";
	sizeEx 				= 0;
	lineSpacing 		= 0;
	text 				= "";	// path to image file
	fixedWidth 			= 0;
	shadow 				= 0;
	colorBackground[] 	= {0,0,0,0};
	colorText[] 		={1,1,1,1};
	tooltipColorText[] 	= {1,1,1,1};
	tooltipColorBox[] 	= {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
  };

  class GeCo_RscEdit
  {
	deletable = 0;
	fade = 0;
	access = 0;
	type 	= GeCo_CT_EDIT;
	style = "GeCo_ST_SINGLE + GeCo_ST_FRAME";
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorSelection[] = {1,1,1,0.25};
	autocomplete = "";
	text = "";
	size = 0.2;
	font = GeCo_FONT_NORMAL;
	shadow = 2;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	canModify = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
  };

  class GeCo_RscCombo
  {
	deletable = 0;
	fade = 0;
	access = 0;
	type 	= GeCo_CT_COMBO;
	style = "0x10 + 0x200";	// GeCo_ST_MULTI + GeCo_ST_NO_RECT

	colorActive[] = {1,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorPicture[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorScrollbar[] = {1,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	colorSelect[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorSelectRight[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorTextRight[] = {1,1,1,1};
	soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};
	soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
	soundCollapse[]={"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};

	maxHistoryDelay = 1;
	class ComboScrollBar
	{
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		autoScrollDelay = 5;
		autoScrollEnabled = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		scrollSpeed = 0.06;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		width = 0;
	};

	font = GeCo_FONT_NORMAL;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
  };

  class GeCo_RscListBox
  {
	deletable = 0;
	fade = 0;
	access = 0;
	type 	= GeCo_CT_LISTBOX;
	style = 16;	//BIS DEFAULT, not documeted what this value means
	rowHeight = 0;
	colorText[] ={1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorScrollbar[] = {1,0,0,0};
	colorSelect[] = {0,0,0,1};
	colorSelect2[] = {0,0,0,1};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorSelectBackground2[] = {1,1,1,0.5};
	colorBackground[] = {0,0,0,0.3};
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,	1};
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] ={1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] ={1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class ListScrollBar
	{
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		width = 0;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		scrollSpeed = 0.06;
		autoScrollEnabled = 1;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.3;

	font = GeCo_FONT_NORMAL;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	colorShadow[] = {0,0,0,0.5};
	period = 1.2;
	maxHistoryDelay = 1;
  };


  // Todo Needs checking
  class GeCo_RscListNBox
  {
	idc 			= -1;
	access			= GeCo_ReadAndWrite;
	type 			= GeCo_CT_LISTNBOX;
	style 			= GeCo_ST_SINGLE;
	deletable = 0;
	x = 0;
	y = 0;
	w = 0.4;
	h = 0.4;
	font 				= GeCo_FONT_NORMAL;
	sizeEx 				= 0.04;
	rowHeight 			= 0;
	color[] 				= {0.95,0.95,0.95,1};
	colorBackground[] 		= {0,0,0,1};
	colorDisabled[] 		= {1,1,1,0.25};
	colorPicture[] 			= {1,1,1,1};
	colorPictureDisabled[] 	= {1,1,1,1};
	colorPictureSelected[] 	= {1,1,1,1};
	colorScrollbar[] 		= {0.95,0.95,0.95,1};
	colorSelect2[] 			= {0,0,0,1};
	colorSelect[] 			= {0,0,0,1};
	colorSelectBackground2[]= {1,1,1,0.5};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorText[] 			= GeCo_RGB_WHITE;

	maxHistoryDelay 	= 1.0;
	soundSelect[] 		= {"",0.1,1};
	period 				= 1;
	autoScrollSpeed 	= -1;
	autoScrollDelay 	= 5;
	autoScrollRewind 	= 0;
	arrowEmpty 		= "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull 		= "#(argb,8,8,3)color(1,1,1,1)";
	drawSideArrows 		= 0;
	columns[] 		= {0.3,0.6,0.7};
	idcLeft 		= -1;
	idcRight 		= -1;
	shadow 			= 0;
	class ListScrollBar
	{
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		width = 0;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		scrollSpeed = 0.06;
		autoScrollEnabled = 1;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	class ScrollBar
	{
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		height = 0;
		width = 0;
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		scrollSpeed = 0.06;
		autoScrollEnabled = 1;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
  };

  class GeCo_RscButton
  {
	deletable = 0;
	fade = 0;
	access = 0;
	type 	= GeCo_CT_BUTTON;
	style = 2;	// BIS DEFAULT, undocumented
	text = "";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {0,0,0,0.5};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	colorBackgroundActive[] = {0,0,0,1};
	colorFocused[] = {0,0,0,1};
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,1};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};

	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = GeCo_FONT_NORMAL;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	borderSize = 0;
  };

  class GeCo_RscShortcutButton
  {
	idc = -1;
	style 	= GeCo_ST_UNDEFINED;
	type 	= GeCo_CT_SHORTCUTBUTTON;
	x = 0.1;
	y = 0.1;
	w = 0.183825;
	h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	default = 0;
	shadow = 1;
	deletable = 0;
	fade = 0;
	periodFocus = 1.2;
	periodOver = 0.8;
	period = 0.4;
	font = GeCo_FONT_NORMAL;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	textSecondary = "";
	action = "";

	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class TextPos
	{
		left = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0;
	};
	shortcuts[] = 
	{
	};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = {1,1,1,1};
	colorFocused[] = {1,1,1,1};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		1
	};
	colorBackgroundFocused[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		1
	};
	colorBackground2[] = {1,1,1,1};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",	0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	class Attributes
	{
		font = GeCo_FONT_NORMAL;
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};


	colorSecondary[] = {1,1,1,1};
	colorFocusedSecondary[] ={1,1,1,1};
	color2Secondary[] = {0.95,0.95,0.95,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	fontSecondary = "PuristaMedium";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";

	class AttributesImage
	{
		font = GeCo_FONT_NORMAL;
		color = "#E5E5E5";
		align = "left";
	};
};

class GeCo_RscShortcutButtonMain
{
	idc = -1;
	style 	= GeCo_ST_UNDEFINED;
	default = 0;
	w = 0.313726;
	h = 0.104575;
	period = 0.5;
	font = GeCo_FONT_NORMAL;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	text = "";
	action = "";
	color[] ={1,1,1,1};
	colorDisabled[] ={1,1,1,0.25};
	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0.0145;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	};
	class TextPos
	{
		left = "(((safezoneW / safezoneH) min 1.2) / 32) * 1.5";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)*2 - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)) / 2";
		right = 0.005;
		bottom = 0;
	};
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\disabled_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\down_ca.paa";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\normal_ca.paa";

	class Attributes
	{
		font = GeCo_FONT_NORMAL;
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class AttributesImage
	{
		font = GeCo_FONT_NORMAL;
		color = "#E5E5E5";
		align = "false";
	};
};

class GeCo_RscSlider
{
	idc = -1;
	deletable = 0;
	fade = 0;
	access = 0;
	type 	= GeCo_CT_SLIDER;
	style = 1024;
	w = 0.3;
	color[] = {1,1,1,0.8};
	colorActive[] = {1,1,1,1};
	shadow = 0;
	h = 0.025;
};


  // ToDo Needs checking
  class GeCo_RscSliderH: GeCo_RscSlider
  {
	idc 			= -1;
	access			= GeCo_ReadAndWrite;
	type 			= GeCo_CT_XSLIDER;
	//style 			= GeCo_SLIDER_HORZ + GeCo_SL_TEXTURES;	//"0x400  + 0x10";
	style			= 1024;
	h = "scalar";
	color[] = {1,1,1,0.6};
	colorActive[] = GeCo_RGB_WHITE;
	colorDisable[] = {1,1,1,0.4};
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	border = "#(argb,8,8,3)color(1,1,1,1)";
	thumb = "#(argb,8,8,3)color(1,1,1,1)";
	shadow = 0;
  };

class GeCo_IGUIBack
{
	type 	= GeCo_CT_STATIC;
	idc = -1;
	style = 128;
	text = "";
	colorText[] = {	0,0,0,0};
	font = GeCo_FONT_NORMAL;
	sizeEx = 0;
	shadow = 0;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	colorbackground[] = 
	{
		"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"
	};
};

class GeCo_RscCheckBox
{
	idc = -1;
	type 	= GeCo_CT_CHECKBOX;
	style 	= GeCo_ST_UNDEFINED;
	checked = 0;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	color[] = {1,1,1,0.7};
	colorFocused[] = {1,1,1,1};
	colorHover[] = {1,1,1,1};
	colorPressed[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.2};
	colorBackground[] = {0,0,0,0};
	colorBackgroundFocused[] = {0,0,0,0};
	colorBackgroundHover[] = {0,0,0,0};
	colorBackgroundPressed[] ={0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	textureChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] ={0,0,0,0.65};
	soundEnter[] = 	{"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
};

class GeCo_RscTextCheckBox
{
	idc = -1;
	type 	= GeCo_CT_CHECKBOXES;
	style 	= GeCo_ST_UNDEFINED;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	colorText[] = {1,0,0,1};
	color[] ={0,0,0,0};
	colorBackground[] = {0,0,0,0};
	colorTextSelect[] = {0,0.8,0,1};
	colorSelectedBg[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		1
	};
	colorSelect[] = {0,0,0,1};
	colorTextDisable[] = {0.4,0.4,0.4,1};
	colorDisable[] = {0.4,0.4,0.4,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	font = GeCo_FONT_NORMAL;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	rows = 1;
	columns = 1;
	strings[] = 
	{
		"UNCHECKED"
	};
	checked_strings[] = 
	{
		"CHECKED"
	};
};

class GeCo_RscButtonMenu
{
	idc = -1;
	type 	= GeCo_CT_SHORTCUTBUTTON;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] ={0,0,0,0.8};
	colorBackgroundFocused[] = {1,1,1,1};
	colorBackground2[] = {0.75,0.75,0.75,1};
	color[] = {1,1,1,1};
	colorFocused[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] ={1,1,1,0.25};
	textSecondary = "";
	colorSecondary[] = {1,1,1,1};
	colorFocusedSecondary[] ={0,0,0,1};
	color2Secondary[] = {0,0,0,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	fontSecondary =  GeCo_FONT_LIGHT;
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class TextPos
	{
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0;
	};
	class Attributes
	{
		font =  GeCo_FONT_LIGHT;
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos
	{
		left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
};

class GeCo_RscButtonMenuOK
{
	idc = 1;
	shortcuts[] = 
	{
		"0x00050000 + 0",
		28,
		57,
		156
	};
	default = 1;
	text = "OK";
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenuOK\soundPush",0.09,1};
};

class GeCo_RscButtonMenuCancel
{
	idc = 2;
	shortcuts[] = 
	{
		"0x00050000 + 1"
	};
	text = "Cancel";
};

class GeCo_RscControlsGroup
{
	idc = -1;
	deletable = 0;
	fade = 0;
	shadow = 0;
	style = 16;
	type 	= GeCo_CT_CONTROLS_GROUP;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	class VScrollbar
	{
		color[] = {	1,1,1,1};
		width = 0.021;
		autoScrollEnabled = 1;
	};
	class HScrollbar
	{
		color[] = {1,1,1,1};
		height = 0.028;
	};
	class Controls
	{
	};
};