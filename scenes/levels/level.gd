extends Node2D

func _ready() -> void:
	GameState.grace_timer = %GraceTimer
	GameState.game_started()
	
	for buybutton in get_tree().get_nodes_in_group("BuyButtons"):
		buybutton.connect("tower_selected", _tower_to_cursor)
	
	
func _tower_to_cursor(tower: DraggableTower):
	if not $TowerVisuals.get_children().is_empty():
		$TowerVisuals.get_children().front().stop_showing_visual()
		
	$TowerVisuals.add_child(tower)
