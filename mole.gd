extends Area2D


const HIDETIME = 5
const DANCETIME = 6
const MIN_TIME = 2
const CRAWL_SPEED = 30


signal hit
signal shame


var threatened: bool
var exposed: bool
var hidetimer: Timer
var dancetimer: Timer
var crawltimer: Timer
var direction: int


func _ready():
	threatened = false
	exposed = false
	hidetimer = $HideTimer
	dancetimer = $DanceTimer
	crawltimer = $CrawlTimer
	init_timer(hidetimer, HIDETIME)


func _process(delta):
	position.y += CRAWL_SPEED * delta * direction
	

func _on_area_entered(_area:Area2D):
	threatened = true


func _on_area_exited(_area:Area2D):
	threatened = false


func _on_player_smashed():
	if threatened and exposed:
		threatened = false
		dancetimer.stop()
		descend(hit)
	else:
		shame.emit()


func _on_hide_timer_timeout():
	direction = -1
	crawltimer.start()


func _on_dance_timer_timeout():
	descend(shame)


func _on_crawl_timer_timeout():
	if direction == -1:  # mole ascended and now is dancing
		init_timer(dancetimer, DANCETIME)
	else:  # mole descended and now is hiding
		init_timer(hidetimer, HIDETIME)
	direction = 0  # stand still while hiding or dancing


func init_timer(timer:Timer, duration:int):
	timer.wait_time = randi() % duration + MIN_TIME
	timer.start()


func descend(cause:Signal):
	cause.emit()
	crawltimer.start()
	direction = 1


func _on_mole_hill_mole_exposed():
	exposed = true


func _on_mole_hill_mole_safe():
	exposed = false
