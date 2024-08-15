extends CharacterBody2D

const SPEED = 1000
const JUMP_VELOCITY = -400.0

var health = 100
var can_attack = true

@onready var player : Player = $"../Player"


func _physics_process(delta):
	if position.distance_to(player.position) >= 5:
		velocity = position.direction_to(player.position) * SPEED * delta
	
	if $"Stuck Check".has_overlapping_bodies():
		#print("stuck")
		position -= Vector2(0, -20)
	
	if $Hitbox.has_overlapping_bodies() and can_attack:
		var p = $Hitbox.get_overlapping_bodies()
		if p[0].name == "Player":
			p[0].take_damage(2)
			$"Damage Timer".start()
			can_attack = false
			#print("ballsaaa")
	
	if velocity.x >= 0:
		$Sprite2D.flip_h = true
	
	elif velocity.x < 0:
		$Sprite2D.flip_h = false
	
	move_and_slide()

func hurt(damage):
	var test = $Sprite2D.modulate
	$Sprite2D.modulate = Color.RED
	$"Hurt Timer".start()
	position -= position.direction_to(player.position) * 10
	health -= damage
	#print(health)
	death_check()
	move_and_slide()

func death_check():
	if health <= 0:
		queue_free()
		Global.gain_exp()

func _on_hurt_timer_timeout():
	#print("aa")
	$Sprite2D.modulate = Color.WHITE

func _on_damage_timer_timeout():
	can_attack = true
