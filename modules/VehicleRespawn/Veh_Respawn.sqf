// by Quentin


// declare given argument as local variable
_vehicle = _this select 0;

// add respawned vehicle to editable objects for all curators
{[_x,[[_vehicle],true]] remoteExec ["addCuratorEditableObjects",2]; nil;} count allCurators;

/* custom respawn code below */