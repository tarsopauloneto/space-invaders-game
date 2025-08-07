extends Area2D

var speed = 200

func _process(delta):
	position.y += speed * delta

func _on_body_entered(body):
	if body.is_in_group("tanque") or body.is_in_group("blocos"):
		body.destruir()
		queue_free()
