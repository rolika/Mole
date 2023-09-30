extends Area2D


const HIDETIME = 5
const DANCETIME = 6
const MIN_TIME = 2
const CRAWL_SPEED = 30


enum {STANDBY, EXPOSED, THREATENED, HARMED}


signal hit
signal shame


var state: Array
var hidetimer: Timer
var dancetimer: Timer
var direction: int
var safepos: float
var maxheight: float


func _ready():
	safepos = position.y
	maxheight = safepos - $TextureRect.get_size().y * self.get_scale().y
	state.append(STANDBY)
	hidetimer = $HideTimer
	dancetimer = $DanceTimer
	print(state)


func new_session():
	position.y = safepos
	state.append(HARMED)  # harmed state needed for the frist time
	remove(STANDBY)
	init_timer(hidetimer, HIDETIME)


func _on_hide_timer_timeout():
	if not state.has(HARMED):  # that's why harmed is needed at new session
		shame.emit()
	remove(HARMED)
	direction = -1


func _process(delta):
	if not state.has(STANDBY):
		position.y += CRAWL_SPEED * delta * direction
		if position.y > safepos:  # mole descended
			direction = 0
			position.y = safepos
			init_timer(hidetimer, HIDETIME)
		if position.y < maxheight:  # mole ascended
			direction = 0
			position.y = maxheight
			init_timer(dancetimer, DANCETIME)


func _on_mole_hill_mole_exposed():
	state.append(EXPOSED)


func _on_mole_hill_mole_safe():
	remove(EXPOSED)
	

func _on_area_entered(_area:Area2D):
	state.append(THREATENED)


func _on_area_exited(_area:Area2D):	
	remove(THREATENED)


func _on_player_smashed():
	if state.has(EXPOSED) and state.has(THREATENED):
		remove(THREATENED)
		state.append(HARMED)
		hit.emit()
		direction = 1


func _on_dance_timer_timeout():
	direction = 1


func init_timer(timer:Timer, duration:int):
	timer.wait_time = randi() % duration + MIN_TIME
	timer.start()


func remove(state_):
	var idx = state.find(state_)
	if idx > -1:
		state.remove_at(idx)	
