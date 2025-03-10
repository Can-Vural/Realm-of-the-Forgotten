extends Node2D


func _ready():
	pass

func _process(delta):
	change_scene()


# Scene Change Functions
func _on_scene_trigger_body_entered(body):
	if body is Player:
		global.PLAYER_ON_SCENE_TRIGGER = true

func change_scene():
	if global.PLAYER_ON_SCENE_TRIGGER:
		get_tree().change_scene_to_file("res://scene/main_scenes/world.tscn")
		global.PLAYER_ON_SCENE_TRIGGER = false
