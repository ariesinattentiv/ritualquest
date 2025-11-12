extends CharacterBody2D

class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

## Connects the [method Player.change_rooms] method to the [signal NavManager.move_player] signal
## from nav_manager script, so [method Player.change_rooms] is called when the [signal NavManager.move_player]
## signal is emitted
func _ready():
	SignalHub.move_player.connect(change_rooms)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	play_walk_animation(direction)

func play_walk_animation(direction):
	# Check if the velocity is zero. If so, stay idle.
	# If not, check the direction the player is going and play the appropriate walk animation.
	if direction != 0:
		if direction > 0:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("idle")

## Moves the player to the target door
## Called when [signal NavManager.move_player] signal is emitted
## [param spawn]: the global position of the Marker2D node of the target door
func change_rooms(spawn: Vector2):
	global_position = spawn
