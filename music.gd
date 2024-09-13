extends AudioStreamPlayer2D

func _ready() -> void:
	GameState.connect("grace_entered", _grace)
	GameState.connect("grace_exited", _storm)
	
	
func _grace():
	var tween: Tween = create_tween()
	tween.tween_property(self, "pitch_scale", 1, 1)
	tween.play()

func _storm():
	var tween: Tween = create_tween()
	tween.tween_property(self, "pitch_scale", 2, 1)
	tween.play()
