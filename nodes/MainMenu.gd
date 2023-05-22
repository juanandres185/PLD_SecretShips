extends Control

var selected
var menu_arange_pos := []
var menu_arange := []

var single
var multi
var config
var exit


# Called when the node enters the scene tree for the first time.
func _ready():
	single = $Node2D/Singleplayer
	multi = $Node2D/Multiplayer
	config = $Node2D/Config
	exit = $Node2D/Exit
	
	multi.scale = Vector2(0.75,0.75)
	config.scale = Vector2(0.75,0.75)
	exit.scale =Vector2(0.75,0.75)

	selected = 1
	menu_arange_pos = [config.position,single.position,multi.position,exit.position]
	menu_arange = [config,single,multi,exit]
	



func go_right():
	
	var mod = len(menu_arange)
	var outofbounds = menu_arange_pos[0]-Vector2(1000,0)
	
	var tween1 = create_tween()
	tween1.tween_property(menu_arange[(selected+2)%mod],"position",menu_arange_pos[2],0.3)
	var tween2 = create_tween()
	tween2.tween_property(menu_arange[(selected+1)%mod],"position",menu_arange_pos[1],0.3)
	var tween3 = create_tween()
	tween3.tween_property(menu_arange[(selected)%mod],"position",menu_arange_pos[0],0.3)
	var tween4 = create_tween()
	tween4.tween_property(menu_arange[(selected-1)%mod],"position",outofbounds,0.3)
	tween4.tween_property(menu_arange[(selected-1)%mod],"position",menu_arange_pos[3],0)
	
	
	var tween5 = create_tween()
	tween5.tween_property(menu_arange[selected%mod],"scale",Vector2(0.75,0.75),0.3)
	var tween6 = create_tween()
	tween6.tween_property(menu_arange[(selected+1)%mod],"scale",Vector2(1.71,1.71),0.3)
	
	selected = (selected + 1) %(len(menu_arange))
	
	

func go_left():
	
	var mod = len(menu_arange)
	var outofbounds = menu_arange_pos[0]-Vector2(1000,0)
	var tween1 = create_tween()
	tween1.tween_property(menu_arange[(selected-1)%mod],"position",menu_arange_pos[1],0.3)
	var tween2 = create_tween()
	tween2.tween_property(menu_arange[(selected)%mod],"position",menu_arange_pos[2],0.3)
	var tween3 = create_tween()
	tween3.tween_property(menu_arange[(selected+1)%mod],"position",menu_arange_pos[3],0.3)
	var tween4 = create_tween()
	tween4.tween_property(menu_arange[(selected-2)%mod],"position",outofbounds,0)
	tween4.tween_property(menu_arange[(selected-2)%mod],"position",menu_arange_pos[0],0.3)
	
	
	
	var tween5 = create_tween()
	tween5.tween_property(menu_arange[selected%mod],"scale",Vector2(0.75,0.75),0.3)
	var tween6 = create_tween()
	tween6.tween_property(menu_arange[(selected-1)%mod],"scale",Vector2(1.71,1.71),0.3)
	
	selected = (selected - 1 + 4) %(len(menu_arange))
	

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
