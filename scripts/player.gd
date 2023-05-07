extends Node2D

var disparo = preload("res://nodes/disparo.tscn")
var pos_disparo = Vector2(20,170)

var num_canons = 0

var num_digits = 4
var mod = 10

var numeroSecreto = [1,2,3,4]
var numeroActual = [0,0,0,0]

var pos

var tecla_up = KEY_UP
var tecla_down = KEY_DOWN
var tecla_right = KEY_RIGHT
var tecla_left = KEY_LEFT
var tecla_boom = KEY_ENTER

# Called when the node enters the scene tree for the first time.
func _ready():
	pos = 0
	numeroActual = []
	numeroSecreto = []
	for i in range(num_digits):
		numeroActual+=[0]
		numeroSecreto+=[i]
		


func digit_up():
	numeroActual[pos] = (numeroActual[pos]+1) % mod
	return numeroActual
	
func digit_down():
	numeroActual[pos] = (numeroActual[pos]-1+mod) % mod	
	return numeroActual
	
#En esta función se requiere una variable pos llamada igual que la variable global pos.
func up(pos):
	numeroActual[pos] = (numeroActual[pos]+1) % mod
	return numeroActual[pos]
	
func down(pos):
	numeroActual[pos] = (numeroActual[pos]-1+mod) % mod	
	return numeroActual[pos]
	
func next_digit():
	if pos < num_digits -1 :
		pos+=1
	return pos

func previous_digit():
	if pos > 0:
		pos-=1
	return pos
	
func boom():
	var num_tocados = 0
	var num_hundidos = 0
	
	for i in range(num_digits):
		if numeroSecreto[i] == numeroActual[i] :
			num_hundidos+=1
		else :
			for digit in numeroSecreto:
				if digit == numeroActual[i]:
					num_tocados+=1
	
	return [num_tocados, num_hundidos]
	
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == tecla_up:
			for cannon in get_tree().get_nodes_in_group("cannons"):
				if cannon.num == pos:
					cannon._on_digit_up_pressed()

		if event.keycode == tecla_down:		
			for cannon in get_tree().get_nodes_in_group("cannons"):
				if cannon.num == pos:
					cannon._on_digit_down_pressed()

		if event.keycode == tecla_right:
			next_digit()
			
		if event.keycode == tecla_left:
			previous_digit()
			
		if event.keycode == tecla_boom:
			var ret = boom()
			var new_disparo = disparo.instantiate()
			new_disparo.shot(numeroActual, ret[0], ret[1])
			pos_disparo.y+=20
			new_disparo.position = pos_disparo
			$last_disparo/hundidos.text = str(ret[1])
			$last_disparo/tocados.text = str(ret[0])
			$last_disparo/disparo.text = str(numeroActual)
			add_child(new_disparo)
			
			print(new_disparo.position)
			


func _on_boom_pressed():
	var ret = boom()
	var new_disparo = disparo.instantiate()
	new_disparo.shot(numeroActual, ret[0], ret[1])
	pos_disparo.y+=20
	new_disparo.position = pos_disparo
	$last_disparo/hundidos.text = str(ret[1])
	$last_disparo/tocados.text = str(ret[0])
	$last_disparo/disparo.text = str(numeroActual)
	add_child(new_disparo)
	
	print(new_disparo.position)
