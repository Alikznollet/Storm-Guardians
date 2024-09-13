extends Enemy

func _ready() -> void:
	$AnimatedSprite2D.play("walk")

func _on_hitbox_component_died() -> void:
	$AnimatedSprite2D.play("death")
	$Death.play()
	dead = true
	await $AnimatedSprite2D.animation_finished
	queue_free()
