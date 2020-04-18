extends Node2D
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Variables ░░░░
var eaten_items = 0

onready var _feed_shape: RectangleShape2D = $FeedArea/CollisionShape2D.shape
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Funciones ░░░░
func _ready():
	$InteractionArea.connect('area_entered', self, '_on_area_entered')
	$InteractionArea.connect('area_exited', self, '_on_area_exited')
	$FeedArea.connect('area_entered', self, '_check_food')

func _on_area_entered(other):
	if other.get_name() == 'Player':
		speak(tr("Demon_Greet"))

func _on_area_exited(other):
	if other.get_name() == 'Player':
		speak(tr("Demon_Goodbye"))

func eat(is_good: bool, carbs: int = 1):
	if is_good:
		eaten_items += carbs

		speak(tr("Demon_Eat_pos"))

		$AnimatedSprite.scale += Vector2.ONE * carbs
		_feed_shape.extents.x += carbs * 5
	else:
		speak(tr("Demon_Eat_neg"))

		$AnimatedSprite.scale -= Vector2.ONE * carbs
		_feed_shape.extents.x -= carbs * 5

		if eaten_items > 0:
			eaten_items -= carbs

func speak(text):
	Event.emit_signal('character_spoke', 'Demon', text)
	yield(get_tree().create_timer(2), 'timeout')


func _check_food(body: Node) -> void:
	if body.is_in_group('Pickable') and not (body as Pickable).being_grabbed:
		var pickable: Pickable = body as Pickable

		eat(pickable.is_good, pickable.carbs)
