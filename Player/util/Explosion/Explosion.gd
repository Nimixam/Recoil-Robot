extends AnimatedSprite

# Signals
func _on_Explosion_animation_finished():
	queue_free()
