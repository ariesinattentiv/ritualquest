extends Area2D

#I literally don't know what this does it's soo complicated
func _on_body_entered(_body: Node2D) -> void:
	$AudioStreamPlayer.play()

func _on_body_exited(_body: Node2D) -> void:
	$AudioStreamPlayer.stop()
