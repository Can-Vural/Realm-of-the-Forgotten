extends CharacterBody2D

var IS_PLAYER_IN_INCREASE_AREA = false
var IS_PLAYER_IN_DECREASE_AREA = false

var IS_INCREASE_AVAILABLE = true
var IS_DECREASE_AVAILABLE = true


func _ready():
	$AnimatedSprite2D.play("campfire_animation")

func _physics_process(delta):
	increase_player_hp()
	decrease_player_hp()


func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		IS_PLAYER_IN_INCREASE_AREA = true

func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		IS_PLAYER_IN_INCREASE_AREA = false

func increase_player_hp():
	if IS_PLAYER_IN_INCREASE_AREA and not IS_PLAYER_IN_DECREASE_AREA:
		if IS_INCREASE_AVAILABLE:
			global.PLAYER_HEALTH += 15
			
			$increase_hp_cooldown.start()
			IS_INCREASE_AVAILABLE = false

func decrease_player_hp():
	if IS_PLAYER_IN_DECREASE_AREA:
		if IS_DECREASE_AVAILABLE:
			global.PLAYER_HEALTH -= 25
			
			$decrease_hp_cooldown.start()
			IS_DECREASE_AVAILABLE = false


func _on_increase_hp_cooldown_timeout():
	IS_INCREASE_AVAILABLE = true


func _on_decrease_hitbox_body_entered(body):
	if body.has_method("player"):
		IS_PLAYER_IN_DECREASE_AREA = true


func _on_decrease_hitbox_body_exited(body):
	if body.has_method("player"):
		IS_PLAYER_IN_DECREASE_AREA = false


func _on_decrease_hp_cooldown_timeout():
	IS_DECREASE_AVAILABLE = true
