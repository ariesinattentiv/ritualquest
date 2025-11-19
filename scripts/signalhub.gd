extends Node


signal move_player(spawn_pos: Vector2)
signal pin(pic: Sprite2D)
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

func pin_photo(img: Sprite2D):
	pin.emit(img)

func handle_interaction(source: String, booktitle = null):
	match source:
		"Library Bookcase 2":
			open_screen.emit("bookshelf")
		"Draw circle":
			open_screen.emit("Circle drawing")
		"Bookshelf":
			open_book.emit(booktitle)
		"Plant table 1":
			TextPanel.display_text("This specimen is a typical mini saguaro cactus, not normally found in these regions. Its biological makeup is unremarkable, but its location is what gives me pause. Cacti cannot survive in these conditions, so why were so many seeds readily available?")
		"Plant table 2":
			TextPanel.display_text("This first specimen is an oddity - all plants of this variety grow in the exact same formation, regardless of external conditions. What's even stranger is the fact that its makeup is entirely root - no other parts of any kind that we've been able to find. The second specimen appears to be a perfectly average hydrangea sample.")
		"Library table":
			TextPanel.display_text("Here, we see the ancient runes that serve as the incantation for the ritual we are trying to perform. These incantations are typically written in an encoded manner, to prevent the immense power they hold from falling into the wrong hands. The risk of reciting such words without a proper guide and order is simply too great to attempt it. Decryption progress is ongoing.")
			# puts np_wordsofpower in the book
		"Archive shelf":
			TextPanel.display_text("This civilization made use of many written forms of expression, some seeming to be more artistic than communicative by intention. As an example, we have a theoretical key to tendrilis - an alphabet written through vines, usually used for decorative purposes.")
			# puts np_tendrilis in the book
		"H1Directory":
			TextPanel.display_text("<- Botany Lab
	Gemstone Lab ->")
		"H2Directory":
			TextPanel.display_text("<- Gemstone Lab
	Ritual Chamber ->")
		"H3Directory":
			TextPanel.display_text("<- Ritual Chamber
	Library ->")
