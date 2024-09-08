extends BaseTower

var can_throw: bool = true

var target: Enemy
@export var spear: PackedScene

func _physics_process(_delta: float) -> void:
	if not $Range.get_overlapping_areas().is_empty():
		var temptargets: Array[Area2D] = $Range.get_overlapping_areas()
		var targets: Array[Enemy] = []
		for targetarea in temptargets:
			targets.append(targetarea.get_parent())
		
		targets.sort_custom(_sort_first)
		target = targets.front()
		$Weapon.look_at(target.global_position)
	else:
		target = null
		
	if can_throw and target:
		var spear_projectile: Spear = spear.instantiate()
		spear_projectile.direction = (target.global_position - global_position).normalized()
		spear_projectile.rotation = spear_projectile.direction.angle()
		add_child(spear_projectile)
		can_throw = false
		$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	can_throw = true
