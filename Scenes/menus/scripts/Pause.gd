extends CanvasLayer

# Build in
func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("pause") and get_tree().current_scene.filename != "res://Scenes/menus/scenes/Main.tscn":
		set_visible(true)
		for node in get_tree().current_scene.get_children():
			loop_children(node, false)



# Signals
func _on_ResumeButton_pressed():
	set_visible(false)
	for node in get_tree().current_scene.get_children():
		loop_children(node, true)

func _on_OptionsButton_pressed():
	get_tree().get_root().get_child(0).set_visible(true)
	get_tree().get_root().get_child(1).set_visible(false)
	get_tree().get_root().get_child(2).set_visible(false)

func _on_QuitButton_pressed():
	get_tree().quit()



# Own Functions
func loop_children(node, resume):
	for child in node.get_children():
		child.set_process(resume)
		if child.get_children().size() > 0:
			loop_children(child, resume)

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible
