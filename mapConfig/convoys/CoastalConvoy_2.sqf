// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: CoastalConvoy_2.sqf
//	@file Author: opec, [GoT] JoSchaap, [404] Del1te, AgentRev

// starting positions for this route
_starts =
[
	[ ( sealand_x_min - 250 ), ( sealand_y_min - 250 ) ],
	[ ( sealand_x_min - 260 ), ( sealand_y_min - 260 ) ],
	[ ( sealand_x_min - 240 ), ( sealand_y_min - 240 ) ]
];

// starting directions in which the vehicles are spawned on this route
_startDirs =
[
	355,
	0,
	5
];

// the route
_waypoints =
[
	[ ( sealand_x_min - 250 ), ( sealand_y_min - 250 ) ],
	[ ( sealand_x_min - 250 ), ( sealand_y_max + 250 ) ],
	[ ( sealand_x_max + 250 ), ( sealand_y_max + 250 ) ],
	[ ( sealand_x_max + 250 ), ( sealand_y_min - 250 ) ],
	[ ( sealand_x_min - 250 ), ( sealand_y_min - 250 ) ]
];
