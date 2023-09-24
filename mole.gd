extends Area2D


const SCORE:int = 100
const MAX_SHAME:int = 10


var threatened: bool
var hidetimer
var dancetimer 

static var score = 0
static var shame = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	threatened = false
	hidetimer = $HideTimer
	dancetimer = $DanceTimer
	init_timer(hidetimer, 5)
	init_timer(dancetimer, 3)
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(_area):
	threatened = true


func _on_area_exited(_area):
	threatened = false


func _on_player_smashed():
	if threatened:
		hit()
	else:
		shame_()


func _on_hide_timer_timeout():
	show()
	init_timer(dancetimer, 3)


func _on_dance_timer_timeout():
	hide_mole()
	shame_()


func init_timer(timer:Timer, duration:int):
	timer.wait_time = randi() % duration + 1
	timer.start()


func hit():
	score += SCORE
	print("Score:", score)
	hide_mole()
	

func shame_():	
	shame += 1
	print("Shame:", shame)


func hide_mole():
	hide()	
	init_timer(hidetimer, 5)
