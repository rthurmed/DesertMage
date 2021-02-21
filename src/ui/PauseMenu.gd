extends Control

onready var resume_button = $GridContainer/ResumeButton

var paused = false


func _ready():
	update_pause(false)


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		update_pause(not paused)
	
	visible = paused
	get_tree().paused = paused


func update_pause(value):
	paused = value
	
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		resume_button.grab_focus()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_ResumeButton_pressed():
	update_pause(false)


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_ResetButton_pressed():
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	update_pause(false)
