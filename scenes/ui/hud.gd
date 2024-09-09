extends CanvasLayer

func _ready() -> void:
	_grace_show()
	GameState.money_label = $Balance/Money
	GameState.interest_label = $Balance/Interest
	GameState.health_label = $Health/HealthLabel
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	%WaveLable.text = GameState.current_wave
	%TimerLable.text = "%.2f" % GameState.grace_timer.get_time_left()
	
func _on_grace_timer_timeout() -> void:
	_grace_hide()
	
func _grace_show() -> void:
	$AnimationPlayer.play("GraceOpen")
	
func _grace_hide() -> void:
	$AnimationPlayer.play("GraceClose")

func _on_wave_manager_wave_over() -> void:
	_grace_show()
