extends CanvasLayer

# Build in
func _ready():
	set_visible(false)



# Signals
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

func _on_BackButton_pressed():
	set_visible(false)
	get_tree().current_scene.set_visible(true)
	for child in get_tree().get_root().get_children():
		if child.filename == "res://Scenes/menus/scenes/Main.tscn":
			get_tree().get_root().get_child(1).set_visible(false)
			return
			
	get_tree().get_root().get_child(1).set_visible(true)

func _on_FulllscreenSwitch_toggled(button_pressed):
	OS.set_borderless_window(button_pressed)
	OS.set_window_fullscreen(button_pressed)
	OS.set_window_size(Vector2(1280, 720))
