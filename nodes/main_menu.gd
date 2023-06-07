extends Control

var menu_origin_position := Vector2.ZERO
var menu_origin_size := Vector2.ZERO

var num_players
var volume_type

var current_menu
var current_menu_pos
var menu_stack := []

var main_menu
var options_menu
var play_menu
var volume_menu



# Called when the node enters the scene tree for the first time.
func _ready():
	
	num_players = 0
	volume_type = 0
	
	main_menu = $MainMenu
	options_menu = $OptionsMenu
	play_menu = $PlayMenu
	volume_menu = $VolumeMenu
	
	menu_origin_position = Vector2(0,0)
	menu_origin_size = get_viewport_rect().size
	current_menu = main_menu
	current_menu_pos = main_menu.global_position
	
func _process(delta):
	if $Music.playing == false:
		$Music.play()
	
	$Music.volume_db = Global.get_volume_dB(0)
	$left_right_Sound.volume_db = Global.get_volume_dB(1)
	$select_Sound.volume_db = Global.get_volume_dB(1)
		
func move_to_next_menu(next_menu_id: String):
	var next_menu = get_menu_from_menu_id(next_menu_id)
	
	
	
	var tween = create_tween()
	var dir = next_menu.global_position.y/abs(next_menu.global_position.y)
	tween.tween_property(current_menu,"global_position",Vector2(0,-dir*menu_origin_size.y),0.3)
	tween.tween_property(next_menu,"global_position",menu_origin_position,0.3)
	
	menu_stack.append(current_menu)
	current_menu = next_menu

func move_to_previous_menu():
	var previous_menu = menu_stack.pop_back()
	if previous_menu != null:
		
		var dir = previous_menu.global_position.y/abs(previous_menu.global_position.y)
		var tween = create_tween()
		tween.tween_property(current_menu,"global_position",Vector2(0,-dir*menu_origin_size.y),0.3)
		tween.tween_property(previous_menu,"global_position",menu_origin_position,0.3)
		current_menu = previous_menu
		

func get_menu_from_menu_id(menu_id:String) -> Control:
	match menu_id:
		"main_menu":
			return main_menu
		"options_menu":
			return options_menu
		"play_menu":
			return play_menu
		"volume_menu":
			return volume_menu
		_:
			return main_menu

func _load_game():
	if (num_players == 1):
		get_tree().change_scene_to_file("res://nodes/1p_game.tscn")
	else:
		get_tree().change_scene_to_file("res://nodes/2p_selector.tscn")

func _on_select_option_pressed():
	$select_Sound.play()
	
	var selected = current_menu.select_option()
	match selected:
		"main_single":
			num_players = 1
			$PlayMenu/Node2D/TitleS.visible = true
			$PlayMenu/Node2D/TitleM.visible = false
			move_to_next_menu("play_menu")
		"main_multi":
			num_players = 2
			$PlayMenu/Node2D/TitleS.visible = false
			$PlayMenu/Node2D/TitleM.visible = true
			move_to_next_menu("play_menu")
		"main_config":
			move_to_next_menu("options_menu")
		"main_exit":
			get_tree().quit()
		"play_turns":
			Global.win_system = 1
			_load_game()
		"play_time":
			Global.win_system = 2
			_load_game()
		"play_points":
			Global.win_system = 3
			_load_game()
		"options_general":
			$VolumeMenu/Node2D/TitleG.visible = true
			$VolumeMenu/Node2D/TitleS.visible = false
			$VolumeMenu/Node2D/TitleM.visible = false
			volume_type = 0
			$VolumeMenu/Volume.text = str(Global.volume_general)
			move_to_next_menu("volume_menu")
		"options_sounds":
			$VolumeMenu/Node2D/TitleG.visible = false
			$VolumeMenu/Node2D/TitleS.visible = true
			$VolumeMenu/Node2D/TitleM.visible = false
			volume_type = 1
			$VolumeMenu/Volume.text = str(Global.volume_sounds)
			move_to_next_menu("volume_menu")
		"options_music":
			$VolumeMenu/Node2D/TitleG.visible = false
			$VolumeMenu/Node2D/TitleS.visible = false
			$VolumeMenu/Node2D/TitleM.visible = true
			volume_type = 2
			$VolumeMenu/Volume.text = str(Global.volume_music)
			move_to_next_menu("volume_menu")
		"options_fullscreen":
			Global.toggle_fullscreen()
		"change_volume":
			Global.change_volume(int($VolumeMenu/Volume.text),volume_type)
			move_to_previous_menu()
		"return":
			move_to_previous_menu()
		_:
			print(selected)

func _on_go_left_pressed():
	current_menu.go_left()
	$left_right_Sound.play()


func _on_go_right_pressed():
	current_menu.go_right()
	$left_right_Sound.play()
