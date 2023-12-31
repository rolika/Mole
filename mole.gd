extends Area2D


const HIDETIME = 3
const DANCETIME = 3
const MIN_TIME = 1
const CRAWL_SPEED = 100


enum {STANDBY, EXPOSED, THREATENED, HARMED}


signal hit
signal shame
signal miss


var state: Array
var hidetimer: Timer
var dancetimer: Timer
var kaboomtimer: Timer
var direction: int
var safepos: float
var maxheight: float
var kaboom: Array[TextureRect]


func _ready():
	safepos = position.y
	maxheight = safepos - 64
	hidetimer = $HideTimer
	dancetimer = $DanceTimer
	kaboomtimer = $KaboomTimer
	kaboom = [$Bang, $Boom, $Pow]
	stand_by()


func stand_by():
	position.y = safepos
	state.clear()
	apply(STANDBY)
	hidetimer.stop()
	dancetimer.stop()
	hide_kaboom()
	$StarsSprite.hide()


func hide_kaboom():
	$Bang.hide()
	$Boom.hide()
	$Pow.hide()	


func new_session():
	remove(STANDBY)
	hide_kaboom()
	$StarsSprite.hide()
	init_timer(hidetimer, HIDETIME)


func _on_hide_timer_timeout():
	direction = -1
	$StarsSprite.hide()
	$AnimatedSprite2D.play("climb")


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
			$AnimatedSprite2D.play("dance")


func _on_mole_hill_mole_exposed():
	apply(EXPOSED)


func _on_mole_hill_mole_safe():
	$StarsSprite.hide()
	$StarsSprite.stop()
	remove(EXPOSED)
	if not (state.has(HARMED) or state.has(STANDBY)):
		shame.emit()
	remove(HARMED)
	

func _on_area_entered(_area:Area2D):
	apply(THREATENED)


func _on_area_exited(_area:Area2D):
	remove(THREATENED)


func _on_player_smashed():
	if state.has(EXPOSED) and state.has(THREATENED) and not state.has(HARMED):
		remove(THREATENED)
		apply(HARMED)
		kaboom[randi() % len(kaboom)].show()
		$StarsSprite.show()
		$StarsSprite.play("stars")
		kaboomtimer.start()
		hit.emit()
		direction = 1
	else:
		miss.emit()


func _on_dance_timer_timeout():
	direction = 1
	$AnimatedSprite2D.play("climb")


func init_timer(timer:Timer, duration:int):
	timer.wait_time = randi() % duration + MIN_TIME
	timer.start()


func apply(state_):
	var idx = state.find(state_)
	if idx < 0:
		state.append(state_)


func remove(state_):
	var idx = state.find(state_)
	if idx > -1:
		state.remove_at(idx)	


func _on_kaboom_timer_timeout():
	hide_kaboom()
