class_name Dialogue
extends Label
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Variables ░░░░
export(float) var animation_time = 0.01
export(int) var character_speed = 2
export(bool) var animate_on_set_text = true
export(bool) var animate_on_start = false
export(bool) var canPlay = true
export(float) var disappear_wait = 3.0

var default_position
var default_size

var _current_disappear: = 0.0
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Funciones ░░░░
func _ready():
	default_position = get_position()
	default_size = get_size()

	Event.connect('character_spoke', self, '_on_character_spoke')
	$Timer.connect('timeout', self, '_on_timer_timeout')
	$Timer.set_wait_time(animation_time)
	set_visible_characters(0)

	if animate_on_start:
		start_animation()

func start_animation():
	if $Timer: $Timer.start()

func _on_timer_timeout():
	if get_visible_characters() < text.length():
		set_visible_characters(
			get_visible_characters() + character_speed
		)
	else:
		$Timer.stop()

		if _current_disappear > 0:
			yield(get_tree().create_timer(_current_disappear), 'timeout')
		elif _current_disappear == 0.0:
			yield(get_tree().create_timer(disappear_wait), 'timeout')
		else:
			# El texto no desaparecerá sólo, sino que se espera una señal que lo
			# haga desaparecer
			return
		_current_disappear = 0.0
		hide()
		set_text('')

func _on_character_spoke(
		character: String, message: String, time_to_disappear: float = 0.0
	):
	match character:
		'Demon':
			add_color_override("font_color", Color('#e35f58'))

	show()
	Event.emit_signal('play_requested', 'UI', 'Dialogue')
	set_text(message)

	_current_disappear = time_to_disappear


func set_text(text):
	set_defaults()
	.set_text(text)

	if text != '':
		set_visible_characters(0)
		if animate_on_set_text and text and text.length() > 0:
			start_animation()
		else:
			set_visible_characters(-1)

func set_defaults():
	.set_text('')
	rect_size = default_size
#	rect_position = default_position
	$Timer.stop()
