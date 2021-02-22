extends KinematicBody2D

onready var blood_particles_module = $BloodParticlesModule
onready var animation = $AnimationPlayer
onready var shape = $CollisionShape2D

const MIN_SHAPE_SCALE = .3
const MAX_LIFE = 30

var life = MAX_LIFE
var dying = false

signal portal_destroyed(id)


func _ready():
	animation.play("spawn")


func _process(_delta):
	if not animation.is_playing():
		var scale_mod = life / MAX_LIFE
		shape.scale = Vector2.ONE * clamp(scale_mod, MIN_SHAPE_SCALE, 1.1 )


func hit(damage: float, point: Vector2, _knockback: Vector2, _power: float):
	if dying:
		return
	
	blood_particles_module.particle(point)
	
	life -= damage
	if life < 0:
		die()


func die():
	dying = true
	animation.play("die")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		emit_signal("portal_destroyed", name)
		queue_free()
