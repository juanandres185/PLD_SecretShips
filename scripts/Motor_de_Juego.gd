extends Node2D

var num_digits = 4
var mod = 10

var numeroSecreto = [4, 5, 6, 7]
var numeroActual = [0, 1, 2, 3]

var pos

# Called when the node enters the scene tree for the first time.
func _ready():
	pos = 0


func digit_up():
	numeroActual[pos] = (numeroActual[pos]+1) % mod
	return numeroActual
	
func digit_down():
	numeroActual[pos] = (numeroActual[pos]-1) % mod	
	return numeroActual
	
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
		
		
	

