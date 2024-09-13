extends CanvasLayer
@onready var stats: Node2D = $Stats
@onready var buttons: Node2D = $Buttons
@onready var points: Label = $Labels/Points
@onready var new_high_score: Label = %"New High Score"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%HiScore.text = " Hi Score \n %d " % Stats.hi_score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Points.text = "Score: %d" % Stats.run_points


func _on_game_lost() -> void:
	Stats.update_total()
	stats.visible = true
	buttons.visible = true
	Stats.save_game()




func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_stats_visibility_changed() -> void:
	if %Stats.visible == true:
			%"Squid Kills".text = "%d" % Stats.run_squid_kills
			%"Crab Kills".text = "%d" % Stats.run_crab_kills
			%"Jelly Kills".text = "%d" % Stats.run_jelly_kills
			%"Shark Kills".text = "%d" % Stats.run_shark_kills
			%"Squid Points".text = "%d" % (Stats.run_squid_kills * 30)
			%"Crab Points".text = "%d" % (Stats.run_crab_kills * 20)
			%"Jelly Points".text = "%d" % (Stats.run_jelly_kills * 10)
			%"Shark Points".text = "%d" % Stats.run_shark_points
			%"Total Kills".text = "%d" % (Stats.run_squid_kills + Stats.run_crab_kills + Stats.run_jelly_kills + Stats.run_shark_kills)
			%"Total Points".text = "%d" % Stats.run_points
			if (Stats.run_points > Stats.hi_score):
				print(Stats.run_points)
				new_high_score.visible = true
			Stats.update_best()
			Stats.reset_run()
	

func _input(event):
	if event.is_action_pressed("reset"):
		reset()


func reset():
	Stats.reset_run()
	get_tree().reload_current_scene()
	
func _on_try_again_pressed() -> void:
	reset()


func _on_enemies_game_won() -> void:
	get_tree().reload_current_scene()
