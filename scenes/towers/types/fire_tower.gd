extends BaseTower

func _physics_process(delta: float) -> void:
	var target: Enemy = $RangeComponent.get_target()
	
	if target and can_throw:
		var fire_projectile: Fire = projectile.instantiate()
		add_child(fire_projectile)
		can_throw = false
		$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	can_throw = true
