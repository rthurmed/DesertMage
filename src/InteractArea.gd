extends Area2D


onready var interact_label = $InteractLabel

var can_interact_with_mirror = false

signal walked_out_mirror
signal interact_mirror


func _ready():
	interact_label.visible = false


func _unhandled_input(event):
	if can_interact_with_mirror and event.is_action("interact") and event.pressed:
		emit_signal("interact_mirror")
		interact_label.visible = false


func _on_InteractArea_body_entered(body):
	if body.name == "MagicMirror":
		can_interact_with_mirror = true
		interact_label.visible = true


func _on_InteractArea_body_exited(body):
	if body.name == "MagicMirror":
		can_interact_with_mirror = false
		interact_label.visible = false
		emit_signal("walked_out_mirror")
