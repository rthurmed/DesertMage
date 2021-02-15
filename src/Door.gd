extends StaticBody2D


onready var animation: AnimationPlayer = $AnimationPlayer


func _on_AutoOpenArea_body_entered(body):
	if body.name == "Player":
		animation.play("open")


func _on_AutoOpenArea_body_exited(body):
	if body.name == "Player":
		animation.play_backwards("open")
