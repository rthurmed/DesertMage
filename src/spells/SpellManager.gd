extends Node2D


enum Spells {
	EMPTY = -1
	MAGIC_BULLET = 0,
	POWER_BEAM = 1
}

onready var spells = $Spells
onready var shield = $SpellShield
onready var dash = $SpellDash

var active_spell = Spells.POWER_BEAM
var last_spell = Spells.MAGIC_BULLET


func _ready():
	update_spells()


func _process(_delta):
	if Input.is_action_just_pressed("spell_switch"):
		set_active_spell(last_spell)


func deactivate():
	active_spell = Spells.EMPTY
	last_spell = Spells.EMPTY
	shield.enabled = false
	dash.enabled = false
	update_spells()


func set_active_spell(spell):
	last_spell = active_spell
	active_spell = spell
	update_spells()


func update_spells():
	for i in spells.get_child_count():
		set_spell_status(i, i == active_spell)


func set_spell_status(idx: int, value: bool):
	var spell_node = spells.get_child(idx)
	spell_node.visible = value
	spell_node.enabled = value
