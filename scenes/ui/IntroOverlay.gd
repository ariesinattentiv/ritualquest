extends Control

@export var lines: Array[String] = [
	"In an abandoned research institute…",
	"Scattered notes speak of a ritual left unfinished.",
	"Decode the circle. Place the candles. Find the words.",
	"And decide if the ritual should ever be completed."
]
@export var line_hold: float = 2.2
@export var line_fade: float = 0.6
@export var blackout_fade: float = 1.2

@onready var black: ColorRect = $Black
@onready var subs: RichTextLabel = $Subtitles

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	top_level = true
	set_anchors_preset(Control.PRESET_FULL_RECT)

	# make sure draw order is correct: black below, text above
	if subs.get_index() < black.get_index():
		move_child(subs, get_child_count() - 1)

	# start states
	black.color = Color(0, 0, 0, 1.0)   # use ColorRect.color (more reliable than modulate)
	subs.modulate.a = 0.0
	subs.bbcode_enabled = true
	subs.autowrap_mode = TextServer.AUTOWRAP_WORD
	subs.scroll_active = false
	subs.add_theme_color_override("default_color", Color(0.93, 0.92, 0.98))
	subs.add_theme_font_size_override("normal_font_size", 24)

	_run_sequence()

func _run_sequence() -> void:
	await get_tree().process_frame
	await get_tree().create_timer(0.2).timeout  # tiny settle buffer

	for txt in lines:
		subs.text = "[center]" + txt + "[/center]"

		var t_in := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		t_in.tween_property(subs, "modulate:a", 1.0, line_fade)
		await t_in.finished

		await get_tree().create_timer(line_hold).timeout

		var t_out := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		t_out.tween_property(subs, "modulate:a", 0.0, line_fade)
		await t_out.finished

	# fade the black screen away by animating ColorRect.color alpha
	var t_black := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	t_black.tween_property(black, "color:a", 0.0, blackout_fade)
	await t_black.finished

	queue_free()
