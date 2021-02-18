extends Node2D

export var body_path: NodePath
export var max_distance: float = 48
export var speed: float = 75
export var active: bool = false

var player: KinematicBody2D
var body: KinematicBody2D
var nav2d: Navigation2D
var path = PoolVector2Array()
var distance: float = 0.0
var target: Vector2

signal reached


func _ready():
	nav2d = get_tree().get_current_scene().get_nav2d()
	player = get_tree().get_current_scene().get_player()
	body = get_node(body_path)


func _process(delta):
	distance = target.distance_to(body.global_position)
	
	if distance < max_distance:
		emit_signal("reached")
		active = false
	
	if not active:
		return
	
	follow_path(delta)


func make_path_to(to: Vector2):
	path = nav2d.get_simple_path(body.global_position, nav2d.get_closest_point(to))
	target = to


func follow_path(delta: float):
	var distance_to_walk = speed * delta

	# Move the player along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = body.position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			body.position += body.position.direction_to(path[0]) * distance_to_walk
		else:
			# The player get to the next point
			body.position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
