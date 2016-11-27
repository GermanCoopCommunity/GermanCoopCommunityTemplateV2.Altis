// KK Stream UAV, edited by Quentin
/*
	Author: Killzone Kid

	Description:
	streams UAV sight to a render surface

	Parameter(s):
		0:
			OBJECT - uav unit
		1:
			OBJECT - render surface 1
		2:
			OBJECT - drone control station & render surface 2	

	Returns:
	true
*/
/* To Do


*/
/* Notes

example: [streaming_drone,whiteboard,drone_control] call KK_fnc_StreamUAV;

*/


// declare local variables
private _uav = _this select 0;
private _surface_1 = _this select 1;
//UAV_surface_2 = _this select 2;


// make respawned drone stream
_uav addEventHandler ["Respawn",{[_uav,_surface_1,drone_control] call KK_fnc_StreamUAV;}];

// create render surface */
_surface_1 setObjectTexture [0,"#(argb,512,512,1)r2t(uavrtt,1)"];
drone_control setObjectTexture [0,"#(argb,512,512,1)r2t(uavrtt,1)"];


// create camera and stream to render surface
_cam = "camera" camCreate [0,0,0];
_cam cameraEffect ["Internal","Back","uavrtt"];


// attach cam to gunner cam position
_cam attachTo [_uav,[0,0,0],"laserstart"];


// make it zoom in a little
//cam camSetFov 0.1;


// switch cam to thermal
"uavrtt" setPiPEffect [0];
/*
0: Normal - [0]
1: Night Vision - [1]
2: Thermal - [2]
3: Color Correction - [3, enabled, brightness, contrast, offset, blend [r,g,b,a], lerp [r,g,b,a], rgb [r,g,b,a]]
4: Mirror - [4] <currently not working>
5: Chromatic Aberration - [5, enabled, powerx, powery, (bool) aspectCorrection] <currently not working>
6: Film Grain - [6, enabled, intensity, sharpness, grainsize, intensityx1, intensityx2, (bool) monochromatic] <currently not working>
7: Thermal Inverted [7]
*/


// adjust cam orientation
UAV_Stream_MEH = addMissionEventHandler ["Draw3D",
{
    _dir = (_uav selectionPosition "laserstart") vectorFromTo (_uav selectionPosition "commanderview");
    _cam setVectorDirAndUp [_dir, _dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]];
}];


// add action to UAV terminal
drone_control addAction [
	"Drohnensteuerung übernehmen",
	{
		private _caller = (_this select 1);
		switch (side _caller) do	// depending on caller's side, assign him the according UAV terminal
		{
			case ("WEST"): {UAV_terminal = "B_UavTerminal"; _caller addWeapon UAV_terminal;};
			case ("EAST"): {UAV_terminal = "O_UavTerminal"; _caller addWeapon UAV_terminal;};
			case ("RESISTANCE"): {UAV_terminal = "I_UavTerminal"; _caller addWeapon UAV_terminal;};
			default {UAV_terminal = "B_UavTerminal"; _caller addWeapon UAV_terminal; hint format ["Sie sind keiner Seite zugehörig, Soldat %1. Ihnen wurde deshalb ein UAV-Terminal der BLUFOR-Kräfte zugewiesen.", name _caller]};
		};
		_caller action ["UAVTerminalOpen",_caller];
		sleep 2;
		AC_EH = _caller addEventHandler ["AnimStateChanged",
		{
			player addWeapon "ItemGPS";
			player removeEventHandler ["AnimStateChanged",AC_EH];
			//hint format ["AnimStateChanged fired, %1 has been removed.",UAV_terminal]
		}];
	},
	nil,
	1.5,
	true,
	true,
	"",
	"typeOf player in OPZ && {(player distance drone_control) < 5}"
];


// return
_return = true;
_return;