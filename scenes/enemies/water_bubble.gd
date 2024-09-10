extends Enemy

func _ready() -> void:
	$AnimatedSprite2D.play("hover")

func _on_hitbox_component_died() -> void:
	$AnimatedSprite2D.play("die")
	await $AnimatedSprite2D.animation_finished
	queue_free()
