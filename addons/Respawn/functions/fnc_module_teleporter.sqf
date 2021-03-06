﻿/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_Respawn_fnc_module_teleporter
 */
#include "script_component.hpp"

private _logic = param [0,objNull,[objNull]];

if (isServer) then { 
	private _obj = _logic getVariable [QGVAR(teleportPointOBJ), "FlagPole_F"];
	_obj = _obj createVehicle getpos _logic;
	_logic setVariable [QGVAR(teleportObject), _obj, true];
};

if (hasInterface) then {

	private _enabledSide = switch (playerSide) do {
		case west: { _logic getVariable [QGVAR(teleportEnableWest), false] };
		case east: { _logic getVariable [QGVAR(teleportEnableEast), false] };
		case resistance: { _logic getVariable [QGVAR(teleportEnableResistance), false] };
		case civilian: { _logic getVariable [QGVAR(teleportEnableCivilian), false] };
		default { false };
	};

	if ( _enabledSide ) then {
		private _statement = {
			params ["_logic"];

			private _obj = _logic getVariable [QGVAR(teleportObject), objNull];
			private _createMarker = _logic getVariable QGVAR(teleportCreateMarker);
			private _tpConditio = _logic getVariable QGVAR(teleportConditio);
			private _menuOpenConditio = _logic getVariable QGVAR(teleportmenuOpenConditio);
			private _useAceAction = _logic getVariable QGVAR(teleportUseAceAction);
			private _name = _logic getVariable QGVAR(teleportName);
			private _markerIcon = _logic getVariable [QGVAR(teleportMarkerIcon), "hd_start"];
			private _allowCheckTickets = _logic getVariable [QGVAR(tun_respawn_teleportCheckTickets), false];
			[_obj, _tpConditio, _name, _createMarker, _markerIcon, [playerSide], _useAceAction, _menuOpenConditio, _allowCheckTickets] call FUNC(addCustomTeleporter);
		};
		
		[
			{
				params ["_logic"];
				_logic getVariable [QGVAR(teleportObject), objNull] != objNull
			},
			_statement,
			[_logic]
		] call CBA_fnc_waitUntilAndExecute;
	};
};