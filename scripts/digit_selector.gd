extends Node2D

var number_selector
var num = 0

@onready var text = $text


# Called when the node enters the scene tree for the first time.
func _ready():
	number_selector = get_node("..")
	num = number_selector.actual_num_digits
	number_selector.actual_num_digits+=1
	text.text = str(number_selector.numeroActual[num])
	

func _on_digit_up_pressed():
	text.text = str(number_selector.up(num))


func _on_digit_down_pressed():
	text.text = str(number_selector.down(num))


