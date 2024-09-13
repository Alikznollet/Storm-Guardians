extends Node
class_name WaveManager

var waves: Array[WaveSettings]
var endless_wave: EndlessWave
var current_wave: WaveSettings

signal wave_over()

func _ready() -> void:
	for wave in get_children():
		if wave is not EndlessWave:
			waves.append(wave)
		else:
			endless_wave = wave
			
	_start_grace()
			
			
func start_wave() -> void:
	GameState.grace_period = false
	current_wave = waves.pop_front()
	var current_enemy: Enemy = current_wave.get_next_enemy()
	
	GameState.current_wave = current_wave.name
	
	while current_enemy:
		%Path.add_child(current_enemy)
		await get_tree().create_timer(current_wave.spawn_time).timeout
		current_enemy = current_wave.get_next_enemy()
		
	await %Path.wave_over
	wave_over.emit()
	
	if waves.is_empty():
		_start_endless()
	else:
		_start_grace()
	
func _start_grace() -> void:
	GameState.grace_period = true
	%GraceTimer.start()

func _on_grace_timer_timeout() -> void:
	if waves.is_empty():
		next_endless()
	else:
		start_wave()
	
		
func _end_game():
	print("you won")
	
func _start_endless():
	# TODO: make a popup appear here telling the player they won and asking
	# if they want to continue into endless mode
	current_wave = endless_wave
	next_endless()

func next_endless():
	GameState.grace_period = false
	current_wave = endless_wave.get_wave()
	var current_enemy: Enemy = current_wave.get_next_enemy()
	
	GameState.current_wave = current_wave.name
	
	while current_enemy:
		%Path.add_child(current_enemy)
		await get_tree().create_timer(current_wave.spawn_time).timeout
		current_enemy = current_wave.get_next_enemy()
		
	await %Path.wave_over
	endless_wave.upgrade()
	wave_over.emit()
	
	_start_grace()
