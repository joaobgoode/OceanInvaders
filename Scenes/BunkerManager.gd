extends Node

var area: Area2D;
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bunker_tile_bunker_hit(area: Area2D, bunker: Area2D) -> void:
	if area != self.area:
		area.queue_free()
		bunker.queue_free()
		self.area = area
		
