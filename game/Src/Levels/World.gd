extends Node2D
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Variables ░░░░
export(String, FILE, "*.tscn") var Next_Scene: String
export(Array, String) var zone_names
export(String) var world_name = 'el mundo salvaje'

var _current_zone: String setget _set_current_zone

onready var _zones: Area2D = $WorldLayer/Zones
onready var _player: Player = $WorldLayer/Player
onready var _tween: Tween = $WorldLayer/Tween
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Funciones ░░░░
func _ready() -> void:
	# Conectar señales de las zonas del mundo pokémon
	_zones.connect('body_shape_entered', self, '_zone_entered', [ true ])
	_zones.connect('body_shape_exited', self, '_zone_entered', [ false ])
	
	# Establecer valores por defecto
	self._current_zone = ''


func _set_current_zone(val: String) -> void:
	_current_zone = val if val != '' else world_name


func _on_Button_pressed()->void:
	Event.emit_signal("ChangeScene", Next_Scene)


func _zone_entered(
		body_id: int,
		body: Node,
		body_shape: int,
		area_shape: int,
		entered: bool
	) -> void:

	if entered:
		if not zone_names.empty() and zone_names[area_shape]:
			self._current_zone = zone_names[area_shape]
		else:
			self._current_zone = _zones.get_child(area_shape).name
		# Hacer zoom in
		change_zoom(false)
	else:
		self._current_zone = ''
		# Hacer zoom out
		change_zoom()


# Esto tendrá que ir en el Player
func change_zoom(out: bool = true) -> void:
	_tween.interpolate_property(
		_player.cam,
		'zoom',
		_player.cam.zoom,
		Vector2.ONE * 2 if out else _player.cam.zoom / 2,
		1.0 if out else 0.5,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
	)
	_tween.start()
	
	yield(_tween, 'tween_completed')
	Event.emit_signal('zone_entered', _current_zone)
