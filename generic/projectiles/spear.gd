extends Projectile
class_name Spear

@export var pierce: int = 4 # base pierce is 4

var direction: Vector2

func _ready() -> void:
	$AudioStreamPlayer2D.play()

func _process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_despawn_timer_timeout() -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	# TODO: make this hurt the enemy*
	pierce -= 1
	if pierce == 0:
		queue_free()
