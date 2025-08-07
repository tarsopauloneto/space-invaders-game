extends Node

var pontos = 0
@onready var label_pontos = $VBoxContainer/labelPontos

func Somar_pontos_alien():
	pontos += 100
	label_pontos.text = str(pontos)

func Somar_pontos_bonus():
	pontos += 500
	label_pontos.text = str(pontos)
