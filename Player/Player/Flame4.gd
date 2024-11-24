extends Node2D


var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	var r = random.randf_range(0,1)
	$AnimationPlayer.seek(r, false)
