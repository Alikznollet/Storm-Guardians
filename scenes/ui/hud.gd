extends CanvasLayer

func _ready() -> void:
	_grace_show()
	GameState.money_label = $Balance/Money
	GameState.interest_label = $Balance/Interest
	GameState.health_label = $Health/HealthLabel
	GameState.health_changed.connect(_on_base_damaged)
	_handle_spear(false)
	_handle_fire(false)
	_handle_bomb(false)
	_handle_mage(false)
	$PauseMenu.visible = false
	$SpeedUp.hide()
	
	await get_tree().create_timer(0.3).timeout
	$Rain.emitting = false
	tutorial()
	
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
	
	# check here wether player wants the game paused or not
	if Input.is_action_just_pressed("escape") and !get_tree().paused and GameState.current_health > 0:
		get_tree().paused = true
		$PauseMenu.show()
	elif Input.is_action_just_pressed("escape") and get_tree().paused and GameState.current_health > 0:
		$PauseMenu.hide()
		get_tree().paused = false
		
	if Input.is_action_just_pressed("left_click") and tutorial_ongoing and !get_tree().paused:
		next.emit()
		$ButtonSound.play()
		
	if Input.is_action_pressed("space") and !tutorial_ongoing and not GameState.grace_period and not get_tree().paused:
		$SpeedUp.show()
		$SpeedUpAnim.play("flicker")
		Engine.time_scale = 2
	else:
		$SpeedUpAnim.stop()
		$SpeedUp.hide()
		Engine.time_scale = 1
		
	if OS.is_debug_build() and Input.is_action_just_pressed("e"):
		GameState.current_balance += 1000
		
		
		
func _on_thunder_timer_timeout() -> void:
	var tween: Tween = create_tween()
	$Thunder.modulate = Color("ffffff35")
	tween.tween_property($Thunder, "modulate", Color("ffffff00"), 0.5).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	var rd: int = randi_range(4,15)
	$ThunderTimer.start(rd)
	$Thunder/Thundeer.play()
	
func _on_base_damaged() -> void:
	if GameState.current_wave != "":
		var tween: Tween = create_tween()
		$Hurt.modulate = Color("ffffff35")
		tween.tween_property($Hurt, "modulate", Color("ffffff00"), 0.5).set_trans(Tween.TRANS_CUBIC)
		tween.play()
	
func _on_grace_timer_timeout() -> void:
	_grace_hide()
	
func _grace_show() -> void:
	$ThunderTimer.stop()
	$Rain.emitting = false
	$DirectionalLight2D/AnimationPlayer.play_backwards("easein")
	$DirectionalLight2D/RainSound.stop()
	$DirectionalLight2D/Wind.stop()
	
	$Timer/Confirm/SkipButton.disabled = false
	$Timer/Timer/TimerButton.disabled = false


	$AnimationPlayer.play("GraceOpen")
	
func _grace_hide() -> void:
	$AnimationPlayer.play("GraceClose")
	# close all price tags
	_handle_spear(false)
	_handle_fire(false)
	_handle_bomb(false)
	_handle_mage(false)
	
	$Timer/Timer/TimerButton.button_pressed = false
	$Rain.emitting = true
	var rd: int = randi_range(4,15)
	$ThunderTimer.start(rd)
	$DirectionalLight2D/AnimationPlayer.play("easein")
	$DirectionalLight2D/RainSound.play()
	$DirectionalLight2D/Wind.play()
	
	$Timer/Timer/TimerButton.disabled = true
	$Timer/Confirm/SkipButton.disabled = true
	$Timer/Confirm/SkipButton.release_focus()

func _on_wave_manager_wave_over() -> void:
	_grace_show()

func _on_spear_mouse_entered() -> void:
	if GameState.grace_period:
		_handle_spear(true)
		
func _on_spear_mouse_exited() -> void:
	if GameState.grace_period:
		_handle_spear(false)
		
var info_opened: bool = false
		
func _handle_spear(open: bool) -> void:
	if open:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceSpear, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
		$BuyInfo/Label.text = $"Buy/BuyButtons/Spear".name
		$BuyInfo/TextureRect.texture = $"Buy/BuyButtons/Spear".texture_normal
		$BuyInfo/Label2.text = $"Buy/BuyButtons/Spear".tower_description
		$BuyInfo/BuyInfo2.play("open_info", 0.3)
		info_opened = true
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceSpear, "position", Vector2(0, 16), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
		if info_opened:
			$BuyInfo/BuyInfo2.play("close_info", 0.3)
			info_opened = false

func _handle_bomb(open: bool) -> void:
	if open:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceBomb, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
		$BuyInfo/Label.text = $Buy/BuyButtons/Bomber.name
		$BuyInfo/TextureRect.texture = $Buy/BuyButtons/Bomber.texture_normal
		$BuyInfo/Label2.text = $Buy/BuyButtons/Bomber.tower_description
		$BuyInfo/BuyInfo2.play("open_info", 0.3)
		info_opened = true
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceBomb, "position", Vector2(0, 16), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
		if info_opened:
			$BuyInfo/BuyInfo2.play("close_info", 0.3)
			info_opened = false

