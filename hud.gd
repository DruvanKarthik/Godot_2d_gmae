extends CanvasLayer
signal start_game

func update_score(score):
	$ScoreLable.text = str(score)
func show_message(text):
	$MessageLable.text  = text
	$MessageLable.show()
	$MessageTimer.start()
func show_game_over():
	show_message("Game Over")
	await($MessageTimer)
	$MessageLable.text = "Doge the creeps"
	$MessageLable.show()
	await(get_tree().create_timer(1.0))
	$Button.show()

func _on_button_pressed():
	$Button.hide()
	emit_signal("start_game")


func _on_message_timer_timeout():
	$MessageLable.hide()
