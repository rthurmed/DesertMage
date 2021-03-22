extends Control


onready var animation = $AnimationPlayer

export var opened = false


func open():
	animation.play("open")
	$TexturePanel/Margin/SelectedSpells/SpellChoose1.grab_focus()


func close():
	animation.play_backwards("open")
