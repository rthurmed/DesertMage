extends Node2D


onready var pause_menu = $CanvasLayer/PauseMenu
onready var resume_button = $CanvasLayer/PauseMenu/ResumeButton

var paused = false


func _ready():
	update_pause(false)


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		update_pause(not paused)
	
	pause_menu.visible = paused
	get_tree().paused = paused


func update_pause(value):
	paused = value
	
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		resume_button.grab_focus()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func get_stage():
	return get_node("TestWorld/YSort")


func get_nav2d():
	return get_node("TestWorld/Navigation2D")


func get_player():
	return get_node("TestWorld/YSort/Player")


func _on_ResumeButton_pressed():
	update_pause(false)


func _on_QuitButton_pressed():
	get_tree().quit()
