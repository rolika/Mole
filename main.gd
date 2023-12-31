extends Node2D


const SCORE = 100  # score for each mole smashed
const MAX_SHAME = 10  # it's a shame if you let a mole go
const SAVE_PATH = "user://save.hi"


signal game_over


var score: int
var shame: int
var miss: int
var moles: int


func _ready():
	await get_tree().create_timer(2.0).timeout
	$SplashScreen.hide()
	randomize()
	score = 0
	shame = 0
	miss = 0
	moles = get_tree().get_nodes_in_group("moles").size()
	if FileAccess.file_exists(SAVE_PATH):
		$HUD.update_hiscore(load_hiscore())


func _on_mole_hit():
	score += SCORE
	$HUD.update_score(score)
	$HitSound.play()
	var hiscore = int($HUD/HiScoreValue.text)
	if score > hiscore:
		$HUD.update_hiscore(score)
		save_hiscore()


func _on_mole_shame():
	shame += 1
	$HUD.update_shame(shame)
	if shame >= MAX_SHAME:
		game_over.emit()
		get_tree().call_group("moles", "stand_by")


func _on_hud_start_game():
	$SplashScreen.hide()
	_on_hud_new_game()
	get_tree().call_group("moles", "new_session")


func _on_mole_miss():
	miss += 1
	if miss > moles - 1:
		$MissedSound.play()


func _on_player_smashed():
	miss = 0


func _on_hud_new_game():	
	score = 0
	$HUD.update_score(score)
	shame = 0
	$HUD.update_shame(shame)
	get_tree().call_group("moles", "stand_by")


func save_hiscore():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(score)


func load_hiscore() -> int:
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	return file.get_var()
