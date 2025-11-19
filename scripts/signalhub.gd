extends Node


signal move_player(spawn_pos: Vector2)
signal pin(pic: Texture2D)
signal open_screen(node_name:String)
signal open_book(book_title:String)

## travel function emits the move_player signal that is linked to
## the [method Player.change_rooms] function in the player script, passing
## the global position from the Marker2D node of the target door as a parameter.
## Called from door script
## [param room]: room from [member Door.destination_room]
## [param door]: door from [member Door.destination_door]
func travel(room,door):
	var spawn = get_node("../main/"+room+"/"+door+"/Spawn") as Marker2D
	var spawn_point = spawn.global_position as Vector2
	move_player.emit(spawn_point)

func pin_photo(img: Texture2D):
	pin.emit(img)

func handle_interaction(source: String, booktitle = null):
	match source:
		"Library Bookcase 2":
			open_screen.emit("bookshelf")
		"Draw circle":
			open_screen.emit("Circle drawing")
		"Bookshelf":
			open_book.emit(booktitle)
