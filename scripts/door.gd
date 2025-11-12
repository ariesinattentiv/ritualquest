extends Area2D

## Door class defines a door that can be placed in rooms, player
## can interact with it to move from room to room. Uses custom properties
## to define what door it links to
## [member Door.door_tag], [member Door.destination_room], and [member Door.destination_door] are assigned for each instance of a door
class_name Door

## Door identification
@export var door_tag: String
## Room that the target door is within (must match the parent node of
## the scene that the target door is in)
@export var destination_room: String
## Target door to travel to, must match the door's [member Door.door_tag]
@export var destination_door: String

@onready var player_colliding = false

## Called when the node enters the scene tree for the first time.
## Sets current animation to open since doors will start as closed
## at the beginning, sets frame to 0 (that's the frame where the
## door is closed).
func _ready() -> void:
	$AnimatedSprite2D.animation = "open"
	$AnimatedSprite2D.frame = 0


## Called every frame. 'delta' is the elapsed time since the previous frame.
## Detects if key bound to the interact action is pressed and if player_colliding
## is true, calls the [method NavManager.travel] function from the NavManager global script with
## the [member Door.destination_room] and [member Door.destination_door] properties from the given door.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_colliding == true:
		SignalHub.travel(destination_room,destination_door)


## When player enters CollisionShape2D of door, the
## [signal Door.body_entered] signal from Door (of type [Area2D]) emits and calls [method Door._on_body_entered].
## Plays open animation and changes player_colliding boolean to true
func _on_body_entered(_body: Node2D) -> void:
	$AnimatedSprite2D.animation = "open"
	$AnimatedSprite2D.play()
	player_colliding = true

## When player exits CollisionShape2D of door, the
## [signal Door.body_exited] signal from Door emits and calls [method Door._on_body_exited].
## Plays close animation and changes player_colliding boolean to false
func _on_body_exited(_body: Node2D) -> void:
	$AnimatedSprite2D.animation = "close"
	$AnimatedSprite2D.play()
	player_colliding = false
