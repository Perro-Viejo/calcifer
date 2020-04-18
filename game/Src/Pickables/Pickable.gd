extends Area2D
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Variables ░░░░
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Funciones ░░░░
func _ready() -> void:
	connect('area_entered', self, '_check_collision', [ true ])
	connect('area_exited', self, '_check_collision')

func _check_collision(area: Area2D, grab: bool = false) -> void:
	if grab:
		(area as Player).can_grab = self
	else:
		(area as Player).can_grab = null
