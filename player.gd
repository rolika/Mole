extends Area2D


signal smashed
signal paused


var shovel_direction: int


func _process(_delta):
	# bind player to mouse position
	position = get_global_mouse_position()
	if position.x > get_viewport().size.x / 2:
		shovel_direction = -1
		$Shovel.flip_h = true
		$Shovel.rotation_degrees = 315
		$Shovel.pivot_offset.x = 0
		$Shovel.pivot_offset.y = 15
		$Shovel.position.x = 0
		$Shovel.position.y = -15
		$SmashArea.position.x = 68
		$SmashArea.rotation_degrees = -15
	else:
		shovel_direction = 1
		$Shovel.flip_h = false
		$Shovel.rotation_degrees = 45
		$Shovel.pivot_offset.x = 100
		$Shovel.pivot_offset.y = 15
		$Shovel.position.x = -100
		$Shovel.position.y = -15
		$SmashArea.position.x = -68
		$SmashArea.rotation_degrees = 15


func _input(event):
	if event.is_action_pressed("smash"):
		$SmashTimer.start()
		smashed.emit()
	if event.is_action_pressed("pause"):
		paused.emit()


func _on_smash_timer_timeout():
	self.rotation_degrees = 0


func _on_smashed():
	self.rotation_degrees = -45 * shovel_direction
