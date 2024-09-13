extends Node
var shark = preload("res://Scenes/shark.tscn")
var shark_available = true
var game_ended = false


func _process(delta: float) -> void:
	if self.get_child_count() == 0 && shark_available && !game_ended:
		shark_available = false
		await get_tree().create_timer(range(4,6).pick_random()).timeout
		var shark_instance = shark.instantiate()
		self.add_child(shark_instance)
		shark_available = true
		


func _on_game_ended() -> void:
	queue_free()
