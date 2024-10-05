extends Node2D
class_name BaseTower

func _ready() -> void:
	$UpgradeMenuMain.visible = false
	$RangeIndicator.hide()
	$Upgradevisuals.frame = 0
	
	$UpgradeMenuMain/Price1/Label.text = str(upgrade1_price)
	$UpgradeMenuMain/Price2/Label.text = str(upgrade2_price)
	$UpgradeMenuMain/Price3/Label.text = str(upgrade3_price)
	$UpgradeMenuMain/Price4/Label.text = str(upgrade4_price)
	
	GameState.connect("grace_exited", _disable_views)
	GameState.connect("new_tower_selected", _handle_selected_tower)
	
var mouse_inside_ui: bool

@export var projectile: PackedScene
var projectile_damage_modifier: float = 1.00
var can_throw: bool = true
var target: Enemy

var upgradetexture_unlockable: Texture2D = preload("res://assets/UI/upgradebutton.png")
var upgradetexture_unlocked: Texture2D = preload("res://assets/UI/upgradebutton_upgraded.png")

var totalcost: int # totalcost is with the cost of all upgrades added
var unlocked_1: bool = false
var unlocked_2: bool = false
var unlocked_3: bool = false
var unlocked_4: bool = false

func _handle_selected_tower(new_tower: BaseTower):
	if not new_tower == self:
		_disable_views()

func _on_sell_pressed() -> void:
	GameState.current_balance += totalcost * 0.6 # NOTE: 60% of money spent will be refunded
	queue_free()
	
func determine_show_spot() -> Vector2:
	var vector: Vector2 = Vector2()
	
	if $UpgradeMenuMain.global_position.x <= 260:
		vector.x = 0
	else:
		vector.x = -88
		
	if $UpgradeMenuMain.global_position.y <= 20:
		vector.y = 10
	elif $UpgradeMenuMain.global_position.y >= 120:
		vector.y = -30
	else:
		vector.y = 0
		
	return vector

func _on_tower_button_toggled(toggled_on: bool) -> void:
	if GameState.grace_period:
		if toggled_on:
			$UpgradeMenuMain.visible = toggled_on
			$RangeIndicator.visible = toggled_on
			var menu_position = determine_show_spot()
			$UpgradeMenuMain.position = menu_position
			GameState.new_tower_selected.emit(self)
		else:
			$UpgradeMenuMain.visible = toggled_on
			$RangeIndicator.visible = toggled_on
			$UpgradeMenuMain.position = Vector2.ZERO
			
			
func _disable_views() -> void:
	$UpgradeMenuMain.visible = false
	$RangeIndicator.visible = false
	$UpgradeMenuMain.position = Vector2.ZERO
	$TowerButton.button_pressed = false
		
@export_group("prices")
@export var price: int
@export var upgrade1_price: int = 100
@export var upgrade2_price: int = 100
@export var upgrade3_price: int = 100
@export var upgrade4_price: int = 100

func _process(delta: float) -> void:
	if upgrade1_price > GameState.current_balance:
		$UpgradeMenuMain/Price1/Label.modulate = Color.RED
	else:
		$UpgradeMenuMain/Price1/Label.modulate = Color.WHITE
	if upgrade2_price > GameState.current_balance:
		$UpgradeMenuMain/Price2/Label.modulate = Color.RED
	else:
		$UpgradeMenuMain/Price2/Label.modulate = Color.WHITE
	if upgrade3_price > GameState.current_balance:
		$UpgradeMenuMain/Price3/Label.modulate = Color.RED
	else:
		$UpgradeMenuMain/Price3/Label.modulate = Color.WHITE
	if upgrade4_price > GameState.current_balance:
		$UpgradeMenuMain/Price4/Label.modulate = Color.RED
	else:
		$UpgradeMenuMain/Price4/Label.modulate = Color.WHITE
	

func unlocku1() -> bool:
	var can_buy: bool = upgrade1_price <= GameState.current_balance
	
	if can_buy and !unlocked_1:
		$Upgradevisuals.frame = 1
		$AudioStreamPlayer2D.play()
		%Upgrade1.texture = upgradetexture_unlocked
		unlocked_1 = true
		
		totalcost += upgrade1_price
		GameState.current_balance -= upgrade1_price
		
		$UpgradeMenuMain/Price1.visible = false
		%Upgrade2.modulate.a = 255
		$UpgradeMenuMain/Price2.modulate.a = 255
		return true 
	return false

func unlocku2() -> bool:
	var can_buy: bool = upgrade2_price <= GameState.current_balance
	
	if unlocked_1 and can_buy and !unlocked_2:
		$Upgradevisuals.frame = 2
		$AudioStreamPlayer2D.play()
		%Upgrade2.texture = upgradetexture_unlocked
		unlocked_2 = true
		
		totalcost += upgrade2_price
		GameState.current_balance -= upgrade2_price
		
		$UpgradeMenuMain/Price2.visible = false
		%Upgrade3.modulate.a = 255
		$UpgradeMenuMain/Price3.modulate.a = 255
		return true
	return false 

func unlocku3() -> bool:
	var can_buy: bool = upgrade3_price <= GameState.current_balance
	
	if unlocked_1 and unlocked_2 and can_buy and !unlocked_3:
		$Upgradevisuals.frame = 3
		$AudioStreamPlayer2D.play()
		%Upgrade3.texture = upgradetexture_unlocked
		unlocked_3 = true
		
		totalcost += upgrade3_price
		GameState.current_balance -= upgrade3_price
		
		$UpgradeMenuMain/Price3.visible = false
		%Upgrade4.modulate.a = 255
		$UpgradeMenuMain/Price4.modulate.a = 255
		return true 
	return false

func unlocku4() -> bool:
	var can_buy: bool = upgrade4_price <= GameState.current_balance
	
	if unlocked_1 and unlocked_2 and unlocked_3 and can_buy and !unlocked_4:
		$Upgradevisuals.frame = 4
		$AudioStreamPlayer2D.play()
		%Upgrade4.texture = upgradetexture_unlocked
		unlocked_4 = true
		
		totalcost += upgrade4_price
		GameState.current_balance -= upgrade4_price
		
		$UpgradeMenuMain/Price4.visible = false
		return true 
	return false
	
@export var range_component: RangeComponent

func _on_targeting_pressed() -> void:
	var new_method: String = range_component.cycle_targeting_method()
	if new_method == "strongest":
		$UpgradeMenuMain/UpgradeMenu/Targeting/Label.scale = Vector2(0.6,0.6)
	elif new_method == "closest": 
		$UpgradeMenuMain/UpgradeMenu/Targeting/Label.scale = Vector2(0.8,0.8)
	else:
		$UpgradeMenuMain/UpgradeMenu/Targeting/Label.scale = Vector2.ONE
	$UpgradeMenuMain/UpgradeMenu/Targeting/Label.text = new_method


func _on_sell_mouse_entered() -> void:
	$UpgradeMenuMain/UpgradeMenu/Sell/Label.text = str(totalcost * 0.6)
	$UpgradeMenuMain/UpgradeMenu/Sell/Label.scale = Vector2(1.1,1.1)

func _on_sell_mouse_exited() -> void:
	$UpgradeMenuMain/UpgradeMenu/Sell/Label.text = "sell"
	$UpgradeMenuMain/UpgradeMenu/Sell/Label.scale = Vector2(1,1)
