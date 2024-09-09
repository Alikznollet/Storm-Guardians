extends TextureButton

@export var tower: PackedScene
var towervisual: PackedScene = preload("res://scenes/towers/draggable_tower.tscn")

signal tower_selected(tower: DraggableTower)

func _ready() -> void:
	GameState.connect("grace_exited", disable)
	GameState.connect("grace_entered", enable)

func _on_pressed() -> void:
	var visual: DraggableTower = towervisual.instantiate()
	visual.set_texture(texture_normal)
	visual.tower = tower
	tower_selected.emit(visual)
	
func disable() -> void:
	disabled = true
	
func enable() -> void:
	disabled = false
