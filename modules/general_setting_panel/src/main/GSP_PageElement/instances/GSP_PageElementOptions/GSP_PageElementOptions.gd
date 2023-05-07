@tool
extends GSP_PageElement
class_name GSP_PageElementOptions

@export var title := "@s_Title":
	set(_title):
		title = _title
		if is_instance_valid(_LabelTitle):
			_LabelTitle.text = title
		
@export var options : Array[String]:
	set(_options):
		options = _options
		update_ui()
	

@onready var _LabelTitle = %LabelTitle
@onready var _OptionButton = %OptionButton

@export var current_idx := 0:
	set(_current_idx):
		current_idx = _current_idx
		update_ui()
var current_option_text := ""

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	update_ui()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func emit_updated():
	emit_signal("updated", self, [current_idx, current_option_text])
	pass

func update_ui():
	super.update_ui()
	if is_instance_valid(_LabelTitle):
		_LabelTitle.text = title
		if need_for_restart:
			_LabelTitle.text += " (@s_EditNeedForRestart)"
	if is_instance_valid(_OptionButton):
		_OptionButton.clear()
		for i in options:
			if i == "":
				_OptionButton.add_separator()
			else:
				_OptionButton.add_item(i)
		if options.size() >= current_idx + 1:
			current_option_text = options[current_idx]
		if _OptionButton.item_count >= current_idx + 1:
			_OptionButton.select(current_idx)
	pass

func serialize() -> Dictionary:
	return {
		"idx" : current_idx,
		"text" : current_option_text,
	}
	pass

func unserialize(dic : Dictionary):
	if dic.has("idx") and dic.has("text"):
		current_idx = dic.idx
		assert(options[current_idx] == dic.text)
		current_option_text = options[current_idx]
	update_ui()
	pass

func _on_option_button_item_selected(index):
	current_idx = index
	current_option_text = options[index]
	emit_updated()
	pass # Replace with function body.
