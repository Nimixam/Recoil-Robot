extends StaticBody2D

# Stats
var health = 150
var BULLET_SPEED = 1000

# Meta
var can_fire = false
var _laser = preload("res://Player/util/Laser/Laser.tscn")
var _heart = preload("res://Objects/Items/ItemHealthBoost.tscn")
onready var _player = get_node("/root/Player")
onready var _timer := $Timer
var bulletpoints = []


# Build in
func _ready():
	for bulletpoint in $BulletPoints.get_children():
		bulletpoints.append(bulletpoint)
	
	_timer.connect("timeout", self, "can_fire")

func _process(delta):
	look_at(_player.global_position)
	$LifeBar.value = health
	
	if can_fire:
		for bulletpoint in bulletpoints:
			var bullet_instance = _laser.instance()
			bullet_instance.position = bulletpoint.get_global_position()
			bullet_instance.rotation_degrees = rotation_degrees
			bullet_instance.apply_impulse(Vector2(), Vector2(BULLET_SPEED, 0).rotated(rotation))
			
			if get_tree().current_scene.filename == "res://Scenes/rooms/Special/boss_room.tscn":
				bullet_instance.scale.x = bullet_instance.scale.x * 0.5
				bullet_instance.scale.y = bullet_instance.scale.y * 0.5
			
			get_tree().get_root().add_child(bullet_instance)
			
		can_fire = false



# Own Functions
func can_fire():
	can_fire = true

func handle_hit(player_damage):
	health -= player_damage
	
	if health <= 0:
		if randi() % 10 + 1 > 5:
			spawn_heart(position)
		queue_free()
		
func spawn_heart(position_input):
	var heart_instance = _heart.instance()
	heart_instance.position = position_input
	heart_instance.scale.x = 0.1
	heart_instance.scale.y = 0.1
	get_tree().get_root().add_child(heart_instance)

