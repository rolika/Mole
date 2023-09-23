extends Node2D


var above_mole: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	above_mole = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_mole_threatened():
	above_mole = true


func _on_mole_safe():
	above_mole = false


func _on_player_smashed():
	if above_mole:
		print("BANG!!")
