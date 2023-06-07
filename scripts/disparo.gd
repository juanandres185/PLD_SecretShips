extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func shot(disparo, tocados, hundidos):
	$tocados.text = str(tocados)
	$hundidos.text = str(hundidos)
	$disparo.text = "Disparo Nº"+str(disparo)
