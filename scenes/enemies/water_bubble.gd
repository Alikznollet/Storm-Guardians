extends Enemy

func _ready() -> void:
	$AnimatedSprite2D.play("hover")
	$"Money given".hide()

func _on_hitbox_component_died() -> void:
	$HitboxComponent/CollisionShape2D.set_deferred("disabled", true)
	$Label.hide()
	$Death.play()
	$AnimatedSprite2D.play("die")
	dead = true
	
	$"Money given".text = "+" + str(money_given + GameState.current_interest)
	var tween: Tween = create_tween()
	tween.tween_property($"Money given", "position", Vector2(-20, -36), 0.5).set_trans(Tween.TRANS_CUBIC)
	$"Money given".show()
	tween.play()
	await tween.finished and $AnimatedSprite2D.animation_finished
	queue_free()
