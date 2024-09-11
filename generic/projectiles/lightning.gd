extends Projectile
class_name Lightning

var target: Enemy

func _ready() -> void:
	global_position = target.marker.global_position
	# this ensures that only one opponent will be hit
	target.hitbox_component.health -= damage
	$AnimationPlayer.play("lightning strike")
