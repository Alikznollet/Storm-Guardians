extends Sprite2D

func _ready() -> void:
	$Welcome.hide()
	$Money.hide()
	$Interest.hide()
	$Timer.hide()
	$Towers.hide()
	$Health.hide()
	$End.hide()
	
func show_hand():
	$YapperHand.show()
	
func hide_hand():
	$YapperHand.hide()

func hand_up():
	$YapperHand.rotation_degrees = -90
	
func hand_down():
	$YapperHand.rotation_degrees = 90
	
func hand_normal():
	$YapperHand.rotation_degrees = 0
	
func show_welcome():
	$Welcome.show()
	
func show_money():
	$Welcome.hide()
	$Money.show()
	
func show_interest():
	$Money.hide()
	$Interest.show()
	
func show_timer():
	$Interest.hide()
	$Timer.show()

func show_towers():
	$Timer.hide()
	$Towers.show()
	
func show_health():
	$Towers.hide()
	$Health.show()
	
func show_end():
	$Health.hide()
	$End.show()
