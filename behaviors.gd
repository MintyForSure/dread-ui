extends Sprite3D
var rng=RandomNumberGenerator.new()
var speedRNG=rng.randf_range(0.7, 1.2)
func _ready() -> void:
	print(speedRNG)
	$mareAnims.play("idle",-1,speedRNG)
