extends Node
class_name WaveSettings

@export var enemies: Array[PackedScene]
@export var amounts: Array[int]
@export var enabled: bool = true

@export_group("MULTIPLIERS")
@export var health_multiplier: float = 1.00
@export var speed_multiplier: float = 1.00
@export var spawn_time: float = 0.5

func get_next_enemy() -> Enemy:
	if amounts.size() != 0:
		var enemypacked: PackedScene = enemies.front()
		var enemy: Enemy = enemypacked.instantiate()
		enemy.hitbox_component.health = enemy.hitbox_component.health * health_multiplier
		enemy.speed = enemy.speed * speed_multiplier
		
		amounts[0] -= 1
		
		if amounts[0] == 0:
			amounts.pop_front()
			enemies.pop_front()
			
		return enemy
	return null
