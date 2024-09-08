extends Node
class_name WaveManager

var waves: Array[WaveSettings]
var current_wave: WaveSettings

func _ready() -> void:
	for wave in get_children():
		if wave is WaveSettings:
			waves.append(wave)
			
	start_wave()
			
			
func start_wave() -> void:
	current_wave = waves.pop_front()
	var current_enemy: Enemy = current_wave.get_next_enemy()
	
	while current_enemy:
		%Path.add_child(current_enemy)
		await get_tree().create_timer(1).timeout
		current_enemy = current_wave.get_next_enemy()
		
	await %Path.wave_over
	_start_grace()
	
func _start_grace() -> void:
	print('grace')
	%GraceTimer.start()

func _on_grace_timer_timeout() -> void:
	if not waves.is_empty():
		print(waves)
		start_wave()
