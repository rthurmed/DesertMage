extends Node2D


onready var cloud_start = $ExitPoint/Cloud
onready var cloud_end = $ExitPoint/CloudEnd
onready var raycasts = $ExitPoint/RayCasts
onready var beam = $ExitPoint/Beam
onready var animation = $AnimationPlayer

export var enabled = true
var max_size = 240
var size = 0
var closing_beam = false
var damage = 0.1
var knockback_power = 5.0


func _ready():
	update_raycasts()


func _process(delta):
	if not enabled:
		size = 0.0
		return
	
	rotation = get_global_mouse_position().angle_to_point(global_position)
	
	cloud_start.rotation = -rotation
	cloud_end.rotation = -rotation
	
	var target_size = 0.0
	
	if Input.is_action_pressed("fire"):
		target_size = max_size
	
	if Input.is_action_just_released("fire"):
		animation.play("kill")
		closing_beam = true
	
	if Input.is_action_just_pressed("fire"):
		animation.play_backwards("kill")
		closing_beam = false
	
	size = lerp(size, target_size, delta * 2)
	size = clamp(size, 0.0, max_size)
	
	visible = size >= 1
	
	var colliding_raycast = update_raycasts()
	update_beam()
	
	# Apply damage and knockback
	if colliding_raycast >= 0:
		var raycast: RayCast2D = raycasts.get_children()[colliding_raycast]
		var body: Node = raycast.get_collider()
		if body.has_method("hit"):
			body.hit(damage, Vector2.RIGHT.rotated(rotation), knockback_power)


func update_raycasts():
	var closest = size
	var closest_raycast = -1
	
	for i in raycasts.get_child_count():
		var raycast: RayCast2D = raycasts.get_children()[i]
		
		raycast.cast_to.x = size
		raycast.force_raycast_update()
		
		if raycast.is_colliding():
			var length = raycast.global_position.distance_to(raycast.get_collision_point())
			if length < closest:
				closest = length
				closest_raycast = i
	
	cloud_end.position.x = closest
	size = closest
	
	return closest_raycast


func update_beam():
	beam.polygon = PoolVector2Array([
		Vector2(0, 16),
		Vector2(0, 0),
		Vector2(size, 0),
		Vector2(size, 16)
	])


func _on_AnimationPlayer_animation_finished(anim_name):
	if closing_beam and anim_name == "kill":
		size = 0.0
		closing_beam = false
