extends Enemy

func _ready() -> void:
	$AnimatedSprite2D.play("hover")

func _on_hitbox_component_died() -> void:
	$Death.play()
	$AnimatedSprite2D.play("die")
	dead = true
	await $AnimatedSprite2D.animation_finished
	queue_free()
