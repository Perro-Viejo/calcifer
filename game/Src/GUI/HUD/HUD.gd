extends CanvasLayer
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Variables ░░░░
var _current_zone: = ''

onready var _zone_name: Label = $Control/ZoneName
onready var _dflt_pos: = {
	zone_name = _zone_name.rect_position
}
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Funciones ░░░░
func _ready() -> void:
	_zone_name.text = ''
	_zone_name.rect_position.y = _dflt_pos.zone_name.y + 128

	# Conectarse a los eventos del señor
	Event.connect('zone_entered', self, 'update_zone_name')


func update_zone_name(name: String) -> void:
	_zone_name.text = name

	$Tween.interpolate_property(
		_zone_name,
		'rect_position:y',
		_dflt_pos.zone_name.y + 128,
		_dflt_pos.zone_name.y,
		0.6,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	$Tween.start()

	yield(get_tree().create_timer(3.2), 'timeout')

	$Tween.interpolate_property(
		_zone_name,
		'rect_position:y',
		_zone_name.rect_position.y,
		_dflt_pos.zone_name.y + 128,
		0.3,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	$Tween.start()
