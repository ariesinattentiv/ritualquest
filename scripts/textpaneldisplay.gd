extends Node

@onready var textbox = get_tree().get_first_node_in_group("textpanel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#textbox.text = ""
	pass

func display_text(intext:String):
	textbox.text = intext
