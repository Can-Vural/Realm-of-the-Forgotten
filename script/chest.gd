extends CharacterBody2D

@export var green_gem_scene : PackedScene = preload("res://scene/green_gem.tscn")

var PLAYER_IN_RANGE = false
var CHEST_OPENED = false

func _ready():
	$AnimatedSprite2D.play("chest_idle")

func _physics_process(delta):
	open()


func open():
	
	var anim = $AnimatedSprite2D
	
	if CHEST_OPENED:
		opened()
	
	if not CHEST_OPENED and PLAYER_IN_RANGE and global.CAVE_CHEST_KEY_TAKEN:
		if Input.is_action_just_pressed("interact_Q"):
			
			anim.play("chest_opening")
			CHEST_OPENED = true
			
			$animation_timer.start()
			
			if green_gem_scene:
				var green_gem = green_gem_scene.instantiate()
				var spawn_position = global_position + Vector2.DOWN * 15
				green_gem.global_position = spawn_position
				get_parent().add_child(green_gem)

func opened():
	$AnimatedSprite2D.play("chest_opened")


func _on_animation_timer_timeout():
	$animation_timer.stop()


func _on_hitbox_body_entered(body):
	if body is Player:
		PLAYER_IN_RANGE = true


func _on_hitbox_body_exited(body):
	if body is Player:
		PLAYER_IN_RANGE = false
