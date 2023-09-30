extends Node2D


const SCORE = 100  # score for each mole smashed
const MAX_SHAME = 10  # it's a shame if you let a mole go or miss it


var score
var shame


func _ready():
	randomize()
	score = 0
	shame = 0


func _on_mole_hit():
	score += SCORE
	$HUD.update_score(score)


func _on_mole_shame():
	shame += 1
	$HUD.update_shame(shame)


func _on_hud_start_game():
	score = 0
	shame = 0
	get_tree().call_group("moles", "new_session")
