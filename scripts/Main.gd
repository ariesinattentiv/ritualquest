# res://scripts/Main.gd
extends Node

# -------- WORLD --------
@onready var player = get_node_or_null("WorldRoot/Player")
@onready var spawn  = get_node_or_null("WorldRoot/Room/SpawnPoint")

# -------- UI PANELS (names from your tree) --------
@onready var left_top    = get_node_or_null("UI/Root/Row/LeftCol/LeftTop")
@onready var left_bottom = get_node_or_null("UI/Root/Row/LeftCol/LeftBottom")
@onready var right_col   = get_node_or_null("UI/Root/Row/RightCol")

# convenience paths inside LeftTop
@onready var inv_box     = get_node_or_null("UI/Root/Row/LeftCol/LeftTop/MarginContainer/InvBox")
@onready var inv_title   = get_node_or_null("UI/Root/Row/LeftCol/LeftTop/MarginContainer/InvBox/InventoryTitle")
@onready var inv_grid    = get_node_or_null("UI/Root/Row/LeftCol/LeftTop/MarginContainer/InvBox/InventoryGrid")

func _ready() -> void:
	# 1) Drop any accidental UI focus so movement works
	await get_tree().process_frame
	var focused := get_viewport().gui_get_focus_owner()
	if focused:
		focused.release_focus()

	# 2) Optional safe spawn
	if player and spawn:
		player.global_position = spawn.global_position

	# 3) Inventory title + clear grid
	_setup_inventory()

	# 4) TEMP: Add a few items (requires Inventory autoload)
	if Engine.is_editor_hint() == false and Engine.is_in_physics_frame() == false:
		if Engine.has_singleton("Inventory") or (typeof(Inventory) == TYPE_OBJECT):
			Inventory.add_item(Inventory.make_item("potion", "Small Potion", "Heals a bit.", ""))
			Inventory.add_item(Inventory.make_item("note", "Crumpled Note", "‘Don’t go left.’", ""))

	# 5) Story (centered + bigger)
	_set_story("[b]Abandoned Institute[/b]\nThe air is thick with dust and silence.\nNotes hint at a ritual left unfinished — a circle, candles, half-written words.\nDiscover what they began… and if you dare to finish it.")



	# 6) Right-panel background
	_set_background("res://assets/background.png")

	# 7) Style dark translucent cards + nicer fonts (optional)
	_apply_styles()

	# 8) Make sure key UI nodes fill their panels
	_ensure_full_rect([
		"UI/Root/Row/LeftCol/LeftTop",
		"UI/Root/Row/LeftCol/LeftBottom",
		"UI/Root/Row/RightCol"
	])

	# 9) Final layout tweaks so title sits higher and stack is top-aligned
	var intro := preload("res://scenes/ui/IntroOverlay.tscn").instantiate()

	# Add to the root viewport so containers can't resize it
	get_tree().root.add_child(intro)

	# Belt & suspenders: ensure it covers the screen and sits on top
	intro.top_level = true
	intro.set_anchors_preset(Control.PRESET_FULL_RECT)
	intro.z_index = 9999



# ================= INPUT MAP (forced bindings) =================
func ensure_input_map() -> void:
	var binds := {
		"ui_left":  [KEY_A, KEY_LEFT],
		"ui_right": [KEY_D, KEY_RIGHT],
		"ui_up":    [KEY_W, KEY_UP],
		"ui_down":  [KEY_S, KEY_DOWN],
	}
	for action in binds.keys():
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		for code in binds[action]:
			var ev := InputEventKey.new()
			ev.keycode = code
			var already := false
			for existing in InputMap.action_get_events(action):
				if existing is InputEventKey and existing.keycode == code:
					already = true
					break
			if not already:
				InputMap.action_add_event(action, ev)


# ================= INVENTORY / STORY / BACKGROUND =================
func _setup_inventory() -> void:
	# Title text + center it; leave font size to the Inspector (no override)
	if inv_title:
		inv_title.text = "Inventory"
		inv_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	# clear any placeholder children in the grid (InventoryGrid.gd will repopulate)
	if inv_grid:
		for c in inv_grid.get_children():
			c.queue_free()

