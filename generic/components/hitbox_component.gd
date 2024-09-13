extends Area2D
class_name HitboxComponent

@export var hit_audio: AudioStreamPlayer2D
@export var health_label: Label # optional when you want to display health

@export var health: int:
	set(new):
		health = new
		if health <= 0:
			died.emit()
		
		if health_label:
			health_label.text = str(new)

signal died()

func _on_area_entered(area: Area2D) -> void:
	if area is Projectile:
		health -= area.damage
		if hit_audio:
			hit_audio.play()
