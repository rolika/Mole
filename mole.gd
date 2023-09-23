extends Area2D


signal threatened(area)
signal safe(area)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area):
	threatened.emit(area)


func _on_area_exited(area):
	safe.emit(area)
