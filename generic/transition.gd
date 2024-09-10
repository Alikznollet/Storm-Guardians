extends CanvasLayer

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func change_scene(target: String) -> void:
	$AnimationPlayer.play("curtain")
	await $AnimationPlayer.animation_finished
	var packed: PackedScene = load(target)
	get_tree().change_scene_to_packed(packed)
	$AnimationPlayer.play_backwards("curtain")
