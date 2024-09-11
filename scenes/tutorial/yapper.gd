extends Sprite2D


func hand_up():
	$YapperHand.rotation_degrees = -90
	
func hand_down():
	$YapperHand.rotation_degrees = 90
	
func hand_normal():
	$YapperHand.rotation_degrees = 0
