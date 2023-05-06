extends Node2D

var player
var num = 0

@onready var text = $text


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("..")
	num = player.num_canons
	player.num_canons+=1
	text.text = str(player.numeroActual[num])
	

func _on_digit_up_pressed():
	text.text = str(player.up(num))


func _on_digit_down_pressed():
	text.text = str(player.down(num))
