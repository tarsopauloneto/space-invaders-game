extends Node

var Bloco = preload("res://cenas/bloco.tscn")

func _ready():
	var bloco = Bloco.instantiate()
	var largura_da_tela = 224
	var altura_da_tela = 256
	var n_blocos = largura_da_tela/3
	
	for i in range(n_blocos):
		bloco = Bloco.instantiate()
		bloco.global_position = Vector2(i*4, altura_da_tela)
		add_child(bloco)
