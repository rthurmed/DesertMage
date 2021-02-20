extends Node2D


onready var lock_timer = $LockTimer

export var body_path: NodePath
export var evade_speed = 200
export var evade_block_time = 2

var body: KinematicBody2D
var evade_vec = Vector2.ZERO
var can_evade = true
var random = RandomNumberGenerator.new()


func _ready():
	random.randomize()
	lock_timer.wait_time = evade_block_time
	body = get_node(body_path)


func _process(delta):
	# warning-ignore:return_value_discarded
	body.move_and_slide(evade_vec * evade_speed)
	evade_vec = lerp(evade_vec, Vector2.ZERO, delta)


# Evade bullets by walking sideways
# TODO: Add evade delay, wait a little time until starting to evade
func evade(base_angle: float):
	if not can_evade:
		return
	
	# Randomly decides if going right or left
	var base_vec = Vector2.ZERO
	base_vec.y = 1 if bool(random.randi_range(0, 1)) else -1
	# Goes a little bit forward
	base_vec.x = .2
	
	evade_vec = base_vec.rotated(base_angle)
	
	lock_timer.start()
	can_evade = false


func _on_LockTimer_timeout():
	can_evade = true
