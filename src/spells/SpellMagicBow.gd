extends Node2D


onready var MagicArrow = preload("res://src/bullets/MagicArrow.tscn")

onready var sprite: AnimatedSprite = $AnimatedSprite
onready var animation: AnimationPlayer = $AnimationPlayer
onready var exit_point: Node2D = $ExitPoint

export var enabled: bool = false
export var able_to_shoot: bool = false
export var power: float = 0.0


func _process(_delta):
	if not enabled:
		return
	
	rotation = get_global_mouse_position().angle_to_point(global_position)
	sprite.flip_v = get_global_mouse_position() < global_position
	
	if Input.is_action_just_pressed("fire"):
		animation.play("pull")
	
	if Input.is_action_just_released("fire"):
		if able_to_shoot:
			fire()
		animation.seek(0.0, true)
		animation.stop()


func fire():
	var bullet = MagicArrow.instance()
	
	bullet.rotation = rotation
	bullet.position = exit_point.global_position
	
	get_tree().get_current_scene().get_stage().add_child(bullet)
