extends Node

var p1_number = [0, 0, 0, 0]
var p2_number = [0, 0, 0, 0]

var num_digits = 4
var mod = 10

var win_system = 3

var score = 0

var config_path = "res://config.cfg"
var config = ConfigFile.new()
var volume_general
var volume_music
var volume_sounds
var fullscreen
var resolution


func get_volume_dB(volume_type):
	print(volume_music)
	print(volume_sounds)
	print(volume_general)
	
	var vol
	
	if volume_type == 0:
		vol = volume_music
	if volume_type == 1:
		vol = volume_sounds
	
	vol *= volume_general/100.0
	vol -= 100
	vol += 24	
	
	print(vol)
	
	return vol

func change_volume(volume,volume_type):
	match volume_type:
		0:
			volume_general = volume
			config.set_value("volume","general",volume_general)
		1:
			volume_sounds = volume
			config.set_value("volume","sounds",volume_sounds)
		2:
			volume_music = volume
			config.set_value("volume","music",volume_music)
	config.save(config_path)

func toggle_fullscreen():
	fullscreen = not(fullscreen)
	config.set_value("graphics","fullscreen",fullscreen)
	config.save(config_path)
	if(fullscreen):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _ready():
	
	if (FileAccess.file_exists(config_path)):
		config.load(config_path)
		volume_general = config.get_value("volume","general")
		volume_sounds = config.get_value("volume","sounds")
		volume_music = config.get_value("volume","music")
		fullscreen = config.get_value("graphics","fullscreen")
		resolution = config.get_value("graphics","resolution")
		
		if(fullscreen):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	else:
		config.set_value("volume","general",100)
		volume_general = 100
		config.set_value("volume","sounds",100)
		volume_sounds = 100
		config.set_value("volume","music",100)
		volume_music = 100
		config.set_value("graphics","fullscreen",false)
		fullscreen = false
		config.set_value("graphics","resolution",0)
		resolution = 0
		
		config.save(config_path)

#Settings


