// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: sideMissionController.sqf
//	@file Author: AgentRev

#define MISSION_CTRL_PVAR_LIST SeaMissions
#define MISSION_CTRL_TYPE_NAME "Sea"
#define MISSION_CTRL_FOLDER "seaMissions"
#define MISSION_CTRL_DELAY (["A3W_seaMissionDelay", 15*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE seaMissionColor

#include "seaMissions\seaMissionDefines.sqf"
#include "missionController.sqf";
