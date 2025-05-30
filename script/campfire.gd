extends CharacterBody2D

var IS_PLAYER_IN_AREA = false
var IS_AVAILABLE = true


func _ready():
	$AnimatedSprite2D.play("campfire_animation")

func _physics_process(delta):
	increase_player_hp()


func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		IS_PLAYER_IN_AREA = true

func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		IS_PLAYER_IN_AREA = false

func increase_player_hp():
	if IS_PLAYER_IN_AREA:
		if IS_AVAILABLE:
			global.PLAYER_HEALTH += 15
			
			$increase_hp_cooldown.start()
			IS_AVAILABLE = false


func _on_increase_hp_cooldown_timeout():
	IS_AVAILABLE = true
