extends Node2D

@export var filepath:String # file path to folder with text files for the book

var currentpage
var textfile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"OuterControl/Next page".pressed.connect(next_page)
	$"OuterControl/Last page".pressed.connect(last_page)
	currentpage = 1

func display_text():
	#temp = .path_join()
	#textfile = FileAccess.open(filepath)
	pass
	
func next_page():
	currentpage += 1
	display_text()
	
func last_page():
	pass
