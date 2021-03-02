extends KinematicBody2D


const SPEED = 8000
const MAX_LIFE = 10

onready var knockback_module = $KnockbackModule
onready var blood_particles_module = $BloodParticlesModule
onready var crosshair: Node2D = $Crosshair
onready var camera: Camera2D = $Camera2D
onready var sprite: AnimatedSprite = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var spell_manager = $SpellManager
onready var hit_timer = $HitTimer
onready var player_ui = $CanvasLayer/PlayerUI

var movement = Vector2.ZERO
var velocity = Vector2.ZERO
var is_moving = false
var dying = false
var life = MAX_LIFE
var taking_damage = false
var dashing = false

signal died()


func _ready():
	player_ui.set_life(life / MAX_LIFE)


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
	elif dashing:
		return
	elif is_moving:
		sprite.play("walk")
	else:
		sprite.play("idle")


func hit(damage: float, point: Vector2, knockback: Vector2, power: float):
	if dying:
		return
	
	knockback_module.apply(knockback, power)
	blood_particles_module.particle(point)
	
	life -= damage
	hit_timer.start()
	taking_damage = true
	player_ui.set_life(life / MAX_LIFE)
	
	if life < 0 and not dying:
		die()


func die():
	dying = true
	dashing = false
	animation.play("die")
	spell_manager.deactivate()


func dash(direction: Vector2):
	var dir = direction.normalized()
	var ox = round(dir.x)
	var oy = round(dir.y)
	var animate = ""
	
	if ox == 0:
		animate = "down" if oy > 0 else "up"
	else:
		animate = "right" if ox > 0 else "left"
	
	sprite.play(str("dash-", animate))
	dashing = true


func finish_dash():
	dashing = false


func _on_HitTimer_timeout():
	taking_damage = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		emit_signal("died")
