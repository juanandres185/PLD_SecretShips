extends Control

var selected
var menu_arange := []
var menu_arange_pos := []

var general
var sounds
var music
var back
var fullscreen


# Called when the node enters the scene tree for the first time.
func _ready():
	general = $Node2D/General
	sounds = $Node2D/Sounds
	music = $Node2D/Music
	fullscreen = $Node2D/FullScreen
	back = $Node2D/Return
	
	sounds.scale = Vector2(0.75,0.75)
	music.scale = Vector2(0.75,0.75)
	fullscreen.scale = Vector2(0.75,0.75)
	back.scale =Vector2(0.75,0.75)

	selected = 1
	menu_arange_pos = [back.position,general.position,sounds.position,music.position,fullscreen.position]
	menu_arange = [back,general,sounds,music,fullscreen]
	
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
	
	selected = (selected - 1 + mod) %mod
	

func select_option():
	match selected:
		0:
			return "return"
		1:
			return "options_general"
		2:
			return "options_sounds"
		3:
			return "options_music"
		4:
			return "options_fullscreen"
		_:
			return "return"
