extends Node
class_name PathFollowComponent

@export var controller: Enemy

func _process(delta: float) -> void:
	controller.progress += controller.speed * delta
	
	if controller.progress_ratio == 1:
		GameState.current_health -= controller.damage_on_base
		controller.queue_free()
