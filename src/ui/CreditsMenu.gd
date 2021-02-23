extends Control


onready var animation = $AnimationPlayer

signal confirmed()


func start():
	animation.seek(0)
	animation.play("display")


func _on_BackButton_pressed():
	animation.seek(0)
	emit_signal("confirmed")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "display":
		emit_signal("confirmed")
