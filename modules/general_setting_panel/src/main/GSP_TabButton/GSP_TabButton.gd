extends Button
class_name GSP_TabButton

@export var page_node_path : NodePath
@onready var page : GSP_Page = get_node(page_node_path)
