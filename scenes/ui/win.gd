extends CanvasLayer
class_name WinScreen

signal endless()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music._grace()
	get_tree().paused = true
	$Crown.global_position = Vector2(160, 90)
	$PauseMenu.modulate = Color("ffffff00")
	$Crown.play("crown")
	await $Crown.animation_finished
	var tween: Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Crown, "global_position", Vector2(160, 50), 1).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($PauseMenu, "modulate", Color("ffffff"), 1).set_trans(Tween.TRANS_CUBIC)
	tween.play() 


func _on_quit_game_pressed() -> void:
	$Button.play()
	Transition.change_scene("res://scenes/ui/main_menu.tscn")

func _on_endless_pressed() -> void:
	get_tree().paused = false
	$Button.play()
	endless.emit()
	queue_free()
