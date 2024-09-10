extends BaseTower

func _physics_process(_delta: float) -> void:
	target = $RangeComponent.get_target()
	
	if target:
		if target.global_position.x <= global_position.x:
			$Thrower.flip_h = true
		else:
			$Thrower.flip_h = false
		if can_throw:
			$Thrower.play("throw")
			can_throw = false
			var spear_projectile: Spear = projectile.instantiate()
			spear_projectile.direction = (target.global_position - global_position).normalized()
			spear_projectile.rotation = spear_projectile.direction.angle()
			add_child(spear_projectile)
			$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	$Thrower.play("grab")
	await $Thrower.animation_finished
	can_throw = true
