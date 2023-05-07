@tool
extends GSP_PageElement
class_name GSP_PageElementCheckButton

@export var title := "@s_Title":
	set(_title):
		title = _title
		update_ui()
		
@onready var _LabelTitle = %LabelTitle
@onready var _CheckButton = %CheckButton

var status := false

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	update_ui()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func emit_updated():
	emit_signal("updated", status)
	pass

func update_ui():
	super.update_ui()
	if is_instance_valid(_CheckButton):
		_CheckButton.button_pressed = status
	if is_instance_valid(_LabelTitle):
		_LabelTitle.text = title
		if need_for_restart:
			_LabelTitle.text += " (@s_EditNeedForRestart)"
	pass

func serialize() -> Dictionary:
	return {
		"status" : status
	}
	pass

func unserialize(dic : Dictionary):
	if dic.has("status"):
		status = dic.status
	update_ui()
	pass

func _on_check_button_toggled(button_pressed):
	status = button_pressed
	emit_updated()
	update_ui()
	pass # Replace with function body.
