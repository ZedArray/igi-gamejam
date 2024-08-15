extends Node2D

@export var enemy_scene : PackedScene
@onready var spawnpath : PathFollow2D = $Player/Path2D/PathFollow2D

var enemy_spawns = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$"CanvasLayer/Exp".size.x = 0
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ratio : float = Global.player_exp * 0.84
	#print(ratio)
	$"CanvasLayer/Exp".size.x = ratio
	if Global.player_exp >= 500:
		Global.player_exp = 0
		$Player.health = 100
		get_tree().paused = true
		$"Upgrade Menu/Control".show()

	#if event is InputEventKey and event.is_pressed():
		#if event.keycode == KEY_SPACE:
			#get_tree().change_scene_to_file("res://main_scene.tscn")
	#if event.is_action_pressed("upgrade menu"):
		#$"Upgrade Menu".show()
		#get_tree().paused = true

func spawn_enemy():
	for i in range(0, enemy_spawns):
		var enemy = enemy_scene.instantiate()
		add_child(enemy)
		spawnpath.progress_ratio = randf()
		enemy.position = spawnpath.global_position

func death_scene():
	get_tree().paused = true
	$"Death screen".show()

func _on_spawn_timer_timeout():
	spawn_enemy()

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://main_scene.tscn")
