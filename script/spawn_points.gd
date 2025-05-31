extends Node2D

@export var enemy : PackedScene = preload("res://scene/enemy.tscn")
@onready var timer : Timer = $spawn_point_timer

var spawn_points: Array = []

var max_enemy_number = 5
var enemy_count = 0

func _ready():
	collect_spawn_positions()
	randomize_spawn_timer()

func collect_spawn_positions():
	for child in get_children():
		if child is Marker2D:
			spawn_points.append(child.global_position)

func spawn_enemy():
	
	if enemy == null:
		print("ERROR: Enemy scene is not assigned")
		
		return
	
	if spawn_points.is_empty():
		return
	
	var enemy = enemy.instantiate()
	var random_spawn_point = spawn_points.pick_random()
	
	enemy.global_position = random_spawn_point
	
	enemy.tree_exiting.connect(_on_enemy_despawn)
	
	get_tree().current_scene.add_child(enemy)
	enemy_count += 1


func _on_spawn_point_timer_timeout():
	if enemy_count < max_enemy_number:
		spawn_enemy()
	
	randomize_spawn_timer()


func _on_enemy_despawn():
	enemy_count -= 1


func randomize_spawn_timer():
	timer.wait_time = randf_range(3, 10)
	timer.start()
