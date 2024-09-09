extends Projectile
class_name Fire

func _ready() -> void:
	$AnimationPlayer.play("fire_grow")
