@tool
extends MarginContainer
class_name GSP_PageElement

signal updated(page_element, new_value)
signal focused(page_element)

@export var id := "page_element"
@export var demo_picture := preload("res://icon.svg")
@export var info_text := "@s_Text"
@export var need_for_restart := false
@export var side_info_picture := true
@export var side_info_text := true

@onready var _BG = %BG

var tween_bg : Tween
var on_mouse := false

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_mouse_exited()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func emit_updated():
	pass

func serialize() -> Dictionary:
	return {}
	pass

func unserialize(dic : Dictionary):
	pass

func update_ui():
	pass

func _on_mouse_entered():
	if is_instance_valid(tween_bg):
		tween_bg.stop()
	tween_bg = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween_bg.tween_property(_BG, "modulate:a", 1, 0.3)
	on_mouse = true
	emit_signal("focused", self)
	pass # Replace with function body.


func _on_mouse_exited():
	if is_instance_valid(tween_bg):
		tween_bg.stop()
	tween_bg = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween_bg.tween_property(_BG, "modulate:a", 0, 0.2)
	on_mouse = false
	pass # Replace with function body.


func _on_visibility_changed():
	update_ui()
	pass # Replace with function body.
