extends Enemy

func _ready() -> void:
	$"Money given".hide()
	$AnimatedSprite2D.play("default")
	var timer: SceneTreeTimer = get_tree().create_timer(1)
	await timer.timeout
	dead = true
	$AnimatedSprite2D.play("spawn")
	await $AnimatedSprite2D.animation_finished
	dead = false
	$AnimatedSprite2D.play("hover")

func _on_hitbox_component_died() -> void:
	$AnimatedSprite2D.play("death")
	$Death.play()
	dead = true
	
	$"Money given".text = "+" + str(money_given + GameState.current_interest)
	var tween: Tween = create_tween()
	tween.tween_property($"Money given", "position", Vector2(-20, -38), 0.5).set_trans(Tween.TRANS_CUBIC)
	$"Money given".show()
	tween.play()
	
	await $AnimatedSprite2D.animation_finished and tween.finished
	queue_free()
