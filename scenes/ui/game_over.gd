extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true
	Music._grace()
	$PauseMenu.modulate = Color("ffffff00")
	$Yapper.global_position = Vector2(-11, 91)
	$Yapper.hide_hand()
	var tween: Tween = create_tween()
	tween.tween_property($PauseMenu, "modulate", Color("ffffff"), 1).from(Color("ffffff00")).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	tween.tween_property($Yapper, "global_position", Vector2(5, 91), 1.5)
	tween.play()
	tween.tween_property($Yapper, "global_position", Vector2(119, 91), 1).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	await tween.finished
	$Yapper.show_hand()


func _on_retry_pressed() -> void:
	$Button.play()
	Transition.change_scene("res://scenes/levels/level.tscn")

func _on_quit_game_pressed() -> void:
	$Button.play()
	Transition.change_scene("res://scenes/ui/main_menu.tscn")
