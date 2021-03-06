﻿/*
 * Author: [Tuntematon]
 * [Description]
 * Initate ace action from MSP. Either to setup or pack it.
 *
 * Arguments:
 * 0: MSP vehicle <OBJECT>
 * 1: True: Setup MSP. False: Pack msp <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [msp, true] call Tun_MSP_fnc_initate_msp_action
 */
#include "script_component.hpp"


params ["_target", "_setup"];
private ["_text", "_time", "_conditio"];
private _statusvar = format ["%1_%2", QGVAR(status), playerSide];

if (_setup) then {
    _text = "STR_Tun_MSP_fnc_initate_msp_action_setting" call BIS_fnc_localize;
    _conditio = { !(missionNamespace getVariable (_this select 0 select 1)) };
    _time = GVAR(progresbar_time_setup);
} else {
    _text = "STR_Tun_MSP_fnc_initate_msp_action_packing" call BIS_fnc_localize;
    _conditio = { missionNamespace getVariable (_this select 0 select 1) };
    _time = GVAR(progresbar_time_pack);
};

_code = { (_this select 0 select 0) call FUNC(update_status); };
[_text, _time, _conditio, _code, {hint "aborted"},[[_target, _setup], _statusvar]] call CBA_fnc_progressBar;