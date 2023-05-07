@tool
extends GSP_PageElement
class_name GSP_PageElementValueSlider

@export var title := "@s_Title":
	set(_title):
		title = _title
		if is_instance_valid(_LabelTitle):
			_LabelTitle.text = title
		
@export var min_value : float = 0:
	set(_min_value):
		min_value = _min_value
		update_ui()

@export var max_value : float = 100:
	set(_max_value):
		max_value = _max_value
		update_ui()

@export var step : float = 1:
	set(_step):
		step = _step
		update_ui()

@export_range(0, 3, 1) var decimals : int = 0:
	set(_decimals):
		decimals = _decimals
		update_ui()

@onready var _LabelTitle = %LabelTitle
@onready var _Slider = %Slider
@onready var _LabelValue = %LabelValue

@export var current_value := 0.0:
	set(_current_value):
		current_value = _current_value
		update_ui()
	

var is_dragging := false

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	update_ui()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	super._process(_delta)
	if is_dragging:
		_LabelValue.text = str(_Slider.value).pad_decimals(decimals)
	pass

func emit_updated():
	emit_signal("updated", self, current_value)
	pass

func update_ui():
	super.update_ui()
	if is_instance_valid(_LabelTitle):
		_LabelTitle.text = title
		if need_for_restart:
			_LabelTitle.text = tr(_LabelTitle.text) + " (%s)" % tr("@s_EditNeedForRestart")
	if is_instance_valid(_Slider):
		_Slider.min_value = min_value
		_Slider.max_value = max_value
		_Slider.step = step
		_Slider.value = current_value
	if is_instance_valid(_LabelValue):
		_LabelValue.text = str(current_value).pad_decimals(decimals)
	pass

func serialize() -> Dictionary:
	return {
		"current_value" : current_value,
	}
	pass

func unserialize(dic : Dictionary):
	if dic.has("current_value"):
		current_value = dic.current_value
	pass

func _on_slider_drag_ended(value_changed):
	is_dragging = false
	current_value = _Slider.value
	emit_updated()
	pass # Replace with function body.


func _on_slider_drag_started():
	is_dragging = true
	pass # Replace with function body.
