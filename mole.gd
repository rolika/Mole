extends Area2D


const HIDETIME = 5
const DANCETIME = 6
const MIN_TIME = 2


signal hit
signal shame


var threatened:bool
var hidetimer:Timer
var dancetimer:Timer


func _ready():
	threatened = false
	hidetimer = $HideTimer
	dancetimer = $DanceTimer
	init_timer(hidetimer, HIDETIME)
	init_timer(dancetimer, DANCETIME)
	hide()
	

func _on_area_entered(_area:Area2D):
	threatened = true


func _on_area_exited(_area:Area2D):
	threatened = false


func _on_player_smashed():
	if threatened and self.visible:
		hit.emit()
		hide_mole()
	else:
		shame.emit()


func _on_hide_timer_timeout():
	show()
	init_timer(dancetimer, DANCETIME)


func _on_dance_timer_timeout():
	shame.emit()
	hide_mole()


func init_timer(timer:Timer, duration:int):
	timer.wait_time = randi() % duration + MIN_TIME
	timer.start()


func hide_mole():
	hide()	
	init_timer(hidetimer, HIDETIME)
