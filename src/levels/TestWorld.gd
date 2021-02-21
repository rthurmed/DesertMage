extends Node2D


func get_stage():
	return get_node("YSort")


func get_nav2d():
	return get_node("Navigation2D")


func get_player():
	return get_node("YSort/Player")
