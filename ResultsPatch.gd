extends Control

var gamemode
var puntuation
var code
var result
var playernumber


# Called when the node enters the scene tree for the first time.
func _ready():
	
	gamemode = $GameMode
	
	match (Global.win_system):
		1:
			gamemode.text = "Modo de juego: Por turnos"
		2:
			gamemode.text = "Modo de juego: Por tiempo"
		3:
			gamemode.text = "Modo de juego: Por puntuación"
	
	puntuation = $Puntuation
	
	puntuation.text = "Puntuación final: "+str(Global.score)
	
	code = $Code
	
	code.text = "El código adivinado es: "
	for i in Global.p1_number:
		code.text += str(i)


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://nodes/main_menu.tscn")
