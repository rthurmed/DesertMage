extends KinematicBody2D


var direction = Vector2.ZERO
var duration = 0.0


func _process(delta):
	if duration > 0:
		move_and_collide(direction)
	duration -= delta


func hit(_damage, knockback: Vector2, power: float):
	direction = knockback.normalized()
	duration = position.distance_to(direction * power + position) / 60
