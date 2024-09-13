extends Area2D
class_name DraggableTower

var snapped: bool = false
var tower: PackedScene

func _ready() -> void:
	GameState.connect("grace_exited", stop_showing_visual)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not snapped:
		global_position.x = get_global_mouse_position().x - 14
		global_position.y = get_global_mouse_position().y - 16
		
	if Input.is_action_just_pressed("right_click"):
		stop_showing_visual()
	
func stop_showing_visual() -> void:
	queue_free()
	
func snap(tower_spot: TowerSpot) -> void:
	global_position.x = tower_spot.global_position.x - 14
	global_position.y = tower_spot.global_position.y - 15
	snapped = true

func unsnap() -> void:
	snapped = false
	
func set_texture(texture: Texture2D) -> void:
	$DraggableTower.texture = texture
	
func set_range(range: int) -> void:
	if range != 0:
		$Sprite2D.texture.width = range * 2
		$Sprite2D.texture.height = range * 2
	else:
		$Sprite2D.hide()
