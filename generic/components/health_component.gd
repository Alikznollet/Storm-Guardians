extends Node
class_name HealthComponent

@export var health: int:
	set(new):
		health = new
		if new <= 0:
			died.emit()

signal died()
