extends TextureButton


export var icon: Texture
export var value: int

signal selected(value)
signal on_focus(me)


func _ready():
	$Icon.texture = icon


func _on_SpellChoose_focus_entered():
	emit_signal("on_focus", self)


func _on_SpellChoose_pressed():
	emit_signal("selected", value)
