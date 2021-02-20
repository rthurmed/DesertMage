extends Node2D


onready var lifespan_timer: Timer = $Lifespan

export var body_path: NodePath
export var self_manage: bool = true
export var lifespan: float = .5
export var damage: float = 1.0
export var speed: float = 600
export var knockback_power = 5.0

var body: KinematicBody2D
var collided = false

signal collided(collision)
signal timeout(pos)


func _ready():
	body = get_node(body_path)


func _process(delta):
	if collided:
		return
	
	var collision: KinematicCollision2D = body.move_and_collide(Vector2.RIGHT.rotated(global_rotation) * delta * speed)
	collided = collision != null
	
	if collided:
		var body = collision.collider
		
		emit_signal("collided", collision)
		
		if body.has_method("hit"):
			body.hit(damage, collision.position, Vector2.RIGHT.rotated(global_rotation), knockback_power)


func _on_ProjectileModule_collided(_collision):
	if not self_manage:
		return
	body.queue_free()


func _on_Lifespan_timeout():
	emit_signal("timeout", global_position)
