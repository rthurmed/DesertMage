extends Control

onready var lifebar = $Lifebar

func set_life(value: float):
	lifebar.value = int(value * 100)
