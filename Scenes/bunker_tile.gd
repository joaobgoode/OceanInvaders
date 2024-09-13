extends Area2D
class_name Bunker;

signal bunker_hit(area: Area2D, bunker: Area2D);

func _on_area_entered(area: Area2D) -> void:
	if !(area is Enemy):
		bunker_hit.emit(area, self)
	else:
		queue_free()
