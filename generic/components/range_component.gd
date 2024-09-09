extends Area2D
class_name RangeComponent

func get_target() -> Enemy:
	if not get_overlapping_areas().is_empty():
		var target_areas: Array[Area2D] = get_overlapping_areas()
		var targets: Array[Enemy] = []
		for targetarea in target_areas:
			targets.append(targetarea.get_parent())
			
		targets.sort_custom(_sort_first)
		return targets.front()
	else:
		return null
		
func set_targeting_method() -> void:
	pass
		
func _sort_furthest(a: Enemy, b: Enemy):
	var distance_a: float = global_position.distance_to(a.global_position)
	var distance_b: float = global_position.distance_to(b.global_position)
	
	if distance_a > distance_b:
		return true
	return false
		
func _sort_closest(a: Enemy, b: Enemy):
	var distance_a: float = global_position.distance_to(a.global_position)
	var distance_b: float = global_position.distance_to(b.global_position)
	
	if distance_a < distance_b:
		return true
	return false

func _sort_first(a: Enemy, b: Enemy):
	if a.progress > b.progress:
		return true
	return false
