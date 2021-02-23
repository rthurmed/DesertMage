extends Control


onready var bg_animation = $BgAnimationPlayer
onready var animation = $AnimationPlayer
onready var credits_menu = $CreditsMenu


func _ready():
	bg_animation.play("loop")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Menu/GridContainer/StartButton.grab_focus()


func _on_StartButton_pressed():
	get_tree().change_scene("res://src/levels/CanyonLab.tscn")


func _on_OptionsButton_pressed():
	animation.play("options")
	$OptionsMenu/Menu/FullscreenCheckBox.grab_focus()


func _on_CreditsButton_pressed():
	animation.play("credits")
	$CreditsMenu/BackButton.grab_focus()


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_OptionsMenu_confirmed():
	animation.play_backwards("options")
	$Menu/GridContainer/OptionsButton.grab_focus()


func _on_CreditsMenu_confirmed():
	animation.play_backwards("credits")
	$Menu/GridContainer/CreditsButton.grab_focus()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "credits":
		credits_menu.start()
