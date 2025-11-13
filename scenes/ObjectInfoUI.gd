extends CanvasLayer

@onready var panel := $panel
@onready var label := $panel/InfoText

var current_owner: Node = null

func show_info(text: String, owner: Node) -> void:
	current_owner = owner
	panel.visible = true      # keep panel on
	label.text = text         # show text

func hide_info(owner: Node = null) -> void:
	# Only clear if the current owner is the one hiding it (or force hide)
	if owner == null or owner == current_owner:
		label.text = ""       # CLEAR TEXT
		# DO NOT hide the panel anymore
		current_owner = null
