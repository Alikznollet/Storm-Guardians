extends Enemy

func _ready() -> void:
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
	await $AnimatedSprite2D.animation_finished
	queue_free()
