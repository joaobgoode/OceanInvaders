extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Stats.load_game()
	%HighScore.text = "%d\nHi-Score" %Stats.hi_score
	%SquidBest.text = "%d" %Stats.best_squid_kills
	%SquidAll.text = "%d" %Stats.squid_kills
	%CrabBest.text = "%d" %Stats.best_crab_kills
	%CrabAll.text = "%d" %Stats.crab_kills
	%JellyBest.text = "%d" %Stats.best_jelly_kills
	%JellyAll.text = "%d" %Stats.jelly_kills
	%SharkBest.text = "%d" %Stats.best_shark_kills
	%SharkAll.text = "%d" %Stats.shark_kills
	%BestKills.text = "%d" %(Stats.best_squid_kills + Stats.best_crab_kills + Stats.best_jelly_kills + Stats.best_shark_kills)
	%AllKills.text = "%d" %(Stats.squid_kills + Stats.crab_kills + Stats.jelly_kills + Stats.shark_kills)
	%Allpoints.text = "%d" %Stats.points


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_stats_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		%Stats.visible = true
	else:
		%Stats.visible = false
