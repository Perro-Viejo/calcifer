# G R A B    S T A T E
extends "res://Src/StateMachine/State.gd"
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Variables ░░░░
export(float) var grab_cooldown = 0.5

onready var _owner: Player = owner as Player
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Funciones ░░░░
func enter(msg: Dictionary = {}) -> void:
	_owner.can_grab.z_index = _owner.z_index + 1
	_owner.grabbing = true
	(_owner.can_grab as Pickable).being_grabbed = true
	print(_owner.can_grab.name)

	_owner.play_animation(_owner.STATES.GRAB)
