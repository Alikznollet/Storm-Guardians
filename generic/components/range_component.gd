extends Area2D
class_name RangeComponent

@export var controller: BaseTower
var targeting_method: String = "first"

func get_target() -> Enemy:
	if not get_overlapping_areas().is_empty():
		var target_areas: Array[Area2D] = get_overlapping_areas()
		var targets: Array[Enemy] = []
		for targetarea in target_areas:
			targets.append(targetarea.get_parent())
			
		if targeting_method == "first":
			targets.sort_custom(_sort_first)
		elif targeting_method == "last":
			targets.sort_custom(_sort_last)
		elif targeting_method == "strongest":
			targets.sort_custom(_sort_strongest)
		elif targeting_method == "closest":
			targets.sort_custom(_sort_closest)
		return targets.front()
	else:
		return null
		
func cycle_targeting_method() -> String:
	if targeting_method == "first":
		targeting_method = "last"
	elif targeting_method == "last":
		targeting_method = "strongest"
	elif targeting_method == "strongest":
		targeting_method = "closest"
	elif targeting_method == "closest":
		targeting_method = "first"
	
	return targeting_method
	
func _sort_closest(a: Enemy, b: Enemy):
	var dist_a: float = controller.global_position.distance_to(a.global_position)
	var dist_b: float = controller.global_position.distance_to(b.global_position)
	if dist_a < dist_b:
		return true
	return false
	
	
func _sort_strongest(a: Enemy, b: Enemy):
	if a.hitbox_component.health > b.hitbox_component.health:
		return true
	return false
		
func _sort_last(a: Enemy, b: Enemy):
	if a.progress < b.progress:
		return true
	return false

func _sort_first(a: Enemy, b: Enemy):
	if a.progress > b.progress:
		return true
	return false
