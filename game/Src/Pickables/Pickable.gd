class_name Pickable
extends Area2D
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Variables ░░░░
export(bool) var is_good = true
export(int) var carbs = 2

var being_grabbed: bool = false setget set_being_grabbed
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Funciones ░░░░
func _ready() -> void:
	connect('area_entered', self, '_check_collision', [ true ])
	connect('area_exited', self, '_check_collision')


func set_being_grabbed(new_val: bool) -> void:
	being_grabbed = new_val
	# Hacer que el objeto no se pueda monitorear mientras está siendo cargado
	# por el jugador... así se asegura que si éste lo suelta estándo dentro del
	# área de comilona de elfuegoquequiereconsumiralmundo, detectará "la caída"
	# del objeto y se lo comerá
	monitorable = !new_val


func _check_collision(area: Area2D, grab: bool = false) -> void:
	if area.name != 'Player': return

	if grab:
		(area as Player).can_grab = self
	else:
		(area as Player).can_grab = null
