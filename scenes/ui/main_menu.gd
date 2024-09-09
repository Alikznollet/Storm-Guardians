extends CanvasLayer

var settings: Settings = Settings.new()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	$AnimationPlayer.play("toOptions")
	$Buttons/Options/Fullscreen.button_pressed = settings.fullscreen
	$Buttons/Options/HSlider.value = settings.volume


func _on_select_level_pressed() -> void:
	# for now this will just load the first level
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")


func _on_return_pressed() -> void:
	$AnimationPlayer.play_backwards("toOptions")

	
func _on_fullscreen_toggled(toggled_on: bool) -> void:
	settings.save_fullscreen(toggled_on)

func _on_h_slider_value_changed(value: float) -> void:
	settings.save_volume(value)
