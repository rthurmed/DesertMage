extends KinematicBody2D


onready var BloodParticle = preload("res://src/effects/BloodParticle.tscn")

var direction = Vector2.ZERO
var duration = 0.0


func _process(delta):
	if duration > 0:
		# warning-ignore:return_value_discarded
		move_and_collide(direction)
	duration -= delta


func hit(_damage, point: Vector2, knockback: Vector2, power: float):
	direction = knockback.normalized()
	duration = position.distance_to(direction * power + position) / 60
	
	# Blood effect
	var pos = point - global_position
	var blood = BloodParticle.instance()
	blood.emitting = true
	blood.position = pos
	blood.rotation = point.angle_to_point(global_position)
	add_child(blood)
