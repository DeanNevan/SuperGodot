extends Control
class_name GSP_GeneralSettingPanel

@onready var _TabButtonsList = %TabButtonsList
@onready var _PageContainer = %PageContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	#TranslationServer.set_locale("en")
	for i in _TabButtonsList.get_children():
		if i is GSP_TabButton:
			i.connect("pressed", self._on_tab_button_pressed.bind(i))
	pass # Replace with function body.


func _on_tab_button_pressed(button : GSP_TabButton):
	if is_instance_valid(button.page):
		for i in _PageContainer.get_children():
			i.inactivate()
		button.page.activate()
	pass
