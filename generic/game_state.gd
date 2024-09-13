extends Node

var grace_timer: Timer
var current_wave: String

signal grace_entered()
signal grace_exited()

func game_started() -> void:
	# NOTE: temporary values, these should be loaded from a config file later
	current_balance = 1000
	current_interest = 10
	current_health = 50

var grace_period: bool:
	set(grace):
		grace_period = grace
		if grace:
			grace_entered.emit()
			current_balance += money_gained
			money_gained = 0
		else:
			grace_exited.emit()
	get:
		return grace_period
			
		

var current_balance: int = 1000: # this value is temporary
	set(new):
		current_balance = new
		money_label.text = str(new)
		
		var interest = current_balance / 100
		if interest >= 15:
			current_interest = 15
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
		
var current_health: int = 50: # this value is temporary
	set(new):
		if new > 0:
			current_health = new
			health_label.text = str(new)
		else:
			# TODO: handle game ending logic here
			# for now just closes the game
			get_tree().quit()
	get:
		return current_health
		
var money_gained: int
		
var money_label: Label
var interest_label: Label
var health_label: Label

var currently_opened_tower: BaseTower
