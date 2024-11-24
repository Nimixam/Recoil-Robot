extends StaticBody2D

var _player = null
var _heart = load("res://Objects/Items/ItemHealthBoost.tscn")


func _on_ItemArea_body_entered(body):
	if body.is_in_group("player"):
		_player = body
		if _player.health < 100:
			_player.health += 20
#		
		self.queue_free()
