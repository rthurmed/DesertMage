extends KinematicBody2D


const SPEED = 8000

onready var crosshair: Node2D = $Crosshair
onready var camera: Camera2D = $Camera2D
onready var sprite: AnimatedSprite = $AnimatedSprite

var movement = Vector2.ZERO
var velocity = Vector2.ZERO
var is_moving = false


func _physics_process(delta):
	process_input(delta)
	process_movement(delta)
	process_animation(delta)


func process_input(_delta):
	movement = Vector2.ZERO
	movement.x = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	movement.y = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")


func process_movement(delta):
	camera.global_position = global_position + crosshair.position / 4
	
	is_moving = movement != Vector2.ZERO
	velocity = movement.normalized() * SPEED * delta
	
	# warning-ignore:return_value_discarded
	move_and_slide(velocity)


func process_animation(_delta):
	if is_moving:
		sprite.play("walk")
	else:
		sprite.play("idle")
