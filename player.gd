extends Area2D


signal smashed
signal paused


func _process(_delta):
	# bind player to mouse position
	position = get_global_mouse_position()


func _input(event):
	if event.is_action_pressed("smash"):
		smashed.emit()
	if event.is_action_pressed("pause"):
		paused.emit()
