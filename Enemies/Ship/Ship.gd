extends KinematicBody2D

# Stats
var health = 200
const DAMAGE = 15
const SPEED = 10

# Meta
var velocity = Vector2.ZERO
onready var _agent: NavigationAgent2D = $NavigationAgent2D
onready var _timer = $Timer
onready var _sprite = $Sprite
onready var _player = get_node("/root/Player")
var _heart = preload("res://Objects/Items/ItemHealthBoost.tscn")



# Build in
func _ready():
	_timer.connect("timeout", self, "update_pathfinding")

func _process(delta):
	#Update health bar
	$LifeBar.value = health
	
	
	if _agent.is_navigation_finished():
		return

	var target_global_position = _agent.get_next_location()
	var direction = global_position.direction_to(target_global_position)

	var desired_velocity = direction * _agent.max_speed
	var steering = (desired_velocity - velocity) * delta * SPEED
	velocity += steering

	velocity = move_and_slide(velocity)
	_sprite.rotation = lerp_angle(_sprite.rotation, velocity.angle(), 10.0 * delta)



# Signals
func _on_ShipArea_entered(body):
	if body.is_in_group("player"):
		body.handle_hit(DAMAGE)



# Own Functions
func update_pathfinding():
	_agent.set_target_location(_player.global_position)

func handle_hit(player_damage):
	health -= player_damage
	
	if health <= 0:
		if randi() % 10 + 1 > 7:
			spawn_heart(position)
		queue_free()
		
func spawn_heart(position_input):
	var heart_instance = _heart.instance()
	heart_instance.position = position_input
	heart_instance.scale.x = 0.1
	heart_instance.scale.y = 0.1
	get_tree().get_root().add_child(heart_instance)

