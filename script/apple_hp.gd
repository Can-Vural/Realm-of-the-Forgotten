extends CharacterBody2D

var APPLE_EATEN = false


func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	is_apple_gone()



func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		APPLE_EATEN = true
func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		APPLE_EATEN = false

func is_apple_gone():
	if APPLE_EATEN:
		global.PLAYER_HEALTH += 30
		self.queue_free()
