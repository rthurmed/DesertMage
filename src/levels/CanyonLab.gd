extends Node2D


const OBJETIVE_MESSAGE = "DESTROY ALL PORTALS: %s REMAINING"
const WIN_MESSAGE = "YOU DESTROYED ALL PORTALS"
const DIE_MESSAGE = "YOU DIED!"

onready var objective_status = $StageUI/ObjectiveStatus

var portals_destroyed = 0
var portals_count = 0


func _ready():
	portals_count = get_tree().get_nodes_in_group("portal").size()
	update_objetive()


func update_objetive():
	objective_status.text = OBJETIVE_MESSAGE % str(portals_count - portals_destroyed)


func get_stage():
	return get_node("YSort")


func get_nav2d():
	return get_node("Navigation2D")


func get_player():
	return get_node("YSort/Player")


func _on_Portal_portal_destroyed(_id):
	portals_destroyed += 1
	
	if portals_destroyed < portals_count:
		update_objetive()
	else:
		objective_status.text = WIN_MESSAGE


func _on_Player_died():
	objective_status.text = DIE_MESSAGE
