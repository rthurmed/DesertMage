extends Control


onready var bg_animation = $BgAnimationPlayer
onready var animation = $AnimationPlayer

var showing_options = false


func _ready():
	bg_animation.play("loop")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Menu/GridContainer/StartButton.grab_focus()


func _on_StartButton_pressed():
	get_tree().change_scene("res://src/levels/CanyonLab.tscn")


func _on_OptionsButton_pressed():
	animation.play("options")
	$OptionsMenu/OptionsMenu/FullscreenCheckBox.grab_focus()


func _on_CreditsButton_pressed():
	pass # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_OptionsMenu_confirmed():
	animation.play_backwards("options")
	$Menu/GridContainer/OptionsButton.grab_focus()
