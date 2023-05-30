extends Control

var menu_origin_position := Vector2.ZERO
var menu_origin_size := Vector2.ZERO

var num_players

var current_menu
var current_menu_pos
var menu_stack := []

var main_menu
var options_menu
var play_menu



# Called when the node enters the scene tree for the first time.
func _ready():
	
	num_players = 0
	
	main_menu = $MainMenu
	options_menu = $OptionsMenu
	play_menu = $PlayMenu
	
	menu_origin_position = Vector2(0,0)
	menu_origin_size = get_viewport_rect().size
	current_menu = main_menu
	current_menu_pos = main_menu.global_position

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
		_:
			return main_menu

func _load_game():
	if (num_players == 1):	
		get_tree().change_scene_to_file("res://nodes/1p_game.tscn")
	else:
		get_tree().change_scene_to_file("res://nodes/2p_selector.tscn")

func _on_select_option_pressed():
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
		"options_sounds":
			$VolumeMenu/Node2D/TitleG.visible = false
			$VolumeMenu/Node2D/TitleS.visible = true
			$VolumeMenu/Node2D/TitleM.visible = false
			print("WIP")
		"options_music":
			$VolumeMenu/Node2D/TitleG.visible = false
			$VolumeMenu/Node2D/TitleS.visible = false
			$VolumeMenu/Node2D/TitleM.visible = true
			print("WIP")
		"return":
			move_to_previous_menu()
		_:
			print(selected)

func _on_go_left_pressed():
	current_menu.go_left()


func _on_go_right_pressed():
	current_menu.go_right()
