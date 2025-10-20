extends Node


signal move_player(spawn_pos: Vector2)


func travel(room,door):
	var spawn = get_node("../test scene/"+room+"/"+door+"/Spawn") as Marker2D
	var spawn_point = spawn.global_position as Vector2
	move_player.emit(spawn_point)
