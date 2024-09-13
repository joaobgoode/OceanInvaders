extends Node

var x = 10
var y = 0
var direction = -1
var movement = Vector2(x * direction,y)

signal game_won
signal game_lost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_movement_timeout() -> void:
	var enemy_list = (get_children().filter(func (child): return child is Enemy))
	movement = Vector2(x * direction,y)
	y = 0
	x = 10
	if enemy_list.is_empty():
		game_won.emit()
	else:
		for enemy in enemy_list:
			enemy.move(movement)

	

func _on_attack_timeout() -> void:
	(get_children().filter(func (child): return child is Enemy).pick_random() as Enemy).attack()


func _on_node_area_entered(area: Area2D) -> void:
	if area is Enemy:
		direction = 1
		y = 20
		x = 0


func _on_right_wall_area_entered(area: Area2D) -> void:
	if area is Enemy:
		direction = -1
		y = 20
		x = 0


func _on_game_lost(area: Area2D) -> void:
	$Movement.stop()
	$Attack.stop()
	if area is Enemy:
		game_lost.emit()


func _on_player_game_lost() -> void:
	$Movement.stop()
	$Attack.stop()
