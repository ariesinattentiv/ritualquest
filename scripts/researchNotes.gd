extends Node


var excerpts = []
var pages = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func build_notes():
	for i in range(excerpts.size()):
		var new_page = Page.new()
		pages.append(new_page)
		for j in 4:
			add_child(new_page)
			new_page.add_child(excerpts[i])
			i = i + 1
			
			

func add_element(excerpt: Node2D):
	excerpts.append(excerpt)
	
	


	
