extends StaticBody2D


onready var animation = $AnimationPlayer
onready var timer = $CloseTimer

var opened = false


func _on_AutoOpenArea_body_entered(body):
	if body.name != "Player":
		return
	
	if not opened:
		animation.play("open")
	
	opened = true
	
	timer.stop()


func _on_AutoOpenArea_body_exited(body):
	if body.name != "Player":
		return
	
	timer.start()


func _on_CloseTimer_timeout():
	animation.play_backwards("open")
	opened = false
