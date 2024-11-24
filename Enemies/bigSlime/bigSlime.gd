extends KinematicBody2D

# Stats
var health = 150
const DAMAGE = 15
const SPEED = 200

# Meta
var velocity = Vector2.ZERO
var _player = null
var _heart = preload("res://Objects/Items/ItemHealthBoost.tscn")



# Build in
func _process(delta):
	$LifeBar.value = health
	
	if _player:
		velocity = position.direction_to(_player.position) * SPEED
	move_and_slide(velocity)



# Signals
func _on_FollowArea_entered(body):
	if body.is_in_group("player"):
		_player = body
	
func _on_FollowArea_exited(body):
	if body.is_in_group("player"):
		_player = null

func _on_SlimeArea_entered(body):
	if body.is_in_group("player"):
		body.handle_hit(DAMAGE)



# Own Functions
func handle_hit(player_damage):
	health -= player_damage
	
	if health <= 0:
		randomize()
		if randi() % 10 + 1 > 9:
			spawn_heart(position)
	
		queue_free()

func spawn_heart(position_input):
	var heart_instance = _heart.instance()
	heart_instance.position = position_input
	heart_instance.scale.x = 0.1
	heart_instance.scale.y = 0.1
	get_tree().get_root().add_child(heart_instance)
