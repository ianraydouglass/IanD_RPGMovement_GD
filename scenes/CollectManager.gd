extends Node2D

var ice_key
var fire_key

var ice_key_status = "none"
var fire_key_status = "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	ice_key = $IceKeyIndicator
	fire_key = $FireKeyIndicator
	pass # Replace with function body.

func lock_keys():
	print("locking keys")
	if ice_key_status == "player":
		set_ice_key_status("lock")
	if fire_key_status == "player":
		set_fire_key_status("lock")

func drop_keys():
	print("dropping keys")
	if ice_key_status == "player":
		set_ice_key_status("none")
	if fire_key_status == "player":
		set_fire_key_status("none")

func is_fire_key_loose():
	if fire_key_status == "player" or fire_key_status == "lock":
		return false
	else:
		return true

func is_ice_key_loose():
	if ice_key_status == "player" or ice_key_status == "lock":
		return false
	else:
		return true

func set_ice_key_status(s):
	if ice_key_status == s:
		return
	if ice_key_status == "lock":
		return
	if s == "none":
		collect_ice_key(false)
		ice_key_status = "none"
		print("ice key none")
	if s == "player":
		collect_ice_key(true)
		ice_key_status = "player"
		print("ice key player")
	if s == "lock":
		collect_ice_key(true)
		ice_key_status = "lock"
		print("ice key lock")

func set_fire_key_status(s):
	if fire_key_status == s:
		return
	if fire_key_status == "lock":
		return
	if s == "none":
		collect_fire_key(false)
		fire_key_status = "none"
		print("fire key none")
	if s == "player":
		collect_fire_key(true)
		fire_key_status = "player"
		print("fire key player")
	if s == "lock":
		collect_fire_key(true)
		fire_key_status = "lock"
		print("fire key lock")

func collect_ice_key(b):
	ice_key.set_visible(b)
	
func collect_fire_key(b):
	fire_key.set_visible(b)
