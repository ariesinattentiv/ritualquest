extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Pin.visible = false


func _on_mouse_entered() -> void:
	$Pin.visible = true


func _on_mouse_exited() -> void:
	$Pin.visible = false


func _on_pin_pressed() -> void:
	SignalHub.pin_photo(texture)
