extends Node2D


onready var pause_menu = $CanvasLayer/PauseMenu

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
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_ResumeButton_pressed():
	update_pause(false)


func _on_QuitButton_pressed():
	get_tree().quit()
