extends Projectile
class_name Lightning

var target_pos: Vector2

func _ready() -> void:
	global_position = target_pos
	$AnimationPlayer.play("lightning strike")
