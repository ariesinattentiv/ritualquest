extends Area2D

class_name Door

@export var door_tag: String
@export var destination_room: String
@export var destination_door: String

@onready var player_colliding = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "open"
	$AnimatedSprite2D.frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_colliding == true:
		NavManager.travel(destination_room,destination_door)

func _on_body_entered(_body: Node2D) -> void:
	$AnimatedSprite2D.animation = "open"
	$AnimatedSprite2D.play()
	player_colliding = true


func _on_body_exited(_body: Node2D) -> void:
	$AnimatedSprite2D.animation = "close"
	$AnimatedSprite2D.play()
	player_colliding = false
