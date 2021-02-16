extends KinematicBody2D


onready var lifespan: Timer = $Lifespan

export var damage: float = 1.0
export var speed: float = 600

var time_fade_after_collision = 2
var collided = false
var knockback_power = 5.0


func _process(delta):
	if collided:
		return
	
	var collision: KinematicCollision2D = move_and_collide(Vector2.RIGHT.rotated(rotation) * delta * speed)
	collided = collision != null
	
	if collided:
		var body = collision.collider
		if body.has_method("hit"):
			body.hit(damage, collision.position, Vector2.RIGHT.rotated(rotation), knockback_power)
			finish()
		else:
			# If dont have "hit" method most likely is a wall or object, so the bullet must get stuck
			lifespan.wait_time = time_fade_after_collision
			lifespan.start()


func _on_Lifespan_timeout():
	finish()


func finish():
	# TODO: Bullet explosion animation
	queue_free()
