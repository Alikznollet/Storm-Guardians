extends WaveSettings
class_name EndlessWave

@export_group("Endless Multipliers")
@export var amount_multiplier: float = 1.00
@export var repeat: int = 0

var wave_index: int = 21

func get_wave() -> WaveSettings:
	var wave_settings: WaveSettings = WaveSettings.new()
	wave_settings.enemies = []
	wave_settings.amounts = []
	wave_settings.name = "Wave " + str(wave_index)
	
	for enemy in enemies:
		wave_settings.enemies.append(enemy)
	
	for amount in amounts:
		wave_settings.amounts.append(int(amount * amount_multiplier))
		
	for i in range(repeat):
		for enemy in enemies:
			wave_settings.enemies.append(enemy)
		for amount in amounts:
			wave_settings.amounts.append(int(amount * amount_multiplier))
			
	wave_settings.spawn_time = spawn_time
	wave_settings.health_multiplier = health_multiplier
	wave_settings.speed_multiplier = speed_multiplier
	
	wave_index += 1
	return wave_settings
	
@export_group("UPGRADE VALUES")
@export var health_increase: float
@export var speed_increase: float
@export var amount_increase: float
@export var repeat_cycle_amount: int
	
func upgrade() -> void:
	health_multiplier += health_increase
	speed_multiplier += speed_increase
	amount_multiplier += amount_increase
	
	if wave_index % repeat_cycle_amount == 0:
		repeat += 1
