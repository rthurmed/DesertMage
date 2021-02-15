extends Node2D


onready var animation: AnimationPlayer = $AnimationPlayer

export var enabled = true

var closing = false
var extra_angle = 0.0


func _process(delta):
	if not enabled:
		return
	
	if Input.is_action_just_pressed("altfire"):
		visible = true
		closing = false
		animation.play("deploy")
	
	if Input.is_action_just_released("altfire"):
		animation.play_backwards("deploy")
		closing = true
	
	var nrad = deg2rad(180) if Input.is_action_pressed("fire") else 0.0
	extra_angle = lerp_angle(extra_angle, nrad, delta * 8)
	
	rotation = get_global_mouse_position().angle_to_point(global_position) + extra_angle


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name != "deploy":
		return
	
	if closing:
		closing = false
		visible = false
		return
	
	animation.play("hold")
