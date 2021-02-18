extends Node2D


onready var BloodParticle = preload("res://src/effects/BloodParticle.tscn")

export var blood_color: Color


func particle(point: Vector2):
	var pos = point - global_position
	var blood: CPUParticles2D = BloodParticle.instance()
	blood.emitting = true
	blood.position = pos
	blood.rotation = point.angle_to_point(global_position)
	blood.color = blood_color
	add_child(blood)
