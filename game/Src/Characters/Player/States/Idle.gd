extends "res://Src/StateMachine/State.gd"

onready var _owner: Player = owner as Player

func enter(msg: Dictionary = {}) -> void:
	.enter(msg)

func exit() -> void:
	.exit()
