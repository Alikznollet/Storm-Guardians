extends Area2D
class_name TowerSpot

var available: bool = true
var mouse_inside: bool = false

var body_inside: DraggableTower

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click") and available and mouse_inside:
		_place_tower()
		mouse_inside = false

func _on_mouse_entered() -> void:
	if body_inside and available:
		body_inside.snap(self)
		mouse_inside = true
		
		
func _on_mouse_exited() -> void:
	if body_inside and available:
		body_inside.unsnap()
		mouse_inside = false

func _on_area_entered(area: Area2D) -> void:
	body_inside = area

func _on_area_exited(_area: Area2D) -> void:
	body_inside = null
	
func _place_tower():
	if body_inside:
		$Build.play()
		var tower: BaseTower = body_inside.tower.instantiate()
		add_child(tower)
		GameState.current_balance -= tower.price
		available = false
		$Sprite2D.visible = false
		body_inside.stop_showing_visual()
		tower.totalcost = tower.price

func _on_child_exiting_tree(node: Node) -> void:
	if node is BaseTower:
		available = true
		$Sell.play()
		$Sprite2D.visible = true
