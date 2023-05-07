extends GSP_Page

var map := {
	"简体中文" : "zh",
	"English" : "en",
}

func _on_page_element_updated(page_element : GSP_PageElement, new_value : Variant):
	if page_element.id == "language":
		TranslationServer.set_locale(map.get(new_value[1]))
	pass
