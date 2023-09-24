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
var direction: int
var safepos: float
var maxheight: float


func _ready():
	safepos = position.y
	maxheight = safepos - $TextureRect.get_size().y * self.get_scale().y
	threatened = false
	exposed = false
	hidetimer = $HideTimer
	dancetimer = $DanceTimer
	init_timer(hidetimer, HIDETIME)


func _process(delta):
	position.y += CRAWL_SPEED * delta * direction
	if position.y > safepos:  # mole descended
		direction = 0
		position.y = safepos
		init_timer(hidetimer, HIDETIME)
	if position.y < maxheight:  # mole ascended
		direction = 0
		position.y = maxheight
		init_timer(dancetimer, DANCETIME)
	

func _on_area_entered(_area:Area2D):
	threatened = true


func _on_area_exited(_area:Area2D):
	threatened = false


func _on_player_smashed():
	if threatened and exposed:
		threatened = false
		hit.emit()
		direction = 1


func _on_hide_timer_timeout():
	direction = -1


func _on_dance_timer_timeout():
	shame.emit()
	direction = 1


func init_timer(timer:Timer, duration:int):
	timer.wait_time = randi() % duration + MIN_TIME
	timer.start()


func _on_mole_hill_mole_exposed():
	exposed = true


func _on_mole_hill_mole_safe():
	exposed = false
