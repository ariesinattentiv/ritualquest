extends Area2D

#I literally don't know what this does
func _on_body_entered(_body: Node2D) -> void:
	$AudioStreamPlayer.play()

func _on_body_exited(_body: Node2D) -> void:
	$AudioStreamPlayer.stop()
