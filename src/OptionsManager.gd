extends Node


enum Buses {
	MASTER = 0,
	MUSIC = 1,
	SFX = 2
}

var min_volume = -80.0
var volume_values = []
var volume_initial = []


func _ready():
	for i in Buses:
		var idx = Buses[i]
		var volume = AudioServer.get_bus_volume_db(idx)
		volume_initial.insert(idx, volume)
		volume_values.insert(idx, 1.0)


func set_bus_volume(bus: int, volume: int):
	var percent = (volume / 100.0)
	var size = abs(min_volume - volume_initial[bus])
	var value = (percent * size) + min_volume
	
	volume_values.insert(bus, percent)
	AudioServer.set_bus_volume_db(bus, value)


func set_fullscreen(value):
	OS.window_fullscreen = value


func get_fullscreen():
	return OS.window_fullscreen
