extends KinematicBody2D


onready var lifespan: Timer = $Lifespan
onready var animation: Timer = $AnimationPlayer


func finish():
	animation.play("finish")


func _on_ProjectileModule_collided(_collision):
	finish()


func _on_ProjectileModule_timeout(_pos):
	finish()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "finish":
		queue_free()
