extends Node


onready var options = $"/root/OptionsManager"
onready var fullscreen_checkbox = $FullscreenCheckBox
onready var master_slider = $MasterVolumeSlider
onready var music_slider = $MusicVolumeSlider
onready var sfx_slider = $SfxVolumeSlider

signal confirmed()


func _ready():
	fullscreen_checkbox.pressed = options.get_fullscreen()
	master_slider.value = options.volume_values[options.Buses.MASTER] * 100
	music_slider.value = options.volume_values[options.Buses.MUSIC] * 100
	sfx_slider.value = options.volume_values[options.Buses.SFX] * 100


func _on_FullscreenCheckBox_toggled(button_pressed):
	options.set_fullscreen(button_pressed)


func _on_MasterVolumeSlider_value_changed(value):
	options.set_bus_volume(options.Buses.MASTER, value)


func _on_MusicVolumeSlider_value_changed(value):
	options.set_bus_volume(options.Buses.MUSIC, value)


func _on_SfxVolumeSlider_value_changed(value):
	options.set_bus_volume(options.Buses.SFX, value)


func _on_BackButton_pressed():
	emit_signal("confirmed")
