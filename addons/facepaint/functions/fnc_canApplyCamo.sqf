#include "script_component.hpp"
/*
 * Author: Fisher
 * Check if given player can apply given camo
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Camo name <STRING>
 *
 * Return Value:
 * if camo can be applied <BOOL>
 *
 * Example:
 * [player, "europe_regular_cream"] call fish_camo_cream_facepaint_fnc_canApplyCamo
 *
 * Public: Yes
 */

private ["_player", "_camo", "_face", "_requiredItem"];

_player = [_this, 0, objNull] call BIS_fnc_param;
_camo = [_this, 1, ""] call BIS_fnc_param;

// If no player, exit
if (!alive _player) exitWith {false};

// If not a valid camo, exit
if (!(_camo in GVAR(camo_available))) exitWith {false};

// Define the face we are looking for and check if it exists
_face = face _player + "_fish_facepaint_" + _camo;

if (!isClass(configFile >> "cfgFaces" >> "Man_A3" >> _face)) exitWith {false};

// Check if player has required item in inventory
_requiredItem = GVAR(camo_available) get _camo;

if (!(_requiredItem in (_player call ACEFUNC(common,uniqueItems)))) exitWith {false};

true;