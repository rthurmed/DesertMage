extends Node2D


onready var cloud_start = $ExitPoint/Cloud
onready var cloud_end = $ExitPoint/CloudEnd
onready var raycasts = $ExitPoint/RayCasts
onready var beam = $ExitPoint/Beam
onready var animation = $AnimationPlayer

export var enabled = true
var max_size = 240
var size = 0


func _ready():
	update_raycasts()


func _process(delta):
	if not enabled:
		return
	
	rotation = get_global_mouse_position().angle_to_point(global_position)
	
	cloud_start.rotation = -rotation
	cloud_end.rotation = -rotation
	
	var target_size = 0.0
	
	if Input.is_action_pressed("fire"):
		target_size = max_size
	
	if Input.is_action_just_released("fire"):
		animation.play("kill")
	
	if Input.is_action_just_pressed("fire"):
		animation.play_backwards("kill")
	
	size = lerp(size, target_size, delta * 2)
	size = clamp(size, 0.0, max_size)
	
	visible = size >= 1
	
	update_raycasts()
	update_beam()


func update_raycasts():
	var closest = size
	
	for i in raycasts.get_child_count():
		var raycast: RayCast2D = raycasts.get_children()[i]
		
		raycast.cast_to.x = size
		raycast.force_raycast_update()
		
		if raycast.is_colliding():
			var length = raycast.global_position.distance_to(raycast.get_collision_point())
			closest = min(closest, length)
	
	cloud_end.position.x = closest
	size = closest


func update_beam():
	beam.polygon = PoolVector2Array([
		Vector2(0, 16),
		Vector2(0, 0),
		Vector2(size, 0),
		Vector2(size, 16)
	])
