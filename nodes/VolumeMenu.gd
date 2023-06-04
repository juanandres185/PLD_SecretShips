extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

	
func go_right():
	if (int($Volume.text) < 100):
		$Volume.text = str(int($Volume.text)+1)
	
	
	

func go_left():
	if (int($Volume.text) > 0):
		$Volume.text = str(int($Volume.text)-1)
	
	

func select_option():
	return "change_volume"
