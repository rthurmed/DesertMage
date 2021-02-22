extends CanvasLayer

onready var resume_button = $Menu/GridContainer/ResumeButton
onready var menu = $Menu
onready var animation = $AnimationPlayer

var paused = false


func _ready():
	update_pause(false)


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		update_pause(not paused)
	
	menu.visible = paused
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


func _on_OptionsButton_pressed():
	animation.play("options")
	$OptionsMenu/OptionsMenu/FullscreenCheckBox.grab_focus()


func _on_OptionsMenu_confirmed():
	animation.play_backwards("options")
	$Menu/GridContainer/OptionsButton.grab_focus()
