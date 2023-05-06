extends Control

var selected
var menu_arange := []

var single
var multi
var config
var exit

var pos_1
var pos_2
var pos_3
var pos_4

# Called when the node enters the scene tree for the first time.
func _ready():
	single = $Node2D/Singleplayer
	multi = $Node2D/Multiplayer
	config = $Node2D/Config
	exit = $Node2D/Exit
	
	pos_1 = config.position
	pos_2 = single.position
	pos_3 = multi.position
	pos_4 = exit.position
	

	multi.scale = Vector2(0.75,0.75)
	config.scale = Vector2(0.75,0.75)
	exit.scale =Vector2(0.75,0.75)

	selected = 1
	menu_arange = [config,single,multi,exit]
	



func go_right():
	
	menu_arange[(selected+2)%len(menu_arange)].position = pos_3
	menu_arange[(selected-1)%len(menu_arange)].position = pos_4
	menu_arange[(selected)%len(menu_arange)].position = pos_1
	menu_arange[(selected+1)%len(menu_arange)].position = pos_2
	
	menu_arange[(selected)%len(menu_arange)].scale = Vector2(0.75,0.75)
	menu_arange[(selected+1)%len(menu_arange)].scale = Vector2(1.25,1.25)
	
	selected = (selected + 1) %(len(menu_arange))
	

func go_left():
	menu_arange[(selected+2)%len(menu_arange)].position = pos_1
	menu_arange[(selected-1)%len(menu_arange)].position = pos_2
	menu_arange[(selected)%len(menu_arange)].position = pos_3
	menu_arange[(selected+1)%len(menu_arange)].position = pos_4
	
	menu_arange[(selected)%len(menu_arange)].scale = Vector2(0.75,0.75)
	menu_arange[(selected-1)%len(menu_arange)].scale = Vector2(1.25,1.25)
	
	selected = (selected - 1 +4)%(len(menu_arange))
	

func select_option():
	match selected:
		0:
			return "main_config"
		1:
			return "main_single"
		2:
			return "main_multi"
		3:
			return "main_exit"
		_:
			return "main_exit"
