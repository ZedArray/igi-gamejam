extends CharacterBody2D

const SPEED = 100
const ACCEL = 10

var input : Vector2
var attacking = false

func _input(event):
	if event.is_action_pressed("attack"):
		$AnimatedSprite2D.play()

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
	
	if Input.is_action_just_pressed("attack") and not attacking:
		attacking = true
		$"Attack Delay".start()
	
	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	attacking = false

func _on_attack_delay_timeout():
	var enemies = $Area2D.get_overlapping_bodies()
	for i in enemies:
		i.hurt(50)
