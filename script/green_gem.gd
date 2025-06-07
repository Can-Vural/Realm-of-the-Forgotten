extends CharacterBody2D

var PLAYER_IN_AREA = false

func _ready():
	$AnimatedSprite2D.play("green_gem_idle")


func _physics_process(delta):
	is_gem_taken()


func is_gem_taken():
	if PLAYER_IN_AREA:
		self.queue_free()


func _on_hitbox_body_entered(body):
	if body is Player:
		PLAYER_IN_AREA = true



func _on_hitbox_body_exited(body):
	if body is Player:
		PLAYER_IN_AREA = false
