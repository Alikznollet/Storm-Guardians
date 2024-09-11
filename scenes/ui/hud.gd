extends CanvasLayer

func _ready() -> void:
	_grace_show()
	GameState.money_label = $Balance/Money
	GameState.interest_label = $Balance/Interest
	GameState.health_label = $Health/HealthLabel
	_handle_spear(false)
	_handle_fire(false)
	_handle_bomb(false)
	_handle_mage(false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	%WaveLable.text = GameState.current_wave
	%TimerLable.text = "%.f" % GameState.grace_timer.get_time_left()
	
	if GameState.current_balance < int(%SpearPrice.text):
		%SpearPrice.modulate = Color.RED
	else:
		%SpearPrice.modulate = Color.WHITE
	if GameState.current_balance < int(%Bombprice.text):
		%Bombprice.modulate = Color.RED
	else:
		%Bombprice.modulate = Color.WHITE
	if GameState.current_balance < int(%FirePrice.text):
		%FirePrice.modulate = Color.RED
	else:
		%FirePrice.modulate = Color.WHITE
	if GameState.current_balance < int(%MagePrice.text):
		%MagePrice.modulate = Color.RED
	else:
		%MagePrice.modulate = Color.WHITE
	
func _on_grace_timer_timeout() -> void:
	_grace_hide()
	
func _grace_show() -> void:
	$AnimationPlayer.play("GraceOpen")
	
func _grace_hide() -> void:
	$AnimationPlayer.play("GraceClose")
	# close all price tags
	_handle_spear(false)
	_handle_fire(false)
	_handle_bomb(false)
	_handle_mage(false)
	$Timer/Timer/TimerButton.button_pressed = false

func _on_wave_manager_wave_over() -> void:
	_grace_show()

func _on_spear_mouse_entered() -> void:
	if GameState.grace_period:
		_handle_spear(true)
		
func _on_spear_mouse_exited() -> void:
	if GameState.grace_period:
		_handle_spear(false)
		
func _handle_spear(open: bool) -> void:
	if open:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceSpear, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceSpear, "position", Vector2(0, 16), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()

func _handle_bomb(open: bool) -> void:
	if open:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceBomb, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceBomb, "position", Vector2(0, 16), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()

func _handle_fire(open: bool) -> void:
	if open:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceFire, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceFire, "position", Vector2(0, 16), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()

func _handle_mage(open: bool) -> void:
	if open:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceMage, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceMage, "position", Vector2(0, 16), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()

func _on_bomb_mouse_entered() -> void:
	if GameState.grace_period:
		_handle_bomb(true)

func _on_bomb_mouse_exited() -> void:
	if GameState.grace_period:
		_handle_bomb(false)

func _on_fire_mouse_entered() -> void:
	if GameState.grace_period:
		_handle_fire(true)

func _on_fire_mouse_exited() -> void:
	if GameState.grace_period:
		_handle_fire(false)

func _on_electric_mouse_entered() -> void:
	if GameState.grace_period:
		_handle_mage(true)

func _on_electric_mouse_exited() -> void:
	if GameState.grace_period:
		_handle_mage(false)

func _on_timer_button_toggled(toggled_on: bool) -> void:
	var tween: Tween = get_tree().create_tween()
	if toggled_on:
		tween.tween_property($Timer/Confirm, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_CUBIC)
	else:
		tween.tween_property($Timer/Confirm, "position", Vector2(0, 16), 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	
func _on_skip_button_pressed() -> void:
	GameState.grace_timer.stop()
	GameState.grace_timer.timeout.emit()
