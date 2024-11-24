extends Area2D

# Stats
const DAMAGE = 20
var player
onready var timer:Timer = get_node("Timer")
var is_taking_damage = false

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
	connect("body_exited", self, "_on_DamageArea_exited")

	print("Timer: ",timer)

func _on_DamageArea_entered(body):
	if body.is_in_group("player"):
		if not is_taking_damage:
			player = body
			print("Player entered: ",player)
			is_taking_damage = true
			timer.start()

func _on_timer_timeout():
	if is_taking_damage:
		player.handle_hit(DAMAGE)

func _on_DamageArea_exited(body):
	if body.is_in_group("player"):
		is_taking_damage = false
		print("Player exited: ",body)
		timer.stop()