extends Node


signal move_player(spawn_pos: Vector2)

## travel function emits the move_player signal that is linked to
## the [method Player.change_rooms] function in the player script, passing
## the global position from the Marker2D node of the target door as a parameter.
## Called from door script
## [param room]: room from [member Door.destination_room]
## [param door]: door from [member Door.destination_door]
func travel(room,door):
	var spawn = get_node("../test scene/"+room+"/"+door+"/Spawn") as Marker2D
	var spawn_point = spawn.global_position as Vector2
	move_player.emit(spawn_point)
