extends Node2D

var num_canons = 0
var separador = 170

var points_per_turn = 250
var points_per_second = 10

var numeroSecreto = [1,2,3,4]
var numeroActual = [0,0,0,0]

var score
var count_time
var count_turns

var pos

var tecla_up
var tecla_down
var tecla_right
var tecla_left
var tecla_boom

signal finish(score)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if Global.win_system == 1:
		score = 10000
		count_time=false
		count_turns=true
	elif Global.win_system == 2:
		score = 10000
		count_time=true
		count_turns=false
	elif Global.win_system == 3:
		score = 10000
		count_time=true
		count_turns=true
	else:
		print("ERROR CON EL SISTEMA DE PUNTUACIÓN")

	$score.text = str(score)
	$Touch.text = ""
	$Sunk.text = ""
	
	tecla_up = KEY_UP
	tecla_down = KEY_DOWN
	tecla_right = KEY_RIGHT
	tecla_left = KEY_LEFT
	tecla_boom = KEY_ENTER
	pos = 0
	numeroActual = []
	numeroSecreto=Global.p1_number
	
	for i in range(Global.num_digits):
		numeroActual+=[0]
		
		var cannon = preload("res://nodes/cannon.tscn").instantiate()
		add_child(cannon)
		move_child(cannon,i)
		cannon.add_to_group("cannons")
		cannon.position.x = i*separador
	
	

func digit_up():
	numeroActual[pos] = (numeroActual[pos]+1) % Global.mod
	return numeroActual
	
func digit_down():
	numeroActual[pos] = (numeroActual[pos]-1+Global.mod) % Global.mod	
	return numeroActual
	
#En esta función se requiere una variable pos llamada igual que la variable global pos.
func up(pos):
	numeroActual[pos] = (numeroActual[pos]+1) % Global.mod
	return numeroActual[pos]
	
func down(pos):
	numeroActual[pos] = (numeroActual[pos]-1+Global.mod) % Global.mod	
	return numeroActual[pos]
	
func next_digit():
	if pos < Global.num_digits -1 :
		pos+=1
		$arrow.move_local_x(separador)
	return pos

func previous_digit():
	if pos > 0:
		pos-=1
		$arrow.move_local_x(-separador)
	return pos
	
func boom():
	var num_tocados = 0
	var num_hundidos = 0
	
	for i in range(Global.num_digits):
		if numeroSecreto[i] == numeroActual[i] :
			num_hundidos+=1
		else :
			for digit in numeroSecreto:
				if digit == numeroActual[i]:
					num_tocados+=1
					
	if num_hundidos == Global.num_digits:
		finish.emit(score)
					
	if count_turns:
		score-=points_per_turn
		$score.text = str(score)
		if score == 0:
			finish.emit(score)
		
	return [num_tocados, num_hundidos]
	
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == tecla_up:
			for cannon in get_tree().get_nodes_in_group("cannons"):
				if cannon.num == pos and cannon.get_parent() == self:
					cannon._on_digit_up_pressed()

		if event.keycode == tecla_down:		
			for cannon in get_tree().get_nodes_in_group("cannons"):
				if cannon.num == pos and cannon.get_parent() == self:
					cannon._on_digit_down_pressed()

		if event.keycode == tecla_right:
			next_digit()
			
		if event.keycode == tecla_left:
			previous_digit()
			
		if event.keycode == tecla_boom:
			_on_boom_pressed()
			


func _on_boom_pressed():
	var ret = boom()
	$Touch.text += str(ret[0])+"\n"
	$Sunk.text += str(ret[1])+"\n"
	
	var touch1 = $Touch.text.split("\n")
	var sunk1 = $Sunk.text.split("\n")
	if (len(touch1) > 10):
		$Touch.text = $Touch.text.left(len(touch1[0])+1)
		$Sunk.text = $Sunk.text.left(len(sunk1[0])+1)
	
func _on_timer_timeout():
	if count_time:
		score-=points_per_second
		$score.text = str(score)
		if score == 0:
			finish.emit(score)
