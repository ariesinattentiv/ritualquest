extends Node

# Signal emitted whenever items change (added, removed, etc.)
signal changed

# A simple item data structure
class InvItem:
	var id: String = ""
	var name: String = ""
	var desc: String = ""
	var icon_path: String = ""

# The main inventory list
var items: Array[InvItem] = []

# Helper to create a new item
static func make_item(id: String, name: String, desc: String, icon_path: String) -> InvItem:
	var it := InvItem.new()
	it.id = id
	it.name = name
	it.desc = desc
	it.icon_path = icon_path
	return it

# Add an item and notify UI
func add_item(it: InvItem) -> void:
	items.append(it)
	emit_signal("changed")

# (Optional) clear all items
func clear() -> void:
	items.clear()
	emit_signal("changed")
