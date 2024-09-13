extends BaseTower

var range: int = 30: 
	set(new):
		$RangeComponent/CollisionShape2D.shape.radius = new
		range = new
		$RangeIndicator.texture.width = range * 2
		$RangeIndicator.texture.height = range * 2
		
func _ready() -> void:
	super._ready()
	$RangeIndicator.texture.width = range * 2
	$RangeIndicator.texture.height = range * 2

func _physics_process(_delta: float) -> void:
	target = $RangeComponent.get_target()
	
	if target and can_throw:
		$FireTowerSprite.play("attack")
		var fire_projectile: Fire = projectile.instantiate()
		fire_projectile.impact_radius = $RangeComponent/CollisionShape2D.shape.radius
		add_child(fire_projectile)
		can_throw = false
		$ThrowTimer.start()

func _on_throw_timer_timeout() -> void:
	can_throw = true
	
func _on_button_1_pressed() -> void:
	if unlocku1():
		range = 40

# NOTE: these all have to do with attack speed (base is 1.2s wait time)
# every upgrade shaves off 0.2
func _on_button_2_pressed() -> void:
	if unlocku2():
		$ThrowTimer.wait_time = 1.3

func _on_button_3_pressed() -> void:
	if unlocku3():
		$ThrowTimer.wait_time = 1.1

func _on_button_4_pressed() -> void:
	if unlocku4():
		$ThrowTimer.wait_time = 0.9
