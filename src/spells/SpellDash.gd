extends Node2D


onready var delay: Timer = $DelayTimer
onready var animationTimer: Timer = $AnimationTimer

export var enabled: bool = true

var player: KinematicBody2D
var speed = 8
var target: Vector2
var reloading = false


func _ready():
	player = get_tree().get_current_scene().get_player()


func _process(delta):
	if not enabled:
		return
	
	if not reloading and Input.is_action_just_pressed("altfire"):
		var dir = player.movement.normalized()
		target = dir * speed
		reloading = true
		animationTimer.start()
		delay.start()
		player.dash(dir)
	
	target = lerp(target, Vector2.ZERO, delta * 8)
	# warning-ignore:return_value_discarded
	player.move_and_collide(target)


func _on_DelayTimer_timeout():
	reloading = false


func _on_AnimationTimer_timeout():
	player.finish_dash()
