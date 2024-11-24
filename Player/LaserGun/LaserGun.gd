extends Node2D

# Stats
const SPEED = 4000
const FIRE_RATE = 0.07
const BULLET_SPEED = 1000

# Meta
var _laser = preload("res://Player/util/Laser/Laser.tscn")
var bulletpoints = []
onready var _sprite = $Sprite



# Build in
func _ready():
	for bulletpoint in $BulletPoints.get_children():
		bulletpoints.append(bulletpoint)
	



# Own Functions
func fire():
	for bulletpoint in bulletpoints:
		var bullet_instance = _laser.instance()
		bullet_instance.position = bulletpoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(-BULLET_SPEED, 0).rotated(rotation))
		
		get_tree().get_root().add_child(bullet_instance)
	
	var velocity = global_position.direction_to(get_global_mouse_position()) * SPEED
	
	return [-velocity, FIRE_RATE]
