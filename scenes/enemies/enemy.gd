extends PathFollow2D
class_name Enemy

var dead: bool = false
@export var speed: int = 20
@export var damage_on_base: int = 5
@export var money_given: int = 1
@export var marker: Marker2D
@export var hitbox_component: HitboxComponent

func _notification(what):
	if (what == NOTIFICATION_PREDELETE):
		# adds the interest money to the balance
		GameState.money_gained += money_given + GameState.current_interest
		
func stun(duration: float):
	call_deferred("_MODE", PROCESS_MODE_WHEN_PAUSED)
	await get_tree().create_timer(duration).timeout
	call_deferred("_MODE", PROCESS_MODE_INHERIT)
	
func _MODE(mode: ProcessMode):
	process_mode = mode
