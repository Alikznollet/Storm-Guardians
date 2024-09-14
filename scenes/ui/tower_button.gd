extends TextureButton

@export var tower: PackedScene
@export var price: int
@export var tower_visual_radius: int
var towervisual: PackedScene = preload("res://scenes/towers/draggable_tower.tscn")

signal tower_selected(tower: DraggableTower)

func _ready() -> void:
	GameState.connect("grace_exited", disable)
	GameState.connect("grace_entered", enable)

func _on_pressed() -> void:
	if GameState.current_balance >= price:
		$AudioStreamPlayer2D.play()
		var visual: DraggableTower = towervisual.instantiate()
		visual.set_texture(texture_normal)
		visual.set_range(tower_visual_radius)
		visual.tower = tower
		tower_selected.emit(visual)
		GameState.new_tower_selected.emit(null)
	
func disable() -> void:
	disabled = true
	
func enable() -> void:
	disabled = false
