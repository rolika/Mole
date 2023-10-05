extends CanvasLayer


signal start_game


var format_score = "%06d"


func update_score(score):
	$ScoreValue.text = format_score % score
	

func update_shame(shame):
	$ShameBar.value = shame


func _on_start_button_pressed():
	$StartButton.hide()
	$ScoreValue.text = format_score % 0
	$ShameBar.value = 0
	$Title.text = "Get\nready!"
	await get_tree().create_timer(1.0).timeout
	$Title.hide()
	start_game.emit()
	

func _on_main_game_over():
	$Title.text = "Game\nOver"
	$Title.show()	
	await get_tree().create_timer(2.0).timeout
	$Title.text ="Malicious\nMoles"
	$StartButton.show()
