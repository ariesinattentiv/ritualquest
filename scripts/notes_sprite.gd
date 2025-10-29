extends Control

var page_array = $ResearchNotes.pages
@onready var current_page = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	render_page()


func _on_next_page_pressed() -> void:
	# Play animatio 
	current_page += 2 # Adjust current page
	render_page()# call render page


func _on_previous_page_pressed() -> void:
	# Play animation
	current_page -= 2 # Adjust current page
	render_page() # call render page

## Called when pages are flipped and when game starts up
## Children of page1 and page2 control nodes hold the Node2D objects that are the
## pages with the individual "excerpt" objects 
func render_page():
	for child in $"page 1".get_children():
		child.queue_free()
	for child in $"page 2".get_children():
		child.queue_free()
	
	$page1.add_child(current_page)
	$page2.add_child(current_page + 1)
