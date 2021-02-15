extends Node2D


onready var MagicBullet = preload("res://src/bullets/MagicBullet.tscn")

onready var exit_point = $ExitPoint
onready var timer = $Timer

export var enabled = true
var recharging = false


func _process(_delta):
	if not enabled or recharging:
		return
	
	rotation = get_global_mouse_position().angle_to_point(global_position)
	
	if Input.is_action_pressed("fire"):
		fire()


func fire():
	var bullet = MagicBullet.instance()
	
	bullet.rotation = rotation
	bullet.position = exit_point.global_position
	
	get_tree().get_current_scene().add_child(bullet)
	
	recharging = true
	timer.start()


func _on_Timer_timeout():
	recharging = false
