extends CharacterBody2D

class_name Player

@export var SPEED = 30
@export var damage = 40
@export var attack_speed : float = 1.0
@export var attack_range = 1
@export var exp_gain = 10

@export var sword_animation : AnimatedSprite2D
@export var main : Node2D

var input : Vector2
var attacking = false
var attack_hold = false
var sword_size = 1

var health = 100
var player_exp = 0

func _input(event):
	#if event.is_action_pressed("attack"):
		#attack_hold = true
	#if event.is_action_released("attack"):
		#attack_hold = false
	if event.is_action_pressed("zoom_in"):
		$Camera2D.zoom += Vector2(0.1, 0.1)
	if event.is_action_pressed("zoom_out") and $Camera2D.zoom > Vector2(3, 3):
		$Camera2D.zoom -= Vector2(0.1, 0.1)
	#if event is InputEventKey and event.pressed:
		#if event.keycode == KEY_SPACE:
			#health = 0
			#check_for_death()
			#print(damage)
			#print(attack_speed)
			#print(SPEED)
			#print(attack_range)
			#print(exp_gain)
			
			#player_exp += 10
			#print(player_exp)
			#var ratio : float = player_exp * 0.84
			#print(ratio)
			#health -= 10
			#$"../CanvasLayer/ColorRect2".size.x = ratio
			
			#$AnimatedSprite2D.apply_scale(Vector2(1.2, 1.2))
			#$Area2D.apply_scale(Vector2(1.2, 1.2))
			#$ColorRect.size -= Vector2(10, 0)

func get_input():
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input.normalized()

func _physics_process(delta):
	var playerInput = get_input()
	
	position += playerInput * SPEED * delta
	
	if not attacking:
		$AnimatedSprite2D.look_at(get_global_mouse_position())
		$Area2D.look_at(get_global_mouse_position())
		if attack_hold:
			$AnimatedSprite2D.play()
			$"Attack Delay".start()
			attacking = true
	
	attack_hold = Input.is_action_pressed("attack")
	
	$ColorRect.size.x = 46 * health / 100.0
	move_and_slide()

func update_range():
	$AnimatedSprite2D.apply_scale(Vector2(attack_range, attack_range))
	$Area2D.apply_scale(Vector2(attack_range, attack_range))

func update_ros():
	$"Attack Cooldown".wait_time = attack_speed

func take_damage(damage):
	health -= damage
	check_for_death()

func check_for_death():
	if health <= 0:
		$"..".death_scene()

func _on_animated_sprite_2d_animation_finished():
	#attacking = false
	$"Attack Cooldown".start()
	pass

func _on_attack_delay_timeout():
	var enemies = $Area2D.get_overlapping_bodies()
	for i in enemies:
		i.hurt(damage)

func _on_attack_cooldown_timeout():
	attacking = false
