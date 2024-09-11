extends Projectile
class_name Fire

var animation: String = "fire_grow"

var impact_radius: int:
	set(radius):
		$CollisionShape2D.shape.radius = radius
		animation = "fire_grow_big"

func _ready() -> void:
	$AnimationPlayer.play(animation)
