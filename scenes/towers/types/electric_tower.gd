extends BaseTower

func _physics_process(_delta: float) -> void:
	target = $RangeComponent.get_target()
	
	if target and can_throw:
		$ElectricSprite.play("attack")
		var lightning_projectile: Lightning = projectile.instantiate()
		lightning_projectile.target = target
		lightning_projectile.damage = lightning_projectile.damage * projectile_damage_modifier
		add_child(lightning_projectile)
		can_throw = false
		$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	can_throw = true
	
func _on_button_1_pressed() -> void:
	if unlocku1():
		projectile_damage_modifier = 1.2

func _on_button_2_pressed() -> void:
	if unlocku2():
		projectile_damage_modifier = 1.5

func _on_button_3_pressed() -> void:
	if unlocku3():
		projectile_damage_modifier = 2

func _on_button_4_pressed() -> void:
	if unlocku4():
		$ThrowTimer.wait_time = 2
