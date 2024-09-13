extends Area2D
class_name Shark

var enemy_attack_scene = preload("res://Scenes/enemy_attack.tscn")
const TUBARAO_FERIDO = preload("res://Assets/sprites/tubarao-ferido.png")
var speed = 200
const POINTS = [100, 50, 50, 100, 150, 100, 100, 50, 300, 100, 100, 100, 50, 150, 100]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Vector2(-599, -291)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta;
	



func _on_area_entered(area: Area2D) -> void:
	if area is Torpedo:
		area.queue_free()
		speed = -300
		var points = POINTS[Stats.run_shots % 16]
		$Sprite2D.texture = TUBARAO_FERIDO
		Stats.run_shark_kills += 1
		Stats.run_shark_points += points
		Stats.run_points += points
		
		

func attack():
	var enemy_attack = enemy_attack_scene.instantiate() as EnemyAttack
	enemy_attack.position = position
	(enemy_attack.get_node("Sprite2D") as Sprite2D).modulate = Color(0.62, 0.2, 0.2, 1)
	get_tree().get_current_scene().add_child(enemy_attack)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_attack_timer_timeout() -> void:
	attack()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	$AttackTimer.start()
