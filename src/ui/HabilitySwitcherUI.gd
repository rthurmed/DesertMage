extends Control


onready var animation = $AnimationPlayer
onready var spell_slot_1 = $TexturePanel/Margin/SelectedSpells/Slot1
onready var spell_slot_2 = $TexturePanel/Margin/SelectedSpells/Slot2
onready var skill_slot = $TexturePanel/Margin/ActiveSkill/Slot

export var opened = false

signal updated_spells(value1, value2)
signal updated_skill(value)


func open():
	animation.play("open")
	spell_slot_1.grab_focus()


func close():
	animation.play_backwards("open")


func _on_SkillChoose_selected(value):
	skill_slot.set_value(value)
	emit_signal("updated_skill", value)


func _on_SpellChoose_selected(value):
	if spell_slot_1.value == value:
		return
	
	spell_slot_2.set_value(spell_slot_1.value)
	spell_slot_1.set_value(value)
	
	emit_signal("updated_spells", spell_slot_1.value, spell_slot_2.value)
