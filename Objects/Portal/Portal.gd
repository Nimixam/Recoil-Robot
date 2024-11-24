extends StaticBody2D

# Meta
var rooms = []
var room_counter = 1


# Build in
func _ready():
	self.set_visible(false)
	self.get_node("PortalArea").set_deferred("monitoring", false)
	
	build_rooms()

func _process(delta):
	if not get_tree().current_scene.filename.begins_with("res://Scenes/rooms/"):
		return
		
	var group_nodes = get_tree().get_nodes_in_group("enemy")
	
	if group_nodes.size():
		self.set_visible(false)
		self.get_node("PortalArea").set_deferred("monitoring", false)
		return
	
	rotate(0.03)

	if not self.visible:
		# Move Portal over all other nodes
		var _portal = self.get_node("/root/GlobalPortal")
		var _parent = _portal.get_parent()
		var child_count = _parent.get_child_count()
		_parent.move_child(_portal, child_count - 2)
		
		self.set_visible(true)
		self.get_node("PortalArea").set_deferred("monitoring", true)



# Signals
func _on_PortalArea_body_entered(body):
	if body.is_in_group("player"):
		body.move_and_slide(Vector2.ZERO)
		body.position = Vector2(960, 540)
		for child in get_tree().get_root().get_children():
			if child.is_in_group("bullet"):
				child.queue_free()
		
		get_tree().change_scene(get_room())



# Own Functions
func build_rooms():
	rooms.clear()
	
	var dir = Directory.new()
	if dir.open("res://Scenes/rooms/scenes/") == OK:
		dir.list_dir_begin()
		var current_file = dir.get_next()
		while true:
			if not current_file:
				break
				
			if current_file.ends_with("tscn"):
				rooms.append("res://Scenes/rooms/scenes/" + current_file)
				
			current_file = dir.get_next()
	
	rooms.sort()

func get_room():
	if get_tree().current_scene.filename == "res://Scenes/rooms/Special/boss_room.tscn":
		return "res://Scenes/menus/scenes/Main.tscn"
	
	rooms.erase(get_tree().current_scene.filename)
	
	room_counter += 1
	
	randomize()
	if room_counter == 5:
		return "res://Scenes/rooms/Special/room_items.tscn"

	if room_counter == 9:
		return "res://Scenes/rooms/Special/boss_room.tscn"

	return rooms[randi() % rooms.size()]
