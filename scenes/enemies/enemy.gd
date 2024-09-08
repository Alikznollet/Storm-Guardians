extends PathFollow2D
class_name Enemy

@export var speed: int = 20
@export var damage_on_base: int = 5
@export var health: int:
	set(newValue):
		health = newValue
	get:
		return health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
	
	if progress_ratio == 1:
		queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Projectile:
		_damage(area.damage)
	
func _damage(amount: int) -> void:
	health -= amount
	
