extends BaseTower

var extra_pierce: int = 0

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
			spear_projectile.direction = (target.marker.global_position - global_position).normalized()
			spear_projectile.rotation = spear_projectile.direction.angle()
			spear_projectile.damage = spear_projectile.damage * projectile_damage_modifier
			spear_projectile.pierce += extra_pierce
			add_child(spear_projectile)
			$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	$Thrower.play("grab")
	await $Thrower.animation_finished
	can_throw = true

func _on_button_1_pressed() -> void:
	if unlocku1():
		$RangeComponent/CollisionShape2D.shape.radius = 90

func _on_button_2_pressed() -> void:
	if unlocku2():
		projectile_damage_modifier = 1.5

func _on_button_3_pressed() -> void:
	if unlocku3():
		$ThrowTimer.wait_time = 0.5

func _on_button_4_pressed() -> void:
	if unlocku4():
		extra_pierce = 5
