extends Node2D

var player
var num = 0

@onready var Digit = $Digit


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("..")
	num = player.num_canons
	player.num_canons+=1
	Digit.text = str(player.numeroActual[num])
	

func _on_digit_up_pressed():
	Digit.text = str(player.up())


func _on_digit_down_pressed():
	Digit.text = str(player.down())
