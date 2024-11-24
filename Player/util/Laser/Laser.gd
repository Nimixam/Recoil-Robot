extends RigidBody2D

# Stats
const ENEMY_DAMAGE = 10
const PLAYER_DAMAGE = 10
var damage = 0

# Meta
var _explosion = preload("res://Player/util/Explosion/Explosion.tscn")


# Signals
func _on_Bullet_body_entered(body):
	var explosion_instance = _explosion.instance()
	explosion_instance.position = get_global_position()
	get_tree().get_root().add_child(explosion_instance)
	queue_free()
	
	if body.is_in_group("player"):
		damage = ENEMY_DAMAGE
	else:
		var _player = self.get_node("/root/Player")
		damage = PLAYER_DAMAGE + _player.bonus_damage
	
	if body.has_method("handle_hit"):
		body.handle_hit(damage)
