extends KinematicBody2D


onready var knockback_module = $KnockbackModule
onready var blood_particles_module = $BloodParticlesModule
onready var seek_player_module = $SeekPlayerModule
onready var path_finding_module = $PathFindingModule
onready var path_finding_delay = $PathFindingModule/DelayTimer
onready var side_evade_module = $SideEvadeModule
onready var shooting_module = $ShootingModule
onready var sprite = $AnimatedSprite
onready var shape = $CollisionShape2D
onready var animation = $AnimationPlayer
onready var audio_bark = $Audio/Bark
onready var audio_scream = $Audio/Scream
onready var audio_damage = $Audio/Damage
onready var audio_damage_timer = $Audio/Damage/AudioDamageTimer

var player: KinematicBody2D
var life = 20
var dying = false
var playing_damage_sound = false


func _ready():
	player = get_tree().get_current_scene().get_player()


func _process(_delta):
	if dying:
		return
	
	if seek_player_module.seeing_player:
		path_finding_module.make_path_to(player.global_position)
		shooting_module.target = player.global_position
		sprite.flip_h = global_position < player.global_position
		shape.scale.x = -1 if sprite.flip_h else 1


func hit(damage: float, point: Vector2, knockback: Vector2, power: float):
	knockback_module.apply(knockback, power)
	blood_particles_module.particle(point)
	side_evade_module.evade(player.global_position.angle_to_point(point))
	
	if not playing_damage_sound:
		playing_damage_sound = true
		audio_damage_timer.start()
		audio_damage.play()
	
	life -= damage
	if life < 0:
		die()


func die():
	dying = true
	shooting_module.keep_shooting = false
	side_evade_module.enabled = false
	path_finding_module.enabled = false
	animation.play("die")


func _on_SeekPlayerModule_start_seeing_player(_pos):
	path_finding_delay.start()
	shooting_module.keep_shooting = true
	audio_bark.play()


func _on_SeekPlayerModule_stop_seeing_player(_pos):
	shooting_module.keep_shooting = false


func _on_DelayTimer_timeout():
	path_finding_module.active = true


func _on_PathFindingModule_reached():
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		queue_free()


func _on_AudioDamageTimer_timeout():
	playing_damage_sound = false
