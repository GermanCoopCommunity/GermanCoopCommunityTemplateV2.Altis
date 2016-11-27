// by Quentin


// set AI skill according to value set in Mission Params in description.ext
if (isServer) then
{
	{_x setSkill (_this select 0);} forEach allUnits - playableUnits;
};