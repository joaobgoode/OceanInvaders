extends Area2D

class_name Torpedo
@export var speed = 300;


func _process(delta):
	position.y -= speed * delta;

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
