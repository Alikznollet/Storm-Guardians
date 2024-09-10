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
			var bomb_projectile: Bomb = projectile.instantiate()
			bomb_projectile.explo_position = target.global_position
			add_child(bomb_projectile)
			can_throw = false
			$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	$Thrower.play("grab")
	await $Thrower.animation_finished
	can_throw = true
