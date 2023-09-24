extends Area2D


signal mole_exposed


func _on_area_entered(_area):
	print("Mole exposed.")
	mole_exposed.emit()
