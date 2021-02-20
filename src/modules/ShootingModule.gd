extends Node2D


onready var delay_timer = $DelayTimer
onready var exit_point = $ExitPoint

export var bullet: PackedScene
export var keep_shooting = false

var target: Vector2
var recharging: bool = false

signal shot


func _process(_delta):
	if target == null:
		return
	
	rotation = target.angle_to_point(global_position)
	
	if not keep_shooting or recharging:
		return
	
	fire()


func fire():
	var instance: KinematicBody2D = bullet.instance()
	
	instance.rotation = rotation
	instance.global_position = exit_point.global_position
	
	get_tree().get_current_scene().get_stage().add_child(instance)
	
	recharging = true
	delay_timer.start()
	emit_signal("shot")


func _on_DelayTimer_timeout():
	recharging = false
