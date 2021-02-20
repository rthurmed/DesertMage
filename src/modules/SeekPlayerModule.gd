extends Node2D


onready var raycast: RayCast2D = $RayCast2D

export var max_distance: float = 300

var player: KinematicBody2D
var seeing_player: bool = false
var distance: float = 0.0

signal start_seeing_player(pos)
signal stop_seeing_player(pos)


func _ready():
	player = get_tree().get_current_scene().get_player()


func _process(_delta):
	distance = global_position.distance_to(player.global_position)
	
	if max_distance < distance:
		return
	
	raycast.cast_to = player.global_position - global_position
	
	var old_seeing = seeing_player
	var collider = raycast.get_collider()
	
	seeing_player = collider != null and collider.name == "Player"
	
	if old_seeing != seeing_player:
		if seeing_player:
			emit_signal("start_seeing_player", player.global_position)
		else:
			emit_signal("stop_seeing_player", player.global_position)
