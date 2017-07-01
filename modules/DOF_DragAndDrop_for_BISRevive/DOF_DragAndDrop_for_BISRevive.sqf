/*
THis is a simple Drag & Drop Script from Drunken Officer
If you use the BIS Revive Script, there is no option to drag the injuired person.
With this script, you can do itemCargo

23.Jun.2017
*/


#define DOF_DRAGTEXT									"Ziehen"				// AddAction text for drag
#define DOF_DROPTEXT									"Ablegen"				// AddAction text for drag	

#define DOF_DragAnDrop_Dragcondition					"CursorTarget distance _this < 3 && isNull attachedTo CursorTarget && lifeState CursorTarget == 'INCAPACITATED' "			
#define DOF_DragAnDrop_Dropcondition					"_this getVariable 'DOF_DragAndDrop_isDragging' "



	DOF_DragAndDrop_AddActionAndSetVariable =
		{
			DRAG_ID= _this addAction [DOF_DRAGTEXT, {[(_this select 0), CursorTarget]call DOF_DragAnDrop_DRAG},nil,6, true, true,"", DOF_DragAnDrop_Dragcondition  ];
			_this setVariable ["DOF_DragAndDrop_isDragging", false];
		};

//===== Add Addaction to player		
player spawn DOF_DragAndDrop_AddActionAndSetVariable;

//===== Add Respawn-Eventhandler
	EH_DOF_REVIVE_RESPAWN = player addEventHandler 
									[
										"Respawn", 
										{ 
											 (_this select 0) spawn DOF_DragAndDrop_AddActionAndSetVariable;
											 
										}
									];

//================ Function
DOF_DragAnDrop_DRAG =
	{
		params ["_carrier", "_dragedBody"];
			
		_carrier playMove "AcinPknlMstpSrasWrflDnon";
		_carrier forceWalk true;
		_carrier setVariable ["DOF_DragAndDrop_isDragging", true];
		
		DROP_ID= _carrier addAction [DOF_DROPTEXT, {call DOF_DragAnDrop_Drop},[_dragedBody],6, true, true,"", DOF_DragAnDrop_Dropcondition  ];
		
		
		_dragedBody attachTo [_carrier,[0,1.3,0.092]];
		[_dragedBody, 180] remoteExec ["setDir", 0];	
		
		 [_carrier,_dragedBody] spawn 
			{ 
				params ["_carrier", "_dragedBody"];
				waituntil {sleep 0.5; !alive _carrier || lifeState _carrier == "INCAPACITATED" || isNull attachedTo _dragedBody }; 
					if (!alive _carrier || lifeState _carrier == "INCAPACITATED") then { detach _dragedBody };
					_carrier forceWalk false;
			};
		
	};
	
	// =====================  DROP ACTION

DOF_DragAnDrop_Drop =

	{	
		params ["_carrier"];
		private ["_dragedBody"];
		_dragedBody = ((_this select 3) select 0);
		_carrier forceWalk false;
		detach _dragedBody;
		_carrier playmove "amovpknlmstpsraswrfldnon";
		_carrier removeAction DROP_ID;
		_carrier setVariable ["DOF_DragAndDrop_isDragging", false];
	};