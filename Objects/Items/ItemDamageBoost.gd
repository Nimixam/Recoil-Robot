extends StaticBody2D


var _player = null
const _LASER_GUN_GREEN = preload("res://Player/LaserGun/LaserGun_green.png")


func _on_ItemArea_body_entered(body):
	if body.is_in_group("player"):
		_player = body
		_player.bonus_damage += 10
		_player._LaserGun._sprite.texture = _LASER_GUN_GREEN
#		
		self.queue_free()
