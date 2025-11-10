extends Node2D

var pages = []
@onready var current_page = 0

var last_page

var note_scene = preload("res://scenes/note.tscn")
var blank_page = preload("res://scenes/page.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in $PageSpawn.get_children():
		if i is ReferenceRect:
			pages.append(i)
	
	render_page(0)


func _on_next_page_pressed() -> void:
	last_page = pages.get(current_page)
	var i = current_page + 1 # Adjust current page
	render_page(i)# call render page


func _on_previous_page_pressed() -> void:
	if current_page == 0:
		pass
	else:
		var i = current_page - 1
		render_page(i) # call render page



## Called when pages are flipped and when game starts up
func render_page(dest_page:int):
	# Play animation
	pages.get(current_page).visible = false # make the page player is turning from invisible
	current_page = dest_page # current page count update to the page player is turning to
	
	# if statement checks if the entry in the list for the page being turned to is null (there is no page there)
	# if there is no page, instantiate a new page scene, add it as a child
	# of the page area node, and add it to the list
	if current_page >= pages.size(): 
		var new_page = blank_page.instantiate()
		$PageSpawn.add_child(new_page)
		pages.append(new_page)
		
	pages.get(current_page).visible = true
	
	

func _on_new_note_pressed() -> void:
	var new_note = note_scene.instantiate()
	pages.get(current_page).add_child(new_note)
	new_note.position = Vector2(40,40)
