extends MarginContainer
class_name GSP_Page

@onready var _PageElementsList = %PageElementsList
@onready var _DemoPicture = %DemoPicture
@onready var _LabelInfo = %LabelInfo
@onready var _SideInfoContainer = %SideInfoContainer
@onready var _SideInfoSeparator = %SideInfoSeparator
@onready var _SideInfoInsideSeparator = %SideInfoInsideSeparator

var is_active := false

func _ready():
	_SideInfoContainer.hide()
	_SideInfoSeparator.hide()
	for i in _PageElementsList.get_children():
		if i is GSP_PageElement:
			i.connect("updated", self._on_page_element_updated)
			i.connect("focused", self._on_page_element_focused)
	update_ui()
	for i in _PageElementsList.get_children():
		if i is GSP_PageElement:
			i.emit_updated()
	pass

func update_ui():
	
	pass

func activate():
	is_active = true
	show()

func inactivate():
	is_active = false
	hide()

func _on_page_element_updated(page_element : GSP_PageElement, new_value : Variant):
	pass

func _on_page_element_focused(page_element : GSP_PageElement):
	if !page_element.side_info_picture and !page_element.side_info_text:
		_SideInfoContainer.hide()
		_SideInfoSeparator.hide()
	if page_element.side_info_picture and !page_element.side_info_text:
		_SideInfoContainer.show()
		_SideInfoSeparator.show()
		_SideInfoInsideSeparator.hide()
		_DemoPicture.show()
		_LabelInfo.hide()
	if !page_element.side_info_picture and page_element.side_info_text:
		_SideInfoContainer.show()
		_SideInfoSeparator.show()
		_SideInfoInsideSeparator.hide()
		_DemoPicture.hide()
		_LabelInfo.show()
	if page_element.side_info_picture and page_element.side_info_text:
		_SideInfoContainer.show()
		_SideInfoSeparator.show()
		_SideInfoInsideSeparator.show()
		_DemoPicture.show()
		_LabelInfo.show()
	
	_DemoPicture.texture = page_element.demo_picture
	_LabelInfo.text = tr(page_element.info_text)
	pass
