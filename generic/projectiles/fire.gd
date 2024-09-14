extends Projectile
class_name Fire

var animation: String = "fire_grow"

var impact_radius: int:
	set(radius):
		$CollisionShape2D.shape.radius = radius
		if radius > 30:
			animation = "fire_grow_big"

func _ready() -> void:
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play(animation)
