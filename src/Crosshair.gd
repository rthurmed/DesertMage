extends Node2D


const MOUSE_SENS = 0.6
const RIGHT_AXIS_X = 2
const RIGHT_AXIS_Y = 3
const JOYPAD_AIM_DISTANCE = 100
const CROSSHAIR_SMOOTHING = 16

var target = Vector2.ZERO
var hidden = false


func _input(event):
	if event is InputEventMouseMotion:
		target += event.relative * MOUSE_SENS
	
	if event is InputEventJoypadMotion:
		if event.axis == RIGHT_AXIS_X:
			target.x = event.axis_value * JOYPAD_AIM_DISTANCE
		if event.axis == RIGHT_AXIS_Y:
			target.y = event.axis_value * JOYPAD_AIM_DISTANCE


func _process(delta):
	var viewport_rect = get_viewport_rect()
	var view_size = viewport_rect.size / 1.5
	
	hidden = get_parent().global_position.distance_to(global_position) <= 1
	
	visible = not hidden
	position = lerp(position, target, delta * CROSSHAIR_SMOOTHING)
	position.x = clamp(position.x, -view_size.x, view_size.x)
	position.y = clamp(position.y, -view_size.y, view_size.y)
	
	if hidden:
		target = get_parent().movement.normalized()
