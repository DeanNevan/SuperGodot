'''
确认
'''
@tool
extends MarginContainer
class_name NEU_DynamicButton

signal selected(node)

@export var style_margin : StyleBox:
	set(_style_margin):
		style_margin = _style_margin
		reset_all()
@export var style_left_side : StyleBox:
	set(_style_left_side):
		style_left_side = _style_left_side
		reset_all()
@export var style_fill_background : StyleBox:
	set(_style_fill_background):
		style_fill_background = _style_fill_background
		reset_all()
@export var style_fill_fill : StyleBox:
	set(_style_fill_fill):
		style_fill_fill = _style_fill_fill
		reset_all()
@export var icon : Texture:
	set(_icon):
		icon = _icon
		reset_all()
@export var text : String = "text":
	set(_text):
		text = _text
		reset_all()
@export_placeholder("按键事件") var event_select = "ui_select"
@export_node_path var buttons_father_node_path = ^".."
@export var debug_state := STATE.IDLE:
	set(_debug_state):
		debug_state = _debug_state
		change_state(debug_state)

@onready var _Margin = %Margin
@onready var _LeftSide = %LeftSide
@onready var _Fill = %Fill
@onready var _MarginContainer = %MarginContainer
@onready var _Icon = %Icon
@onready var _LabelText = %LabelText

@onready var buttons_father : Node = get_node(buttons_father_node_path)

var buttons : Array[NEU_DynamicButton]:
	set(_buttons):
		if buttons != null:
			for i in buttons:
				if i.is_connected("selected", _on_button_selected):
					i.disconnect("selected", _on_button_selected)
		buttons = _buttons
		if buttons != null:
			for i in buttons:
				if i != self and i is NEU_DynamicButton:
					i.connect("selected", _on_button_selected)

enum STATE{
	IDLE,
	HOVERING,
	SELECTED,
	UNHOVERING,
}
var state : STATE = STATE.IDLE

var on_mouse := false

var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	debug_state = STATE.IDLE
	change_state(STATE.IDLE)
	reset_all()
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_just_pressed(event_select) and on_mouse:
		change_state(STATE.SELECTED)
		emit_signal("selected", self)
	pass

func unselect():
	change_state(STATE.UNHOVERING)

func reset_all():
	if !is_inside_tree():
		return
	_Fill.value = 0
	_LeftSide.modulate.a = 0
	_LeftSide.hide()
	
	var temp : Array[NEU_DynamicButton] = []
	if is_instance_valid(buttons_father):
		for i in buttons_father.get_children():
			if i is NEU_DynamicButton:
				temp.append(i)
	buttons = temp
	
	_Icon.hide()
	if style_margin != null:
		_Margin.add_theme_stylebox_override("panel", style_margin)
	if style_left_side != null:
		_LeftSide.add_theme_stylebox_override("panel", style_left_side)
	if style_fill_background != null:
		_Fill.add_theme_stylebox_override("panel", style_fill_background)
	if style_fill_fill != null:
		_Fill.add_theme_stylebox_override("panel", style_fill_fill)
	if icon != null:
		_Icon.texture = icon
		_Icon.show()
	if text != null:
		_LabelText.text = text

func change_state(to_state : STATE):
	if !is_inside_tree():
		return
	state = to_state
	if state == STATE.IDLE:
		_LeftSide.hide()
		_Fill.value = 0
		pass
	elif state == STATE.HOVERING:
		_LeftSide.show()
		if is_instance_valid(tween):
			tween.kill()
		tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.set_parallel(true)
		tween.tween_property(_Fill, "value", 100, 0.3)
		tween.tween_property(_LeftSide, "modulate:a", 1, 0.3)
		
		
	elif state == STATE.SELECTED:
		_LeftSide.show()
		_MarginContainer.add_theme_constant_override("margin_left", 3)
		_MarginContainer.add_theme_constant_override("margin_right", 3)
		_MarginContainer.add_theme_constant_override("margin_top", 3)
		_MarginContainer.add_theme_constant_override("margin_bottom", 3)
		_Margin.show()
	elif state == STATE.UNHOVERING:
		_LeftSide.show()
		if is_instance_valid(tween):
			tween.kill()
		tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.set_parallel(true)
		tween.tween_property(_Fill, "value", 0, 0.2)
		tween.tween_property(_LeftSide, "modulate:a", 0, 0.2)

	if state != STATE.SELECTED:
		_MarginContainer.add_theme_constant_override("margin_left", 0)
		_MarginContainer.add_theme_constant_override("margin_right", 0)
		_MarginContainer.add_theme_constant_override("margin_top", 0)
		_MarginContainer.add_theme_constant_override("margin_bottom", 0)
		_Margin.hide()

func _on_button_selected(neu_dynamic_button : NEU_DynamicButton):
	unselect()
	pass

func _on_mouse_entered():
	if state != STATE.SELECTED:
		change_state(STATE.HOVERING)
	on_mouse = true
	pass # Replace with function body.


func _on_mouse_exited():
	if state != STATE.SELECTED:
		change_state(STATE.UNHOVERING)
	on_mouse = false
	pass # Replace with function body.
