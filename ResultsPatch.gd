extends Control

var gamemode
var puntuation
var code
var result
var playernumber


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Music.volume_db = Global.get_volume_dB(0)+10
		
	gamemode = $GameMode
	
	match (Global.win_system):
		1:
			gamemode.text = "Modo de juego: Por turnos"
		2:
			gamemode.text = "Modo de juego: Por tiempo"
		3:
			gamemode.text = "Modo de juego: Por puntuación"
	

	if(Global.p1_score < Global.p2_score):
		$Result1.text = "DERROTA"
	else:
		$Result2.text = "DERROTA"
		
	if(Global.p1_score <= 0):
		$Puntuation1.text = "Puntuación final: 0"
	else:
		$Puntuation1.text = "Puntuación final: "+str(Global.p1_score)		
	
	if(Global.p2_score <= 0):
		$Puntuation1.text = "Puntuación final: 0"	
	else:
		$Puntuation2.text = "Puntuación final: "+str(Global.p2_score)
		
		
	$Code1.text = "El código secreto era: "
	for i in Global.p1_number:
		$Code1.text += str(i)
	$Code2.text = "El código secreto era: "
	for i in Global.p2_number:
		$Code2.text += str(i)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE or event.keycode == KEY_ENTER:
			_on_exit_pressed()

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://nodes/main_menu.tscn")
	
func _process(delta):
	if $Music.playing == false: $Music.play()
