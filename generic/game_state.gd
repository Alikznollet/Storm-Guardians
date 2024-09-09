extends Node

var grace_timer: Timer
var current_wave: String

signal grace_entered()
signal grace_exited()

var grace_period: bool:
	set(grace):
		grace_period = grace
		if grace:
			grace_entered.emit()
		else:
			grace_exited.emit()
	get:
		return grace_period
			
		

var current_balance: int = 1000:
	set(new):
		current_balance = new
		money_label.text = str(new)
	get:
		return current_balance
var current_interest: int = 1:
	set(new):
		current_interest = new
		interest_label.text = "+" + str(new)
	get:
		return current_interest

var money_label: Label
var interest_label: Label
