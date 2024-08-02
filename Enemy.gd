extends CharacterBody2D

const SPEED = 20
const JUMP_VELOCITY = -400.0

var health = 100

@onready var player = $"../Player"

func _physics_process(delta):
	if position.distance_to(player.position) >= 5:
		velocity = position.direction_to(player.position) * SPEED
	move_and_slide()

func hurt(damage):
	position -= position.direction_to(player.position) * 10
	health -= damage
	print(health)
	death_check()
	move_and_slide()

func death_check():
	if health <= 0:
		queue_free()
