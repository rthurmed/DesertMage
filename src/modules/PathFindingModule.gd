extends Node2D


var nav2d: Navigation2D


func _ready():
	nav2d = get_tree().get_current_scene().get_nav2d()
