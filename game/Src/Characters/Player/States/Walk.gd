extends "res://Src/StateMachine/State.gd"

onready var _owner: Player = owner as Player

func enter(msg: Dictionary = {}) -> void:
	_owner.is_moving = true

	Event.emit_signal('play_requested', "Player", 'FS')
	_owner.play_animation(_owner.STATES.WALK)

	.enter(msg)

func exit() -> void:
	_owner.is_moving = false
	Event.emit_signal('stop_requested', "Player", 'FS')
	.exit()

