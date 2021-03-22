extends Area2D


var can_interact_with_mirror = false

signal walked_out_mirror
signal interact_mirror


func _unhandled_input(event):
	if can_interact_with_mirror and event.is_action("interact") and event.pressed:
		emit_signal("interact_mirror")


func _on_InteractArea_body_entered(body):
	if body.name == "MagicMirror":
		can_interact_with_mirror = true


func _on_InteractArea_body_exited(body):
	if body.name == "MagicMirror":
		can_interact_with_mirror = false
		emit_signal("walked_out_mirror")
