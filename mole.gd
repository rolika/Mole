extends Area2D


var threatened: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	threatened = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(_area):
	threatened = true


func _on_area_exited(_area):
	threatened = false


func _on_player_smashed():
	if threatened:
		print("BANG!!!")
		hide()
