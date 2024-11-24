extends KinematicBody2D

# Stats
var health = 100
var bonus_damage = 0

# Meta
onready var _LaserGun = $LaserGun
onready var _body_sprite = $BodySprite
onready var _head_sprite = $HeadSprite
var can_fire = true
var GUN_DISTANCE = 50
const SPRITE_MAP = {
	"BODY_UP": preload("res://Player/Player/body_up.png"),
	"BODY_RIGHT": preload("res://Player/Player/body_right.png"),
	"BODY_DOWN": preload("res://Player/Player/body_down.png"),
	"BODY_LEFT": preload("res://Player/Player/body_left.png"),
	
	"HEAD_UP": preload("res://Player/Player/head_up.png"),
	"HEAD_RIGHT": preload("res://Player/Player/head_right.png"),
	"HEAD_DOWN": preload("res://Player/Player/head_down.png"),
	"HEAD_LEFT": preload("res://Player/Player/head_left.png")
}
const _LASER_GUN_BLUE = preload("res://Player/LaserGun/LaserGun.png")


# Build in
func _ready():
	self.set_visible(false)

func _process(delta):
	if not get_tree().current_scene.filename.begins_with("res://Scenes/rooms/"):
		return
	
	self.set_visible(true)
	var _player = self.get_node("/root/Player")
	var _parent = _player.get_parent()
	var child_count = _parent.get_child_count()
	_parent.move_child(_player, child_count - 1)
	
	# Sets the sprite facing direction
	var mouse_direction = global_position.direction_to(get_global_mouse_position())
	var degree = rad2deg(mouse_direction.angle_to(Vector2.UP))
	
	if degree < 45.0 and degree > -45.0:
		_body_sprite.texture = SPRITE_MAP["BODY_UP"]
		_head_sprite.texture = SPRITE_MAP["HEAD_UP"]
		
	elif degree < -45.0 and degree > -135:
		_body_sprite.texture = SPRITE_MAP["BODY_RIGHT"]
		_head_sprite.texture = SPRITE_MAP["HEAD_RIGHT"]
		
	elif degree > 135.0 or degree < -135:
		_body_sprite.texture = SPRITE_MAP["BODY_DOWN"]
		_head_sprite.texture = SPRITE_MAP["HEAD_DOWN"]
		
	elif degree > 45.0 and degree < 135:
		_body_sprite.texture = SPRITE_MAP["BODY_LEFT"]
		_head_sprite.texture = SPRITE_MAP["HEAD_LEFT"]
	
	#Update health bar
	$LifeBar.value = health
	
	# Updates LaserGun position
	var parent_to_mouse = global_position.direction_to(get_global_mouse_position())
	_LaserGun.set_global_position(
		Vector2(
			global_position.x + GUN_DISTANCE * parent_to_mouse.x,
			global_position.y + GUN_DISTANCE * parent_to_mouse.y
		)
	)
	
	# Updates LaserGun rotation
	var relative_child_position = to_local(_LaserGun.get_global_position())
	_LaserGun.look_at(
		Vector2(
			global_position.x - relative_child_position.x,
			global_position.y - relative_child_position.y
		)
	)
	
	# Let's the player shot
	if Input.is_action_pressed("fire") and can_fire:
		if global_position.distance_to(get_global_mouse_position()) > GUN_DISTANCE:
			var output = _LaserGun.fire()
			move_and_slide(output[0])
			can_fire = false
			yield(get_tree().create_timer(output[1]), "timeout")
			can_fire = true



# Own Functions
func handle_hit(enemy_damage):
	health -= enemy_damage
	
	if health <= 0:
		# Frees all stray bullets
		for child in get_tree().get_root().get_children():
			if child.is_in_group("bullet"):
				child.queue_free()
		health = 100
		bonus_damage = 0
		global_position = Vector2(960, 540)
		_LaserGun._sprite.texture = _LASER_GUN_BLUE
		var _portal = self.get_node("/root/GlobalPortal")
		_portal.build_rooms()
		_portal.room_counter = 1
		get_tree().change_scene("res://Scenes/menus/scenes/Main.tscn")
