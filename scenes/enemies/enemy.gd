extends PathFollow2D
class_name Enemy

var dead: bool = false
@export var speed: int = 20
@export var damage_on_base: int = 5
@export var money_given: int = 1

func _notification(what):
	if (what == NOTIFICATION_PREDELETE):
		# adds the interest money to the balance
		GameState.money_gained += money_given + GameState.current_interest
