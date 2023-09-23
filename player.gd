extends Area2D


signal smash


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = get_global_mouse_position()


func _input(event):
	if event.is_action_pressed("smash"):
		emit_signal("smash")
		

func _on_smash():
	print("B A N G ! !")
