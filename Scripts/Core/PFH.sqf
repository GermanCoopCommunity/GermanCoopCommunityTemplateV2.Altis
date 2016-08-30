GeCo_PFH = [];
addMissionEventHandler ["EachFrame", {
  {
      _x params [["_function",{}], ["_delay",0], ["_delta", diag_tickTime]];
    if (diag_tickTime > _delta) then {
      _x set [2, _delta + _delay];
      true call _function;
    };
    nil
  } count GeCo_PFH;
}];
