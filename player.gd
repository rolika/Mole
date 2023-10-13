extends Area2D


signal smashed
signal paused


func _process(_delta):
	# bind player to mouse position
	position = get_global_mouse_position()


func _input(event):
	if event.is_action_pressed("smash"):
		$SmashTimer.start()
		smashed.emit()
	if event.is_action_pressed("pause"):
		paused.emit()


func _on_smash_timer_timeout():
	self.rotation_degrees = 0


func _on_smashed():
	self.rotation_degrees = -45


func flip():
	# flip the shovel depending on horizontal position
	pass
