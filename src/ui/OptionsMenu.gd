extends Node


enum Buses {
	MASTER = 0,
	MUSIC = 1,
	SFX = 2
}

var min_volume = -80.0
var initial_volume = []


func _ready():
	for i in Buses:
		var idx = Buses[i]
		var volume = AudioServer.get_bus_volume_db(idx)
		initial_volume.insert(idx, volume)


func set_bus_volume(bus: int, volume: int):
	var percent = (volume / 100.0)
	var size = abs(min_volume - initial_volume[bus])
	var value = (percent * size) + min_volume
	AudioServer.set_bus_volume_db(bus, value)


func _on_FullscreenCheckBox_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_MasterVolumeSlider_value_changed(value):
	set_bus_volume(Buses.MASTER, value)


func _on_MusicVolumeSlider_value_changed(value):
	set_bus_volume(Buses.MUSIC, value)


func _on_SfxVolumeSlider_value_changed(value):
	set_bus_volume(Buses.SFX, value)
