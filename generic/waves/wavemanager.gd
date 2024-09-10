extends Node
class_name WaveManager

var waves: Array[WaveSettings]
var current_wave: WaveSettings

signal wave_over()

func _ready() -> void:
	for wave in get_children():
		if wave is WaveSettings:
			waves.append(wave)
			
	_start_grace()
			
			
func start_wave() -> void:
	GameState.grace_period = false
	current_wave = waves.pop_front()
	var current_enemy: Enemy = current_wave.get_next_enemy()
	
	GameState.current_wave = current_wave.name
	# GameState.wave_starting.emit()
	
	while current_enemy:
		%Path.add_child(current_enemy)
		await get_tree().create_timer(current_wave.spawn_time).timeout
		current_enemy = current_wave.get_next_enemy()
		
	await %Path.wave_over
	print("wave over")
	wave_over.emit()
	
	if waves.is_empty():
		_end_game()
	else:
		_start_grace()
	
func _start_grace() -> void:
	GameState.grace_period = true
	%GraceTimer.start()

func _on_grace_timer_timeout() -> void:
	start_wave()
		
func _end_game():
	print("you won")
		
		
