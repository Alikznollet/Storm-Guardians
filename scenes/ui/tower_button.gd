extends TextureButton

@export var tower: PackedScene
var towervisual: PackedScene = preload("res://scenes/towers/draggable_tower.tscn")

signal tower_selected(tower: DraggableTower)

func _on_pressed() -> void:
	var visual: DraggableTower = towervisual.instantiate()
	visual.set_texture(texture_normal)
	visual.tower = tower
	tower_selected.emit(visual)
	
	print(visual)
