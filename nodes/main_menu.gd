extends Control

var menu_origin_position := Vector2.ZERO
var menu_origin_size := Vector2.ZERO

var num_players

var tween = create_tween()

var current_menu
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

func move_to_next_menu(next_menu_id: String):
	var next_menu = get_menu_from_menu_id(next_menu_id)
	#current_menu.global_position = Vector2(0,-menu_origin_size.y)
	tween.tween_property(current_menu,"transition",Vector2(0,-menu_origin_size.y),3.0)
	next_menu.global_position = menu_origin_position
	
	
	menu_stack.append(current_menu)
	current_menu = next_menu

func move_to_previous_menu():
	var previous_menu = menu_stack.pop_back()
	if previous_menu != null:
		previous_menu.global_position = menu_origin_position
		current_menu.global_positon = Vector2(0,menu_origin_size.y)
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
	

func _on_select_option_pressed():
	var selected = current_menu.select_option()
	match selected:
		"main_single":
			num_players = 1
			move_to_next_menu("play_menu")
		"main_multi":
			num_players = 2
			move_to_next_menu("play_menu")
		"main_config":
			move_to_next_menu("options_menu")
		"main_exit":
			get_tree().quit()
		_:
			print(selected)

func _on_go_left_pressed():
	current_menu.go_left()


func _on_go_right_pressed():
	current_menu.go_right()
