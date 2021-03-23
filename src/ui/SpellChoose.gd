extends TextureButton


const Spells = Constants.Spells

onready var icon = $Icon

export (Spells) var value: int = Spells.EMPTY

var icon_dict = {
	Spells.SHIELD: "res://assets/ui/icons/spell-icon-shield.tres",
	Spells.DASH: "res://assets/ui/icons/spell-icon-dash.tres",
	Spells.MAGIC_BULLET: "res://assets/ui/icons/spell-icon-bullet.tres",
	Spells.MAGIC_BOW: "res://assets/ui/icons/spell-icon-bow.tres",
	Spells.POWER_BEAM: "res://assets/ui/icons/spell-icon-beam.tres"
}

signal selected(value)
signal on_focus(me)


func _ready():
	set_value(value)


func set_value(v):
	value = v
	
	if v == Spells.EMPTY:
		icon.texture = null
		return
	
	icon.texture = load(icon_dict[v])


func _on_SpellChoose_focus_entered():
	emit_signal("on_focus", self)


func _on_SpellChoose_pressed():
	emit_signal("selected", value)
