extends BaseTower

var spread_modifier: float = 1.00

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
			bomb_projectile.explo_position = target.marker.global_position
			bomb_projectile.damage = bomb_projectile.damage * projectile_damage_modifier
			bomb_projectile.explo_radius_modifier = spread_modifier
			add_child(bomb_projectile)
			can_throw = false
			$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	$Thrower.play("grab")
	await $Thrower.animation_finished
	can_throw = true

func _on_button_1_pressed() -> void:
	if unlocku1():
		$RangeComponent/CollisionShape2D.shape.radius = 60 # base radius is 50

func _on_button_2_pressed() -> void:
	if unlocku2():
		projectile_damage_modifier = 1.5

func _on_button_3_pressed() -> void:
	if unlocku3():
		$ThrowTimer.wait_time = 2

func _on_button_4_pressed() -> void:
	if unlocku4():
		spread_modifier = 1.20
