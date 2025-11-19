extends Area2D

@export var title:String

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_event.connect(_on_input_event)
	selected = false


func _on_mouse_entered() -> void:
	print("mouse entered book")
	TextPanel.display_text(title)
	selected = true
	
func _on_mouse_exited() -> void:
	selected = false


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and selected and event.pressed:
		SignalHub.handle_interaction("Bookshelf",title)
