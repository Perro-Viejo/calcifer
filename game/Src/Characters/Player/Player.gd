class_name Player
extends KinematicBody2D
class_name Player
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Variables ░░░░
const STATES = {
	WALK = 'Walk',
	IDLE = 'Idle'
}

var is_moving = false

onready var cam: Camera2D = $Camera2D
onready var _calc_speed: float = speed * 60
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Funciones ░░░░

