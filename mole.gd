extends Area2D


signal hit
signal shame


var threatened:bool
var hidetimer:Timer
var dancetimer:Timer


func _ready():
	threatened = false
	hidetimer = $HideTimer
	dancetimer = $DanceTimer
	init_timer(hidetimer, 5)
	init_timer(dancetimer, 3)
	hide()
	

func _on_area_entered(_area:Area2D):
	threatened = true


func _on_area_exited(_area:Area2D):
	threatened = false


func _on_player_smashed():
	if threatened:
		hit.emit()
		hide_mole()
	else:
		shame.emit()


func _on_hide_timer_timeout():
	show()
	init_timer(dancetimer, 3)


func _on_dance_timer_timeout():
	shame.emit()
	hide_mole()


func init_timer(timer:Timer, duration:int):
	timer.wait_time = randi() % duration + 1
	timer.start()


func hide_mole():
	hide()	
	init_timer(hidetimer, 5)
