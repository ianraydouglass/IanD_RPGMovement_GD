extends Area2D

@export var message_text: String = "area entered"
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", display_text)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_text(other):
	var character_object = other.get_owner()
	if !character_object.has_method("move_player"):
		return
	print("display area entered")
	print(message_text)
