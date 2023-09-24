extends Area2D


signal mole_exposed
signal mole_safe


func _on_area_entered(_area):
	print("Mole exposed.")
	mole_exposed.emit()


func _on_area_exited(_area):
	mole_safe.emit()