func _set_story(text: String) -> void:
	if not left_bottom: return
	var story = _first_descendant_of_type(left_bottom, "RichTextLabel") as RichTextLabel
	if story:
		story.bbcode_enabled = true
		story.autowrap_mode = TextServer.AUTOWRAP_WORD
		story.scroll_active = true
		story.text = "[center][font_size=22]" + text + "[/font_size][/center]"

func _set_background(tex_path: String) -> void:
	if not right_col: return
	var bg = _first_descendant_of_type(right_col, "TextureRect") as TextureRect
	if bg:
		var tex: Texture2D = load(tex_path)
		if tex:
			bg.texture = tex
			bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED


# ================= STYLING (optional polish) =================
func _apply_styles() -> void:
	var lt_panel := left_top as PanelContainer
	var lb_panel := left_bottom as PanelContainer
	var story     = _first_descendant_of_type(left_bottom, "RichTextLabel") as RichTextLabel

	if lt_panel:
		# Card style for Inventory panel
		var sb_top := _make_card(Color(0.08, 0.09, 0.12, 0.70), Color(0.38, 0.30, 0.50, 0.90))
		# Bring content higher: trim top padding
		sb_top.content_margin_top = 6
		sb_top.content_margin_left = 8
		sb_top.content_margin_right = 8
		sb_top.content_margin_bottom = 8
		lt_panel.add_theme_stylebox_override("panel", sb_top)

	if lb_panel:
		var sb_bot := _make_card(Color(0.08, 0.09, 0.12, 0.70), Color(0.50, 0.30, 0.38, 0.90))
		lb_panel.add_theme_stylebox_override("panel", sb_bot)

	# Optional fonts (safe if missing)
	var regular_path := "res://assets/fonts/Inter-Regular.ttf"
	var bold_path    := "res://assets/fonts/Inter-Bold.ttf"
	var font_regular: Font = null
	var font_bold: Font = null
	if ResourceLoader.exists(regular_path):
		font_regular = load(regular_path)
	if ResourceLoader.exists(bold_path):
		font_bold = load(bold_path)

	# DO NOT force Inventory title font size here; let Inspector control it.
	if inv_title and font_bold:
		inv_title.add_theme_font_override("font", font_bold)

	if story:
		if font_regular: story.add_theme_font_override("normal_font", font_regular)
		story.add_theme_font_size_override("normal_font_size", 18)
		story.add_theme_color_override("default_color", Color(0.96, 0.96, 0.98))
		story.add_theme_constant_override("line_separation", 6)

func _make_card(bg: Color, border: Color) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = bg
	s.corner_radius_top_left = 12
	s.corner_radius_top_right = 12
	s.corner_radius_bottom_left = 12
	s.corner_radius_bottom_right = 12
	s.border_color = border
	s.border_width_left = 1
	s.border_width_top = 1
	s.border_width_right = 1
	s.border_width_bottom = 1
	s.shadow_size = 8
	s.shadow_color = Color(0, 0, 0, 0.25)
	return s


# ---------- Inventory layout finetune ----------
func _tune_inventory_layout() -> void:
	# Put stack at the TOP of the card and tighten spacing
	if inv_box and inv_box is VBoxContainer:
		var vb := inv_box as VBoxContainer
		vb.alignment = BoxContainer.ALIGNMENT_BEGIN
		vb.add_theme_constant_override("separation", 8)  # <- this is the correct way


	# Make grid expand and behave like a list (columns set in Inspector if you want)
	if inv_grid and inv_grid is GridContainer:
		var g := inv_grid as GridContainer
		g.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		g.size_flags_vertical   = Control.SIZE_EXPAND_FILL
		# If you want a vertical list by default uncomment:
		# g.columns = 1


# ================= UTILITIES =================
func _ensure_full_rect(paths: Array[String]) -> void:
	for p in paths:
		var n = get_node_or_null(p)
		if n and n is Control:
			(n as Control).set_anchors_preset(Control.PRESET_FULL_RECT)

func _first_descendant_of_type(root: Node, type_name: String) -> Node:
	if not root: return null
	var q := [root]
	while q.size() > 0:
		var n: Node = q.pop_front()
		if n != root and n.get_class() == type_name:
			return n
		for child in n.get_children():
			q.push_back(child)
	return null
