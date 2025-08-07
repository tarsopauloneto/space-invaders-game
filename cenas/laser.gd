extends Area2D

var velocity = 400

func _process(delta):
	position.y -= velocity * delta

func _on_body_entered(body):
	if body.is_in_group("aliens"):
		body.explosion()
		get_parent().remove_child(self)
		queue_free()

	elif body.is_in_group("blocos"):
		body.destruir()
		if !is_queued_for_deletion():
			get_parent().remove_child(self)
			queue_free()
