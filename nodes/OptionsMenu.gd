extends Control

var selected
var menu_arange := []

var general
var sounds
var music
var back

var pos_1
var pos_2
var pos_3
var pos_4

# Called when the node enters the scene tree for the first time.
func _ready():
	general = $Node2D/General
	sounds = $Node2D/Sounds
	music = $Node2D/Music
	back = $Node2D/Return
	
	pos_1 = general.position
	pos_2 = sounds.position
	pos_3 = music.position
	pos_4 = back.position
	

	sounds.scale = Vector2(0.75,0.75)
	music.scale = Vector2(0.75,0.75)
	back.scale =Vector2(0.75,0.75)

	selected = 1
	menu_arange = [back,general,sounds,music]
	



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
			return "return"
		1:
			return "options_general"
		2:
			return "options_sounds"
		3:
			return "options_music"
		_:
			return "return"
