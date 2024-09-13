extends Area2D

class_name WallRight


func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		body.speed = 0
