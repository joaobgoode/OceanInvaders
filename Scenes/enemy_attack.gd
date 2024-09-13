extends Area2D
class_name EnemyAttack

var speed = 200

func _ready():
	pass

func _process(delta):
	position.y += speed * delta
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		body.take_damage(1)
		queue_free()
