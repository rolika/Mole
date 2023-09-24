extends Node2D


const SCORE = 100  # score for each mole smashed
const MAX_SHAME = 10  # it's a shame if you let a mole go or miss it


var score = 0
var shame = 0


func _ready():
	randomize()


func _process(_delta):
	pass


func _on_mole_hit():
	score += SCORE
	print("Score:", score)


func _on_mole_shame():
	shame += 1
	print("Shame:", shame)
