extends CharacterBody2D

@export var SPEED = 45
var PLAYER_CHASE = false
var PLAYER = null

@export var HEALTH = 100
var IS_ENEMY_ALIVE = true
var PLAYER_IN_ATTACK_RANGE = false

var CAN_GET_DAMAGE = true

func _physics_process(delta):
	
	play_animation()
	player_chase()
	
	getting_damage_by_player()
	is_enemy_dead()
	


# (Movement) Functions to chase player
func _on_detection_area_body_entered(body):
	PLAYER = body
	PLAYER_CHASE = true
func _on_detection_area_body_exited(body):
	PLAYER = null
	PLAYER_CHASE = false
func player_chase():
	if not IS_ENEMY_ALIVE:
		return
	
	if PLAYER_CHASE:
		position += (PLAYER.position - position) / SPEED

func play_animation():
	var anim = $AnimatedSprite2D
	
	if not IS_ENEMY_ALIVE:
		return
	
	if PLAYER_CHASE:
		if HEALTH > 50:
			if global.PLAYER_CURRENT_DIRECTION == "idle":
				anim.play("idle")
			elif global.PLAYER_CURRENT_DIRECTION == "right":
				anim.flip_h = false
				anim.play("side_walk")
			elif global.PLAYER_CURRENT_DIRECTION == "left":
				anim.flip_h = true
				anim.play("side_walk")
			elif global.PLAYER_CURRENT_DIRECTION == "up":
				anim.play("back_walk")
			elif global.PLAYER_CURRENT_DIRECTION == "down":
				anim.play("front_walk")
		else:
			anim.play("front_scared")
	else:
		anim.play("idle")

# Combat Functions
func enemy():
	pass

## Getting Damage
func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		PLAYER_IN_ATTACK_RANGE = true
func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		PLAYER_IN_ATTACK_RANGE = false

func getting_damage_by_player():
	if PLAYER_IN_ATTACK_RANGE and global.PLAYER_IS_ATTACKING:
		if CAN_GET_DAMAGE:
			HEALTH -= 30
			
			$get_damage_cooldown.start()
			CAN_GET_DAMAGE = false
		
			print("slime health: ",HEALTH)
func _on_get_damage_cooldown_timeout():
	CAN_GET_DAMAGE = true

func is_enemy_dead():
	if HEALTH <= 0 and IS_ENEMY_ALIVE:
		IS_ENEMY_ALIVE = false
		
		$AnimatedSprite2D.play("death")
		$CollisionShape2D.disabled = true
		
		$death_animation.start()
func _on_death_animation_timeout():
	$death_animation.stop()
	self.queue_free()
