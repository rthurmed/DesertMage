extends Node2D


export var body_path: NodePath

var body: KinematicBody2D
var direction = Vector2.ZERO
var duration = 0.0
var applying = false


func _ready():
	body = get_node(body_path)


func _process(delta):
	applying = duration > 0
	if applying:
		# warning-ignore:return_value_discarded
		body.move_and_collide(direction)
		duration -= delta


func apply(knockback: Vector2, power: float):
	direction = knockback.normalized()
	duration = body.position.distance_to(direction * power + body.position) / 60
	
