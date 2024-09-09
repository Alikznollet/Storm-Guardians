extends BaseTower

func _physics_process(_delta: float) -> void:
	target = $RangeComponent.get_target()
	
	if target:
		$Weapon.look_at(target.global_position)
		if can_throw:
			var spear_projectile: Spear = projectile.instantiate()
			spear_projectile.direction = (target.global_position - global_position).normalized()
			spear_projectile.rotation = spear_projectile.direction.angle()
			add_child(spear_projectile)
			can_throw = false
			$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	can_throw = true
