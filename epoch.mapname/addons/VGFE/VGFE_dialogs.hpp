

class VGFEDialog
{
    idd = 0720;
    onLoad = "uiNamespace setVariable ['VirtualGarageDialog', _this select 0]; []spawn VGFE_fnc_client_onVirtualGarageDialogLoad;";
    movingenable=false;
	#include "VGFE_defines.hpp"	
	class Controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Ghostrider, v1.063, #Mycero)
		////////////////////////////////////////////////////////

		class VGFE_background:RscBackground
		{
			idc = 1000;
			x = 0.242187 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.510469 * safezoneW;
			h = 0.561 * safezoneH;
			colorText[] = {0.1,0.1,0.1,1};
			colorBackground[] = {0.48,0.5,0.35,1};	
		};
		class VGFE_StoredVehicles: RscListBox
		{
			shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
			colorBackground[] = {0,0,0,0.7};
			colorBackgroundActive[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.5}; // Disabled text color
			colorSelect[] = {1,1,1,1}; // Text selection color
			colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
			colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)
			pictureColor[] = {1,0.5,0,1}; // Picture color
			pictureColorSelect[] = {1,1,1,1}; // Selected picture color
			pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

			tooltip = "Select a Vehicle to Retrieve"; // Tooltip text
			tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
			tooltipColorText[] = {1,1,1,1}; // Tooltip text color
			tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

			period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected

			rowHeight = 1.5 * GUI_GRID_CENTER_H; // Row height
			itemSpacing = 0; // Height of empty space between items
			maxHistoryDelay = 1; // Time since last keyboard type search to reset it
			canDrag = 1; // 1 (true) to allow item dragging

			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected

			// Scrollbar configuration (applied only when LB_TEXTURES style is used)
			class ListScrollBar //In older games this class is "ScrollBar"
			{
				width = 0; // width of ListScrollBar
				height = 0; // height of ListScrollBar
				scrollSpeed = 0.01; // scroll speed of ListScrollBar

				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

				color[] = {1,1,1,1}; // Scrollbar color
			};

			//onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
			//onDestroy = "systemChat str ['onDestroy',_this]; false";
			//onKillFocus = "systemChat str ['onKillFocus',_this]; false";
			//onKeyDown = "systemChat str ['onKeyDown',_this]; false";
			//onKeyUp = "systemChat str ['onKeyUp',_this]; false";
			//onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
			//onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
			onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
			//onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
			//onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
			//onMouseMoving = "";
			//onMouseHolding = "";

		  	//onSetFocus = "systemChat str ['onSetFocus: Stored Vehicles',_this]; false;[] call VGFE_fnc_clientSetFocusOnStoredVehicleList";
			onLBSelChanged = "systemChat str ['onLBSelChanged: Stored Vehicles',_this]; false;[] call VGFE_fnc_client_onLbSelChangedStoredVehicleList";
			//onMouseEnter = "systemChat str ['onMouseEnter',_this]; false; [] call VGFE_fnc_clientOnMouseEnterStoredVehicleList";
			//onMouseExit = "systemChat str ['onMouseExit',_this]; false; [] call VGFE_fnc_clienonMouseExitStoredVehiclesList";			
			//onLBDblClick = "systemChat str ['onLBDblClick: Stored Vehicles',_this]; false";
			//onLBDrag = "systemChat str ['onLBDrag',_this]; false";
			//onLBDragging = "systemChat str ['onLBDragging',_this]; false";
			//onLBDrop = "systemChat str ['onLBDrop',_this]; false";
			
			idc = 1500;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.44 * safezoneH;

		};
		class VGFE_LocalVehicles: VGFE_StoredVehicles
		{
			idc = 1501;

			//colorBackground[] = {0,0,0,0.7};
			//colorBackgroundActive[] = {0,0,0,1};
			//colorText[] = {1,1,1,1};			
			//style = 530;
			tooltip = "Select a Vehicle to Store"; // Tooltip text			

			onMouseButtonClick = "systemChat str ['onMouseButtonClick for Local Vehicles',_this]; false";

			//onMouseHolding = "";

			onLBSelChanged = "systemChat str ['onLBSelChanged for Local Vehicles',_this]; false; [] call VGFE_fnc_client_onLbSelChangedLocalVehicleList";
			//onMouseEnter = "systemChat str ['onMouseEnter',_this]; false; [] call VGFE_fnc_clientOnMouseEnterLocalVehicleList";
			//onMouseExit = "systemChat str ['onMouseExit',_this]; false; [] call VGFE_fnc_clienonMouseExitLocalVehiclesList";
		
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class VGFE__pictures: RscPicture
		{
			style = 48;//ST_PICTURE
			
			idc = 1200;
			// Update this as vehicles are selected and with either hanger or dock localizations
			text ="\A3\EditorPreviews_F_Exp\Data\CfgVehicles\Land_Addon_05_F.jpg";
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.22 * safezoneH;
		};
		class VGFE_nickname: RscText
		{
			idc = 1009;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.044 * safezoneH;
			text = "Vehicle Nickname";  // For the nickname
			//colorBackground[] = {0.1,0.1,0.1,1};
			//colorText[] = {1,1,1,1};

		};
		class VGFE_executeStoreRetrieve: RscButton
		{
			idc = 1600;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.0449999 * safezoneH;

			//tooltip = "Selecte a Vehicle";
			//colorBackground[] = {0.1,0.1,0.1,1};
			colorText[] = {1,1,1,1};			
			// Action to be updated based on whether a vehicle in the VG or local to player is selected.			
          	//onButtonClick = "closeDialog 0;";  //"call ExileClient_VirtualGarage_network_StoreVehicleRequest";
			//action = "closeDialog 0;";	
			text = "Action Button";	  			
		};
		class VGFE_ButtonMenuCancel: RscButtonMenuCancel
		{
			x = 0.670156 * safezoneW + safezoneX;
			y = 0.731 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			idc = 2;
		};
		class directions: RscStructuredText
		{
			idc = 1001;
			deletable = 0;
			fade = 0;
			access = 0;
			type = 13;
			style = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};				
			text = ""; //--- ToDo: Localize;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class progressLoading: RscProgress
		{
			idc = 1008;
			//onLoad = "_this spawn {params ['_ctrlProgress']; for '_i' from 0.1 to 1.1 step 0.1 do {_ctrlProgress progressSetPosition _i; sleep 0.4;};}";
			type = 8;
			style = 0;
			colorFrame[] = {0,0,0,1};
			colorBar[] =
			{
				"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
			};
			shadow = 2;
			texture = "#(argb,8,8,3)color(1,1,1,1)";			
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.211 * safezoneH + safezoneY;
			w = 0.407344 * safezoneW;
			h = 0.025 * safezoneH;
		};		
		class topDecroative: RscText
		{
			idc = 1005;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.500156 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {1,1,1,0.8};
		};
		class bottomDecorative: RscText
		{
			idc = 1006;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.500156 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {1,1,1,0.8};
		};	
		class Header: RscText
		{
			idc = 1007;
			style = ST_CENTER;
			text = "Virtual Vehicle Storage"; //--- ToDo: Localize;
			size = GUI_TEXT_SIZE_LARGE;
			sizeEx = GUI_TEXT_SIZE_LARGE;			
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.299062 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,0};
		};			
				////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};