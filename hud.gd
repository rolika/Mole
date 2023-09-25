extends CanvasLayer


signal start_game


func update_score(score):
	$ScoreValue.text = score
	

func update_shame(shame):
	$ShameBar.value = shame


func show_game_over():
	$Title.text = "Game\nOver"
	$Title.show()	
	await get_tree().create_timer(1.0).timeout
	$Title.text ="Malicious\nMoles"
	$StartButton.show()


func _on_start_button_pressed():
	$StartButton.hide()
	$ScoreValue.text = "0"
	$ShameBar.value = 0
	$Title.text = "Get\nready!"
	await get_tree().create_timer(1.0).timeout
	$Title.hide()
	start_game.emit()
