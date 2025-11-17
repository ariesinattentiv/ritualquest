extends Node

var currentbook

var circle101 = preload("res://scenes/books/circle101.tscn")

func _ready() -> void:
	$Close.visible = false
	SignalHub.open_book.connect(display_book)

func display_book(title:String):
	$Close.visible = true
	match title:
		"Magic Circle 101":
			print("opening book")
			currentbook = circle101.instantiate()
			add_child(currentbook)

func close_book():
	$Close.visible = false
	currentbook.queue_free()
	
	
			
