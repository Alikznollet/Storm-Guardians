extends Node2D
class_name BaseTower
		
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
