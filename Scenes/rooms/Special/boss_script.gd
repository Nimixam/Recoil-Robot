extends Node2D

func _ready():
	if get_tree().current_scene.filename == "res://Scenes/rooms/Special/boss_room.tscn":
		var player = get_node("/root/Player")
		player.scale = Vector2(0.5, 0.5)
		player.GUN_DISTANCE = 25
