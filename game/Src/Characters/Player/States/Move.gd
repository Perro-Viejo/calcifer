extends "res://Src/StateMachine/State.gd"

export(float) var speed = 2

var dir = Vector2.ZERO

onready var _calc_speed: float = speed * 60
onready var _owner: Player = owner as Player

func _physics_process(delta) -> void:
	dir.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	dir.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	_owner.translate(dir * _calc_speed * delta)
	if not dir == Vector2(0,0) and not _owner.is_moving:
		_state_machine.transition_to(owner.STATES.WALK)
	elif dir == Vector2(0,0) and _owner.is_moving:
		_state_machine.transition_to(owner.STATES.IDLE)

func enter(msg: Dictionary = {}) -> void:
	.enter(msg)

func exit() -> void:
	.exit()
