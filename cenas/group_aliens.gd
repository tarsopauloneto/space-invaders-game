extends Node

var Alien = preload("res://cenas/alien.tscn")
var Bonus = preload("res://cenas/bonus.tscn")

@onready var timer_disparar = $timerDisparar

var lista_aliens = []

func _ready():
	$timerBonus.wait_time = randf_range(8.0, 12.0)
	$timerBonus.start()
	for j in range(4):
		lista_aliens.append([])
		for i in range(8):
			var alien = Alien.instantiate()
			alien.global_position = Vector2(55+20*i, 40+20*j)
			self.add_child(alien)
			lista_aliens[j].append(alien)
			alien.connect("alien_eliminado", Callable(self, "eliminar_alien"))
			alien.connect("alien_eliminado", Callable(get_parent(), "Somar_pontos_alien"))
	#print(lista_aliens)

func eliminar_alien(a):
	for fila in lista_aliens:
		if a in fila:
			fila.erase(a)  #Remove o alien da fila

func verificar_vitoria():
	var todos_destruidos = true
	for fila in lista_aliens:
		for a in fila:
			if is_instance_valid(a) and !a.is_queued_for_deletion():
				todos_destruidos = false
				break
		if !todos_destruidos:
			break

	if todos_destruidos:
		get_tree().change_scene_to_file("res://cenas/voceVenceu.tscn")
	else:
		print("ainda existe alien vivo")

func _on_timer_descida_timeout():
	print("descendo")
	for fila in lista_aliens:
		for a in fila:
			if is_instance_valid(a):
				a.position.y += 21

func _on_timer_disparar_timeout():
	var lista_aliens_vivos = []
	for fila in lista_aliens:
		for a in fila:
			if is_instance_valid(a) and !a.is_queued_for_deletion():
				lista_aliens_vivos.append(a)
	if lista_aliens_vivos:
		var indice = int(floor(randf_range(0, len(lista_aliens_vivos)-1)))
		lista_aliens_vivos[indice].disparar()
		timer_disparar.wait_time = randf_range(2, 5)

	verificar_vitoria()      #Verifica se todos os aliens foram destruídos.

func _on_timer_bonus_timeout():
	var bonus = Bonus.instantiate()
	bonus.global_position = Vector2(260, 60)
	$AudioStreamPlayer.play()
	self.add_child(bonus)
	bonus.connect("bonus_eliminado", Callable(get_parent(), "Somar_pontos_bonus"))
