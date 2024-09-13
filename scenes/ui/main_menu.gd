extends CanvasLayer

var settings: Settings = Settings.new()

func _on_quit_pressed() -> void:
	$Button.play()
	get_tree().quit()


func _on_options_pressed() -> void:
	$Button.play()
	$AnimationPlayer.play("toOptions")
	$Buttons/Options/Fullscreen.button_pressed = settings.fullscreen
	$Buttons/Options/HSlider.value = settings.volume


func _on_select_level_pressed() -> void:
	# NOTE: no need for saving/loading saves because it's a jam
	
	$Button.play()
	Transition.change_scene("res://scenes/levels/level.tscn")


func _on_return_pressed() -> void:
	$Button.play()
	$AnimationPlayer.play_backwards("toOptions")

	
func _on_fullscreen_toggled(toggled_on: bool) -> void:
	$Button.play()
	settings.save_fullscreen(toggled_on)

func _on_h_slider_value_changed(value: float) -> void:
	settings.save_volume(value)
