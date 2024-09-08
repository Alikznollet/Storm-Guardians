extends CanvasLayer

func _ready() -> void:
	_grace_show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	%WaveLable.text = GameState.current_wave
	%TimerLable.text = "%.2f" % GameState.grace_timer.get_time_left()


func _on_path_wave_over() -> void:
	_grace_show()
	
func _on_grace_timer_timeout() -> void:
	_grace_hide()
	
func _grace_show() -> void:
	$AnimationPlayer.play("GraceOpen")
	
func _grace_hide() -> void:
	$AnimationPlayer.play("GraceClose")
