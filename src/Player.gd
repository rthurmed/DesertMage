extends KinematicBody2D


const SPEED = 8000

onready var knockback_module = $KnockbackModule
onready var blood_particles_module = $BloodParticlesModule
onready var crosshair: Node2D = $Crosshair
onready var camera: Camera2D = $Camera2D
onready var sprite: AnimatedSprite = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var spell_manager = $SpellManager
onready var hit_timer = $HitTimer

var movement = Vector2.ZERO
var velocity = Vector2.ZERO
var is_moving = false
var dying = false
var life = 10
var taking_damage = false


func _physics_process(delta):
	if dying:
		return
	process_input(delta)
	process_movement(delta)
	process_animation(delta)


func process_input(_delta):
	movement = Vector2.ZERO
	movement.x = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	movement.y = Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")


func process_movement(delta):
	camera.global_position = global_position + crosshair.position / 4
	
	is_moving = movement != Vector2.ZERO
	velocity = movement.normalized() * SPEED * delta
	
	# warning-ignore:return_value_discarded
	move_and_slide(velocity)


func process_animation(_delta):
	if taking_damage:
		sprite.play("hit")
	elif is_moving:
		sprite.play("walk")
	else:
		sprite.play("idle")


func hit(damage: float, point: Vector2, knockback: Vector2, power: float):
	knockback_module.apply(knockback, power)
	blood_particles_module.particle(point)
	
	life -= damage
	hit_timer.start()
	taking_damage = true
	
	
	if life < 0 and not dying:
		die()


func die():
	dying = true
	animation.play("die")
	spell_manager.deactivate()


func _on_HitTimer_timeout():
	taking_damage = false
