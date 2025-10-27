extends GridContainer

func _ready() -> void:
	var Inv = get_node_or_null("/root/Inventory")
	if Inv == null:
		push_error("Autoload 'Inventory' not found!")
		return
	Inv.connect("changed", Callable(self, "_rebuild"))
	_rebuild()

func _rebuild() -> void:
	for c in get_children():
		c.queue_free()

	var Inv = get_node_or_null("/root/Inventory")
	if Inv == null:
		return

	print("InventoryGrid: items=", Inv.items.size())

	for it in Inv.items:
		var lbl := Label.new()
		lbl.text = it.name
		lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		add_child(lbl)
