extends "res://Src/StateMachine/State.gd"

onready var _owner: Player = owner as Player

func enter(msg: Dictionary = {}) -> void:
	_owner.is_moving = true
	.enter(msg)

func exit() -> void:
	_owner.is_moving = false
	.exit()

