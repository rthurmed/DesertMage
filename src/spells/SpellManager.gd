extends Node2D


const Spells = Constants.Spells

onready var ability_switcher = $CanvasLayer/HabilitySwitcherUI
onready var spells_instances = {
	Spells.SHIELD: $SpellShield,
	Spells.DASH: $SpellDash,
	Spells.MAGIC_BULLET: $SpellMagicBullet,
	Spells.POWER_BEAM: $SpellPowerBeam,
	Spells.MAGIC_BOW: $SpellMagicBow
}

var active_spell = Spells.MAGIC_BOW
var last_spell = Spells.MAGIC_BULLET
var active_skill = Spells.DASH


func _ready():
	update_spells()


func _process(_delta):
	if Input.is_action_just_pressed("spell_switch"):
		set_active_spell(last_spell)


func deactivate():
	active_skill = Spells.EMPTY
	active_spell = Spells.EMPTY
	last_spell = Spells.EMPTY
	update_spells()


func set_active_spell(spell):
	last_spell = active_spell
	active_spell = spell
	update_spells()


func update_spells():
	for i in spells_instances:
		var state = i == active_skill or i == active_spell
		var instance = spells_instances.get(i)
		set_spell_status(instance, state)


func set_spell_status(spell_node: Node, value: bool):
	if spell_node == null: return
	spell_node.visible = value
	spell_node.enabled = value


func _on_HabilitySwitcherUI_updated_skill(value):
	active_skill = value
	update_spells()


func _on_HabilitySwitcherUI_updated_spells(value1, value2):
	active_spell = value1
	last_spell = value2
	update_spells()
