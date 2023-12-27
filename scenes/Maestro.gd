extends Node2D


var current_bpm: float = 120 #beats per minute of the current track
var time_since_last_beat: float
var quarter_in_measure: int = 1 #iterates from 1 to 16
var seconds_per_beat: float = 0.4


var all_performers = []

func _ready():
	seconds_per_beat = get_seconds_per_beat(current_bpm)
	pass # Replace with function body.

func get_seconds_per_beat(x):
	var output: float = (60 / x)
	return output

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_since_last_beat += delta
	if(time_since_last_beat >= seconds_per_beat):
		on_beat()

func reset_from_bpm(b):
	current_bpm = b
	time_since_last_beat = 0
	quarter_in_measure = 0
	seconds_per_beat = get_seconds_per_beat(b)
	
func on_beat():
	time_since_last_beat -= seconds_per_beat
	if quarter_in_measure >= 16:
		quarter_in_measure = 1
	else:
		quarter_in_measure += 1
	print("beat " + str(quarter_in_measure))
	clean_up_performers()
	if all_performers.size() == 0:
		return
	for i in all_performers.size():
		if all_performers[i] != null:
			all_performers[i].on_get_beat(quarter_in_measure)
	pass

func register_performer(p):
	if all_performers.has(p):
		print("can't register performer, already on list")
	else:
		all_performers.append(p)

func clean_up_performers():
	if all_performers.size() == 0:
		return
	var index_to_remove = -1
	for i in all_performers.size():
		if i == null:
			index_to_remove = i#found a null reference
	if index_to_remove < 0: #did not find
		return
	all_performers.remove_at(index_to_remove)
	clean_up_performers()#repeat to make sure there isn't more than one
	pass
