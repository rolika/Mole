extends Node2D


var mole_threatened


# Called when the node enters the scene tree for the first time.
func _ready():
	mole_threatened = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_mole_threatened():
	mole_threatened = true


func _on_player_smashed():
	if mole_threatened:
		print("BANG!!")


func _on_mole_area_exited(area):
	mole_threatened = false
