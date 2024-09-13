extends Node2D

var torpedo_scene = preload("res://Scenes/torpedo.tscn")
var can_player_shoot = true

func _input(_event):
	if Input.is_action_just_pressed("shoot") && can_player_shoot:
		var torpedo = torpedo_scene.instantiate() as Torpedo
		torpedo.global_position = get_parent().global_position - Vector2(0,20)
		get_tree().get_current_scene().add_child(torpedo)
		Stats.run_shots += 1
		can_player_shoot = false
		torpedo.tree_exited.connect(_tree_exited)

func _tree_exited():
	can_player_shoot = true
