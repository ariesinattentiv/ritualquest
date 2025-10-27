extends CharacterBody2D
@export var speed: float = 220.0

func _physics_process(_delta: float) -> void:
	var dir := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down")  - Input.get_action_strength("ui_up")
	)
	if dir.length() > 1.0:
		dir = dir.normalized()

	velocity = dir * speed
	move_and_slide()

	# DEBUG
	if Engine.get_physics_frames() % 15 == 0:
		print("tick dir=", dir, " vel=", velocity)
