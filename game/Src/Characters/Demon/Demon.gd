extends Node2D

var eaten_items = 0

func _ready():
	$InteractionArea.connect('body_entered', self, '_on_body_entered')
	$InteractionArea.connect('body_exited', self, '_on_body_exited')

func _process(delta):
	if Input.is_action_pressed('Feed'):
		eat('Eatable')
	if Input.is_action_pressed('FalseFeed'):
		eat('Uneatable')

func _on_body_entered(other):
	if other.get_name() == 'Player':
		speak('Acercate Enano')

func _on_body_exited(other):
	if other.get_name() == 'Player':
		speak('No Te Bayas :(')

func eat(object):
	if object == 'Eatable':
		eaten_items += 1
		speak('QUE RICO COMER HP!!!')
		$AnimatedSprite.set_scale($AnimatedSprite.get_scale() + Vector2(0.1, 0.1))
	else:
		speak(':( :( CUERPO DE CRISTO!!!')
		$AnimatedSprite.set_scale($AnimatedSprite.get_scale() - Vector2(0.1, 0.1))
		if eaten_items > 0:
			eaten_items -=1

func speak(text):
	$Label.set_text(text)
	$Label.show()
	yield(get_tree().create_timer(2), 'timeout')
	$Label.hide()


