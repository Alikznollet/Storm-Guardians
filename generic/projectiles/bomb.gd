extends Projectile
class_name Bomb

var target: Enemy
var explo_radius_modifier: float:
	set(modifier):
		$CollisionShape2D.shape.radius = 20 * modifier
@export var stun_time: float

func _ready() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target.marker.global_position, 0.2).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	$AnimationPlayer.play("bomb explo")
	
