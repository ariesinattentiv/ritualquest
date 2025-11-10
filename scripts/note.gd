extends ColorRect

var dragging = false
var prev_mouse_pos:Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Delete.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		var current_mouse_pos = get_viewport().get_mouse_position()
		var mouse_delta = current_mouse_pos - prev_mouse_pos
		global_position += mouse_delta
		prev_mouse_pos = current_mouse_pos


func _on_drag_button_button_down() -> void:
	dragging = true
	prev_mouse_pos = get_viewport().get_mouse_position()
	

func _on_drag_button_button_up() -> void:
	dragging = false


func _on_mouse_entered() -> void:
	$Delete.visible = true


func _on_mouse_exited() -> void:
	$Delete.visible = false


func _on_delete_pressed() -> void:
	print("delete pressed")
	self.queue_free()
