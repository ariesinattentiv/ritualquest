extends Node2D

@export var filepath:String # file path to folder with text files for the book
@export var max_pages:int

var currentpage
var textfile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"OuterControl/Next page".pressed.connect(next_page)
	$"OuterControl/Prev page".pressed.connect(last_page)
	currentpage = 1
	display_text()

func display_text():
	var temp = filepath.path_join(str(str(currentpage),".txt"))
	print(temp)
	textfile = FileAccess.open(temp, FileAccess.READ)
	TextPanel.display_text(textfile.get_as_text())
		
	
func next_page():
	if currentpage < max_pages:
		$OuterControl.get_node(str(currentpage)).visible = false
		currentpage += 1
		$OuterControl.get_node(str(currentpage)).visible = true
	display_text()
	
func last_page():
	if currentpage > 1:
		$OuterControl.get_node(str(currentpage)).visible = false
		currentpage -= 1
		$OuterControl.get_node(str(currentpage)).visible = true
