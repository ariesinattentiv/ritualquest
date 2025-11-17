extends SubViewport

var current_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.open_screen.connect(make_visible)
	for i in get_children():
		i.visible = false
	
	$Bookspawn.visible = true


func make_visible(node_name:String):
	current_screen = node_name
	get_node(node_name).visible = true
	$Close.visible = true
	$Tintcon.visible = true


func _on_close_pressed() -> void:
	get_node(current_screen).visible = false
	$Close.visible = false
	$Tintcon.visible = false
