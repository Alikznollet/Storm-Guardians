extends Node

var grace_timer: Timer
var current_wave: String

signal game_over()
signal grace_entered()
signal grace_exited()

func game_started() -> void:
	current_balance = 1000 # starting value 1000
	current_interest = 10 # starting value 10
	current_wave = ""
	current_health = 50 # starting value 50
	money_gained = 0

var grace_period: bool:
	set(grace):
		grace_period = grace
		if grace:
			grace_entered.emit()
			current_balance += money_gained
			money_gained = 0
		else:
			grace_exited.emit()
			print(grace)
	get:
		return grace_period
			
		

var current_balance: int = 1000: # this value is temporary
	set(new):
		current_balance = new
		money_label.text = str(new)
		
		var interest = current_balance / 100
		if interest >= 10:
			current_interest = 10
		else:
			current_interest = interest
	get:
		return current_balance
		
var current_interest: int = 1: # this value is temporary
	set(new):
		current_interest = new
		interest_label.text = "+" + str(new)
	get:
		return current_interest
		
signal health_changed()
		
var current_health: int = 50: # this value is temporary
	set(new):
		health_changed.emit()
		if new > 0:
			current_health = new
			health_label.text = str(new)
		else:
			health_label.text = "0"
			var packedscene: PackedScene = load("res://scenes/ui/game_over.tscn")
			get_tree().current_scene.add_child(packedscene.instantiate())
	get:
		return current_health
		
var money_gained: int
		
var money_label: Label
var interest_label: Label
var health_label: Label

signal new_tower_selected(tower: BaseTower)
