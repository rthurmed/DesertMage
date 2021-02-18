extends KinematicBody2D


onready var knockback_module = $KnockbackModule
onready var blood_particles_module = $BloodParticlesModule
onready var seek_player_module = $SeekPlayerModule
onready var path_finding_module = $PathFindingModule
onready var path_finding_delay = $PathFindingModule/DelayTimer

var player: KinematicBody2D


func _ready():
	player = get_tree().get_current_scene().get_player()


func _process(_delta):
	if seek_player_module.seeing_player:
		path_finding_module.make_path_to(player.global_position)


func hit(_damage, point: Vector2, knockback: Vector2, power: float):
	knockback_module.apply(knockback, power)
	blood_particles_module.particle(point)


func _on_SeekPlayerModule_start_seeing_player(_pos):
	path_finding_delay.start()


func _on_DelayTimer_timeout():
	path_finding_module.active = true
