extends Label


export(float) var animation_time = 0.01
export(int) var character_speed = 2
export(bool) var animate_on_set_text = true
export(bool) var animate_on_start = false
export(bool) var canPlay = true

var default_position
var default_size

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

func _on_character_spoke(character, message):
	match character:
		'Demon':
			add_color_override("font_color", Color('#e35f58'))
	show()
	set_text(message)


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
