class_name Player
extends Area2D
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Variables ░░░░
const STATES = {
	WALK = 'Walk',
	IDLE = 'Idle',
	GRAB = 'Grab',
	DROP = 'Drop'
}

var is_moving = false
var is_out: bool = false
var can_grab: Area2D = null
var grabbing: bool = false

onready var cam: Camera2D = $Camera2D
onready var sprite: AnimatedSprite = $AnimatedSprite
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Funciones ░░░░
func _ready() -> void:
	# Definir estado por defecto
	play_animation()

func change_zoom(out: bool = true) -> void:
	is_out = out

	if out:
		Event.emit_signal('play_requested', 'UI', 'ZoomOut')
	else:
		Event.emit_signal('play_requested', 'UI', 'ZoomIn')
	# Hacer que camine más rápido si está afuera
	$Tween.interpolate_property(
		cam,
		'zoom',
		cam.zoom,
		Vector2.ONE * 2 if out else Vector2.ONE / 2,
		1.0 if out else 0.5,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
	)
	$Tween.start()

	yield($Tween, 'tween_completed')


func play_animation(state: String = '') -> void:
	match state:
		STATES.GRAB:
			sprite.play('Grab')
		STATES.DROP:
			sprite.play('Drop')
		STATES.WALK:
			if not grabbing:
				sprite.play('Run')
			else:
				sprite.play('RunGrab')
		_:
			if not grabbing:
				sprite.play('Idle')
			else:
				sprite.play('IdleGrab')
