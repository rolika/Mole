extends Node2D


const SCORE = 100  # score for each mole smashed
const MAX_SHAME = 10  # it's a shame if you let a mole go


signal game_over


var score: int
var shame: int
var miss: int
var moles: int


func _ready():
	randomize()
	score = 0
	shame = 0
	miss = 0
	moles = get_tree().get_nodes_in_group("moles").size()


func _on_mole_hit():
	score += SCORE
	$HUD.update_score(score)
	$HitSound.play()
	var hiscore = int($HUD/HiScoreValue.text)
	if score > hiscore:
		$HUD.update_hiscore(score)


func _on_mole_shame():
	shame += 1
	$HUD.update_shame(shame)
	if shame >= MAX_SHAME:
		game_over.emit()
		get_tree().call_group("moles", "stand_by")


func _on_hud_start_game():
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
