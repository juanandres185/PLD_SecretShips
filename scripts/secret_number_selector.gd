extends Node2D

var separador = 200

var numeroActual = [0,0,0,0]
var actual_num_digits=0

var pos

var tecla_up
var tecla_down
var tecla_right
var tecla_left



# Called when the node enters the scene tree for the first time.
func _ready():
	tecla_up = KEY_UP
	tecla_down = KEY_DOWN
	tecla_right = KEY_RIGHT
	tecla_left = KEY_LEFT
	pos = 0
	numeroActual = []

	for i in range(Global.num_digits):
			numeroActual+=[0]
			var digit_selector = preload("res://nodes/digit_selector.tscn").instantiate()
			add_child(digit_selector)
			move_child(digit_selector,i)
			digit_selector.add_to_group("selectors")
			digit_selector.position.x = i*separador
	
	
	$Scribble.volume_db = Global.get_volume_dB(1)
	$MoveArrow.volume_db = Global.get_volume_dB(1)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func up(pos):
	numeroActual[pos] = (numeroActual[pos]+1) % Global.mod
	$Scribble.play()
	return numeroActual[pos]
	
func down(pos):
	numeroActual[pos] = (numeroActual[pos]-1+Global.mod) % Global.mod
	$Scribble.play()
	return numeroActual[pos]
	
func next_digit():
	if pos < Global.num_digits -1 :
		pos+=1
		$arrow.move_local_x(separador)
		
	$MoveArrow.play()
	return pos

func previous_digit():
	if pos > 0:
		pos-=1
		$arrow.move_local_x(-separador)
	$MoveArrow.play()
	return pos
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == tecla_up:
			for cannon in get_tree().get_nodes_in_group("selectors"):
				if cannon.num == pos and cannon.get_parent() == self:
					cannon._on_digit_up_pressed()

		if event.keycode == tecla_down:		
			for cannon in get_tree().get_nodes_in_group("selectors"):
				if cannon.num == pos and cannon.get_parent() == self:
					cannon._on_digit_down_pressed()

		if event.keycode == tecla_right:
			next_digit()
		
		if event.keycode == tecla_left:
			previous_digit()
				
		print(numeroActual)
			


