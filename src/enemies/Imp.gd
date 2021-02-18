extends KinematicBody2D


onready var knockback_module = $KnockbackModule
onready var blood_particles_module = $BloodParticlesModule


func hit(_damage, point: Vector2, knockback: Vector2, power: float):
	knockback_module.apply(knockback, power)
	blood_particles_module.particle(point)
