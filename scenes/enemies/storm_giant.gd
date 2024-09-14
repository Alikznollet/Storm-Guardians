extends Enemy

func _ready() -> void:
	$AnimatedSprite2D.play("walk")
	$"Money given".hide()

func _on_hitbox_component_died() -> void:
	$AnimatedSprite2D.play("death")
	$Death.play()
	dead = true
	
	$"Money given".text = "+" + str(money_given + GameState.current_interest)
	var tween: Tween = create_tween()
	tween.tween_property($"Money given", "position", Vector2(-20, -42), 0.5).set_trans(Tween.TRANS_CUBIC)
	$"Money given".show()
	tween.play()
	
	await $AnimatedSprite2D.animation_finished and tween.finished
	queue_free()
