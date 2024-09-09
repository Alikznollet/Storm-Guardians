extends Projectile
class_name Bomb

var explo_position: Vector2

func _ready() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", explo_position, 0.5)
	
	await tween.finished
	$AnimationPlayer.play("bomb explo")
	
