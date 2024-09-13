extends Node

#Total

var shark_kills = 0  
var squid_kills = 0  
var crab_kills = 0  
var jelly_kills = 0
var shark_points = 0
var points = 0

#run

var run_shark_kills = 0 #shark
var run_squid_kills = 0 #squid
var run_crab_kills = 0 #crab
var run_jelly_kills = 0 #jelly
var run_shark_points = 0 #shark
var run_points = 0 #shark, jelly, crab, squid
var run_shots = 0 #player

#best

var hi_score = 0
var best_shark_kills = 0
var best_squid_kills = 0
var best_crab_kills = 0
var best_jelly_kills = 0
var best_shark_points = 0

func reset_run():
	run_shark_kills = 0 #shark
	run_squid_kills = 0 #squid
	run_crab_kills = 0 #crab
	run_jelly_kills = 0 #jelly
	run_shark_points = 0 #shark
	run_points = 0 #shark, jelly, crab, squid
	run_shots = 0 #player
	
func update_best():
	if hi_score < run_points:
		hi_score = run_points
		best_shark_kills = run_shark_kills
		best_squid_kills = run_squid_kills
		best_crab_kills = run_crab_kills
		best_jelly_kills = run_jelly_kills
		best_shark_points = run_shark_points

func update_total():
	shark_kills += run_shark_kills
	squid_kills += run_squid_kills
	crab_kills += run_crab_kills
	jelly_kills += run_jelly_kills
	shark_points += run_shark_points
	points += run_points

func save():
	var save_dict = {
		"hi_score" = hi_score,
		"best_shark_kills" = best_shark_kills,
		"best_squid_kills" = best_squid_kills,
		"best_crab_kills" = best_crab_kills,
		"best_jelly_kills" = best_jelly_kills,
		"best_shark_points" = best_shark_points,
		"shark_kills" = shark_kills,
		"squid_kills" = squid_kills,
		"crab_kills" = crab_kills,
		"jelly_kills" = jelly_kills,
		"shark_points" = shark_points,
		"points" = points
	}
	return save_dict

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_file.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return

	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()

		hi_score = node_data["hi_score"]
		best_shark_kills = node_data["best_shark_kills"]
		best_squid_kills = node_data["best_squid_kills"]
		best_crab_kills = node_data["best_crab_kills"]
		best_jelly_kills = node_data["best_jelly_kills"]
		best_shark_points = node_data["best_shark_points"]
		shark_kills = node_data["shark_kills"]
		squid_kills = node_data["squid_kills"]
		crab_kills = node_data["crab_kills"]
		jelly_kills = node_data["jelly_kills"]
		shark_points = node_data["shark_points"]
		points = node_data["points"]
