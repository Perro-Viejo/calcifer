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
	$Tween.connect('tween_all_completed', self, 'update_zone_name')


func update_zone_name(name: String = '') -> void:
	if name == '':
		_zone_name.text = ''
		return

	var appear_anim: = true

	if _zone_name.text != '':
		appear_anim = false

		$Tween.remove_all()

		_zone_name.rect_position.y = _dflt_pos.zone_name.y

	_zone_name.text = name

	if appear_anim:
		$Tween.interpolate_property(
			_zone_name,
			'rect_position:y',
			_dflt_pos.zone_name.y + 128,
			_dflt_pos.zone_name.y,
			0.6,
			Tween.TRANS_BACK,
			Tween.EASE_OUT
		)

	$Tween.interpolate_property(
		_zone_name,
		'rect_position:y',
		_dflt_pos.zone_name.y,
		_dflt_pos.zone_name.y + 128,
		0.4,
		Tween.TRANS_BACK,
		Tween.EASE_IN,
		3.2
	)

	$Tween.start()
