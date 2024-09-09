extends BaseTower

func _physics_process(_delta: float) -> void:
	target = $RangeComponent.get_target()
	
	if target and can_throw:
		var lightning_projectile: Lightning = projectile.instantiate()
		lightning_projectile.target_pos = target.global_position
		add_child(lightning_projectile)
		can_throw = false
		$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	can_throw = true
