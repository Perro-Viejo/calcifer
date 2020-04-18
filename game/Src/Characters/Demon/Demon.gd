extends Node2D

var eaten_items = 0

func _ready():
	$InteractionArea.connect('area_entered', self, '_on_area_entered')
	$InteractionArea.connect('area_exited', self, '_on_area_exited')

func _process(delta):
	if Input.is_action_pressed('Feed'):
		eat('Eatable')
	if Input.is_action_pressed('FalseFeed'):
		eat('Uneatable')

func _on_area_entered(other):
	if other.get_name() == 'Player':
		speak(tr("Demon_Greet"))

func _on_area_exited(other):
	if other.get_name() == 'Player':
		speak(tr("Demon_Goodbye"))

func eat(object):
	if object == 'Eatable':
		eaten_items += 1
		speak(tr("Demon_Eat_pos"))
		$AnimatedSprite.set_scale($AnimatedSprite.get_scale() + Vector2(0.1, 0.1))
	else:
		speak(tr("Demon_Eat_neg"))
		$AnimatedSprite.set_scale($AnimatedSprite.get_scale() - Vector2(0.1, 0.1))
		if eaten_items > 0:
			eaten_items -=1

func speak(text):
	Event.emit_signal('character_spoke', 'Demon', text)
	yield(get_tree().create_timer(2), 'timeout')


