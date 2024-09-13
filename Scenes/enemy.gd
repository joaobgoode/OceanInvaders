extends Area2D
class_name Enemy
@export var points: int;

var enemy_attack_scene = preload("res://Scenes/enemy_attack.tscn")

func _on_area_entered(area: Area2D) -> void:
	if area is Torpedo:
		area.queue_free()
		$CollisionShape2D.queue_free()
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.play("destroy")
		Stats.run_points += points
		if (points == 30):
			Stats.run_squid_kills += 1
		elif (points == 20):
			Stats.run_crab_kills += 1
		elif (points == 10):
			Stats.run_jelly_kills += 1
		await get_tree().create_timer(1).timeout
		queue_free()
		
func attack():
	var enemy_attack = enemy_attack_scene.instantiate() as EnemyAttack
	enemy_attack.position = position
	get_tree().get_current_scene().add_child(enemy_attack)

func move(movement: Vector2):
	position += movement
