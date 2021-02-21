extends Node2D


var portals_destroyed = 0


func get_stage():
	return get_node("YSort")


func get_nav2d():
	return get_node("Navigation2D")


func get_player():
	return get_node("YSort/Player")



func _on_Portal_portal_destroyed(_id):
	portals_destroyed += 1
