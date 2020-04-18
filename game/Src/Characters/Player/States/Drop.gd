# D R O P    S T A T E
extends "res://Src/StateMachine/State.gd"
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Variables ░░░░
onready var _owner: Player = owner as Player
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ Funciones ░░░░
func enter(msg: Dictionary = {}) -> void:
	if msg.dir.y != 0:
		if msg.dir.y == -1:
			_owner.can_grab.position.y -= 6
		else:
			_owner.can_grab.position.y += 16
	else:
		_owner.can_grab.position.y += 6
		_owner.can_grab.position.x += 12 * msg.dir.x

	(_owner.can_grab as Pickable).being_grabbed = false
	_owner.can_grab.z_index -= 1
	_owner.grabbing = false
	_owner.can_grab = null

	_owner.play_animation()
