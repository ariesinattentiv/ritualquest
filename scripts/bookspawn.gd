extends Node

var circle101 = preload("res://scenes/books/circle101.tscn")

func _ready() -> void:
	$Close.visible = false
	SignalHub.open_book.connect(display_book)

func display_book(title:String):
	$Close.visible = true
	match title:
		"Magic Circle 101":
			print("opening book")
			add_child(circle101.instantiate())
			

func close_book():
	$Close.visible = false
	get_child(1).queue_free()
	
	
			
