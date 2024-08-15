extends Control

@export var player : Player

func _input(event):
	pass
	#if event.is_action_pressed("upgrade menu"):
		#get_tree().paused = not get_tree().paused
		#visible = not visible
	#if event is InputEventKey and event.is_pressed:
		#if event.keycode == KEY_SPACE:
			#$ColorRect2.size -= Vector2(5, 0)

func _on_damage_pressed():
	player.damage *= 1.5
	hide()
	get_tree().paused = false

func _on_attack_speed_pressed():
	if player.attack_speed > 0:
		player.attack_speed -= 0.1
		player.update_ros()
	hide()
	get_tree().paused = false

func _on_movement_speed_pressed():
	player.SPEED *= 1.2
	hide()
	get_tree().paused = false

func _on_attack_range_pressed():
	player.attack_range *= 1.1
	player.update_range()
	hide()
	get_tree().paused = false

func _on_exp_gain_pressed():
	Global.exp_gain *= 1.5
	hide()
	get_tree().paused = false
