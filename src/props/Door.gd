extends StaticBody2D


onready var animation: AnimationPlayer = $AnimationPlayer
onready var timer = $CloseTimer

var opened = false


func _on_AutoOpenArea_body_entered(body):
	if body.name == "Player":
		timer.stop()
		
		if not opened:
			animation.play("open")
		
		opened = true

func _on_AutoOpenArea_body_exited(body):
	if body.name == "Player":
		timer.start()


func _on_CloseTimer_timeout():
	opened = false
	animation.play_backwards("open")
