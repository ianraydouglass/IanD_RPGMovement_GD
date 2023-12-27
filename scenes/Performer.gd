extends Node2D

var maestro
var sub_performers = []
# Called when the node enters the scene tree for the first time.
func _ready():
	maestro = get_tree().get_root().get_node("GameManager/Maestro")
	if maestro == null:
		print("maestro not found")
	else:
		maestro.register_performer(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_get_beat(b):
	print("performer got beat " + str(b))
	sub_performers = get_children()
	if sub_performers.size() > 0:
		for i in sub_performers.size():
			if sub_performers[i].has_method("recieve_beat"):
				sub_performers[i].recieve_beat(b)
