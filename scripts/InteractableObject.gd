extends Area2D

@export_multiline var prompt_text := "Press E to interact"
@export var object_name := "Object"
@export var info_text := "No description yet."

var player_in_range := false

func _ready() -> void:
	# Ensure signals are connected even if the editor connections were missed
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

	if has_node("Prompt"):
		$"Prompt".visible = false
		$"Prompt".text = prompt_text

	monitoring = true
	monitorable = true
	set_process(true)

func _on_body_entered(body: Node) -> void:
	print("ENTER:", body.name)
	if body.is_in_group("Player"):
		player_in_range = true
		if has_node("Prompt"): $"Prompt".visible = true

func _on_body_exited(body: Node) -> void:
	print("EXIT:", body.name)
	if body.is_in_group("Player"):
		player_in_range = false
		if has_node("Prompt"): $"Prompt".visible = false
	_send_hide_info()

func _process(_dt: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		_send_show_info(info_text)
		SignalHub.handle_interaction(object_name)

func _send_show_info(text: String) -> void:
	var ui := get_tree().get_first_node_in_group("ObjectInfoUI")
	if ui and ui.has_method("show_info"):
		ui.show_info(text, self)

func _send_hide_info() -> void:
	var ui := get_tree().get_first_node_in_group("ObjectInfoUI")
	if ui and ui.has_method("hide_info"):
		ui.hide_info(self)
