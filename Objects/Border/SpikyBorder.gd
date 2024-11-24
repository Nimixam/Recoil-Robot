extends StaticBody2D

# Stats
const DAMAGE = 5



# Signals
func _on_DamageArea_entered(body):
	if body.is_in_group("player"):
		body.handle_hit(DAMAGE)
