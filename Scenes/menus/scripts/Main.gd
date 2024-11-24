extends Control

# Signals
func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/rooms/scenes/room_1.tscn")

func _on_OptionsButton_pressed():
	get_tree().get_root().get_child(0).set_visible(true)
	get_tree().current_scene.set_visible(true)

func _on_QuitButton_pressed():
	get_tree().quit()



# Own Functions
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible
