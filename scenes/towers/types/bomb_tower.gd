extends BaseTower

func _physics_process(delta: float) -> void:
	target = $RangeComponent.get_target()
	
	if target:
		$Weapon.look_at(target.global_position)
		if can_throw:
			var bomb_projectile: Bomb = projectile.instantiate()
			bomb_projectile.explo_position = target.global_position
			add_child(bomb_projectile)
			can_throw = false
			$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	can_throw = true
