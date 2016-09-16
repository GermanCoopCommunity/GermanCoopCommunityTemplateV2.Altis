// KK Stream UAV, edited by Quentin
/*
	Author: Killzone Kid

	Description:
	streams UAV sight to a render surface

	Parameter(s):
		0:
			OBJECT - uav unit

	Returns:
	true
*/

/* To Do


*/
/* Notes


*/

// declare local variables
private _uav = _this select 0;
private _surface = _this select 1;


/* create render surface */
_surface setObjectTexture [0, "#(argb,512,512,1)r2t(uavrtt,1)"];

/* create camera and stream to render surface */
cam = "camera" camCreate [0,0,0];
cam cameraEffect ["Internal", "Back", "uavrtt"];

/* attach cam to gunner cam position */
cam attachTo [_uav, [0,0,0], "laserstart"];

/* make it zoom in a little */
//cam camSetFov 0.1;

/* switch cam to thermal */
"uavrtt" setPiPEffect [2];

/* adjust cam orientation */
addMissionEventHandler ["Draw3D",
{
    _dir = (uav selectionPosition "laserstart") vectorFromTo (uav selectionPosition "commanderview");
    cam setVectorDirAndUp [_dir, _dir vectorCrossProduct [-(_dir select 1), _dir select 0, 0]];
}];


// return
_return = true;
_return;