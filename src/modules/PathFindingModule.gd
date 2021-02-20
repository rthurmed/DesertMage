extends Node2D

export var body_path: NodePath
export var max_distance: float = 48
export var speed: float = 65
export var active: bool = false

onready var line: Line2D = $Line2D

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
	if not active:
		return
	
	follow_path(delta)
	
	distance = target.distance_to(body.global_position)
	
	if distance < max_distance:
		emit_signal("reached")
		active = false


func make_path_to(to: Vector2):
	path = nav2d.get_simple_path(body.global_position, nav2d.get_closest_point(to), true)
	target = to
	
	line.points = path
	line.global_position = Vector2.ZERO


func follow_path(delta: float):
	var distance_to_walk = speed * delta
	
	# Move along the path
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = body.position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# Not have enough movement left to get to the next point.
			body.position += body.position.direction_to(path[0]) * distance_to_walk
		else:
			body.position = path[0]
			path.remove(0)
		distance_to_walk -= distance_to_next_point
	
	# Update physics
	# warning-ignore:return_value_discarded
	body.move_and_slide(Vector2.ZERO)
