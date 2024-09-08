extends Path2D

signal wave_over()

func _on_child_entered_tree(node: Node) -> void:
	node.connect("tree_exited", _check_wave_status)

func _check_wave_status() -> void:
	if get_children().is_empty():
		wave_over.emit()
