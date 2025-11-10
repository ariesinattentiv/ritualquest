extends Camera2D

# Takes the player and the size of the screen as variables.
@export var player: Player
@export var size: Vector2i = get_viewport_rect().size

# Updates the camera position when the scene is initialized.
func _ready() -> void:
	update_position()

# Updates the camera position when the player moves out of its range.
func _physics_process(_delta) -> void:
	update_position()

# Updates the camera angle by moving it to the player's position.
# This is calculated by taking the player's position onscreen divided by the viewport,
# this is then multiplied by the size of the camera itself.
func update_position() -> void:
	var current_cell: Vector2i = Vector2i(player.global_position) / 810
	global_position = current_cell * 810