func _handle_fire(open: bool) -> void:
	if open:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceFire, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
		$BuyInfo/Label.text = $Buy/BuyButtons/Furnace.name
		$BuyInfo/TextureRect.texture = $Buy/BuyButtons/Furnace.texture_normal
		$BuyInfo/Label2.text = $Buy/BuyButtons/Furnace.tower_description
		$BuyInfo/BuyInfo2.play("open_info", 0.3)
		info_opened = true
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceFire, "position", Vector2(0, 16), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
		if info_opened:
			$BuyInfo/BuyInfo2.play("close_info", 0.3)
			info_opened = false

func _handle_mage(open: bool) -> void:
	if open:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceMage, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
		$BuyInfo/Label.text = $Buy/BuyButtons/Tesla.name
		$BuyInfo/TextureRect.texture = $Buy/BuyButtons/Tesla.texture_normal
		$BuyInfo/Label2.text = $Buy/BuyButtons/Tesla.tower_description
		$BuyInfo/BuyInfo2.play("open_info", 0.3)
		info_opened = true
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property($Buy/Prices/PriceMage, "position", Vector2(0, 16), 0.3).set_trans(Tween.TRANS_CUBIC)
		tween.play()
		if info_opened:
			$BuyInfo/BuyInfo2.play("close_info", 0.3)
			info_opened = false

func _on_bomb_mouse_entered() -> void:
	if GameState.grace_period and not tutorial_ongoing:
		_handle_bomb(true)

func _on_bomb_mouse_exited() -> void:
	if GameState.grace_period and not tutorial_ongoing:
		_handle_bomb(false)

func _on_fire_mouse_entered() -> void:
	if GameState.grace_period and not tutorial_ongoing:
		_handle_fire(true)

func _on_fire_mouse_exited() -> void:
	if GameState.grace_period and not tutorial_ongoing:
		_handle_fire(false)

func _on_electric_mouse_entered() -> void:
	if GameState.grace_period and not tutorial_ongoing:
		_handle_mage(true)

func _on_electric_mouse_exited() -> void:
	if GameState.grace_period and not tutorial_ongoing:
		_handle_mage(false)

func _on_timer_button_toggled(toggled_on: bool) -> void:
	$ButtonSound.play()
	var tween: Tween = get_tree().create_tween()
	if toggled_on:
		tween.tween_property($Timer/Confirm, "position", Vector2(0, 0), 0.3).set_trans(Tween.TRANS_CUBIC)
	else:
		tween.tween_property($Timer/Confirm, "position", Vector2(0, 16), 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	
func _on_skip_button_pressed() -> void:
	$ButtonSound.play()
	GameState.grace_timer.stop()
	GameState.grace_timer.timeout.emit()

func _on_resume_pressed() -> void:
	$ButtonSound.play()
	$PauseMenu.visible = false
	get_tree().paused = false

func _on_quit_game_pressed() -> void:
	$ButtonSound.play()
	Music._grace()
	get_tree().paused = false
	Transition.change_scene("res://scenes/ui/main_menu.tscn")
	
var tutorial_ongoing: bool = false
signal next()
signal tutorial_over()

func tutorial():
	$"Buy/BuyButtons/Spear".disabled = true
	$Buy/BuyButtons/Bomber.disabled = true
	$Buy/BuyButtons/Furnace.disabled = true
	$Buy/BuyButtons/Tesla.disabled = true
	$Timer/Confirm/SkipButton.disabled = true
	$Timer/Timer/TimerButton.disabled = true
	
	tutorial_ongoing = true
	$"Yapper Animation".play("welcome")
	await next
	$"Yapper Animation".play("money")
	await next
	$"Yapper Animation".play("interest")
	await next
	$"Yapper Animation".play("timer")
	await next
	$"Yapper Animation".play("towers")
	await next
	$"Yapper Animation".play("upgrade")
	await next
	$"Yapper Animation".play("health")
	await next
	$"Yapper Animation".play("end")
	await next
	$"Yapper Animation".play("RESET")
	tutorial_ongoing = false
	
	$"Buy/BuyButtons/Spear".disabled = false
	$Buy/BuyButtons/Bomber.disabled = false
	$Buy/BuyButtons/Furnace.disabled = false
	$Buy/BuyButtons/Tesla.disabled = false
	$Timer/Confirm/SkipButton.disabled = false
	$Timer/Timer/TimerButton.disabled = false
	tutorial_over.emit()
	
func speedup_gone() -> void:
	$SpeedUpAnim.play("flicker")
	
func speedup_back() -> void:
	$SpeedUpAnim.play("flickerback")
