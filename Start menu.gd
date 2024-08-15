extends CanvasLayer

func _on_button_pressed():
	hide()
	get_tree().paused = false
