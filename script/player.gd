extends CharacterBody2D

@export var SPEED = 50
var isPressed = false

var ENEMY_ATTACK_COOLDOWN = true
var ENEMY_IN_ATTACK_RANGE = false
var ANIMATION_PLAYING = false

func _physics_process(delta):
	
	movement()
	play_animation()
	
	attack()
	getting_damage_by_enemy()
	is_player_dead()
	


# Movement Functions
func movement():
	
	if ANIMATION_PLAYING:
		return
	
	if Input.is_action_pressed("ui_right"):
		isPressed = true
		global.PLAYER_CURRENT_DIRECTION = "right"
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		isPressed = true
		global.PLAYER_CURRENT_DIRECTION = "left"
		velocity.x = -SPEED
	elif Input.is_action_pressed("ui_up"):
		isPressed = true
		global.PLAYER_CURRENT_DIRECTION = "up"
		velocity.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		isPressed = true
		global.PLAYER_CURRENT_DIRECTION = "down"
		velocity.y = SPEED
	else:
		isPressed = false
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
func play_animation():
	
	var anim = $AnimatedSprite2D
	
	if ANIMATION_PLAYING:
		return
	
	if global.PLAYER_CURRENT_DIRECTION=="right":
		anim.flip_h = false
		anim.play("side_walk")
		if not isPressed:
			anim.play("side_idle")
	
	elif global.PLAYER_CURRENT_DIRECTION=="left":
		anim.flip_h = true
		anim.play("side_walk")
		if not isPressed:
			anim.play("side_idle")
	
	elif global.PLAYER_CURRENT_DIRECTION=="up":
		anim.play("back_walk")
		if not isPressed:
			anim.play("back_idle")
	
	elif global.PLAYER_CURRENT_DIRECTION=="down":
		anim.play("front_walk")
		if not isPressed:
			anim.play("front_idle")


# Combat Functions
func player():
	pass

## Getting Damage
func _on_hitbox_body_entered(body):
	if body.has_method("enemy"):
		ENEMY_IN_ATTACK_RANGE = true
func _on_hitbox_body_exited(body):
	if body.has_method("enemy"):
		ENEMY_IN_ATTACK_RANGE = false 

func getting_damage_by_enemy():
	if ENEMY_IN_ATTACK_RANGE and ENEMY_ATTACK_COOLDOWN:
		global.PLAYER_HEALTH -= 20
		$enemy_attack_cooldown.start()
		
		ENEMY_ATTACK_COOLDOWN = false
		
		print("--player health: ",global.PLAYER_HEALTH)
func is_player_dead():
	if global.PLAYER_HEALTH <= 0:
		self.queue_free()
		
		print("the finish line of this life is Death!")
func _on_enemy_attack_cooldown_timeout():
	ENEMY_ATTACK_COOLDOWN = true


## Attacking
func attack():
	var anim = $AnimatedSprite2D
	
	if isPressed:
		return
	
	if Input.is_action_just_pressed("attack_E"):
		
		ANIMATION_PLAYING = true
		global.PLAYER_IS_ATTACKING = true
		
		if global.PLAYER_CURRENT_DIRECTION == "right":
			anim.play("side_attack")
	
		elif global.PLAYER_CURRENT_DIRECTION == "left":
			anim.flip_h = true
			anim.play("side_attack")
	
		elif global.PLAYER_CURRENT_DIRECTION == "up":
			anim.flip_h = true
			anim.play("back_attack")
	
		elif global.PLAYER_CURRENT_DIRECTION == "down":
			anim.flip_h = true
			anim.play("front_attack")
		
		$player_attack_cooldown.start()
func _on_player_attack_cooldown_timeout():
	$player_attack_cooldown.stop()
	
	ANIMATION_PLAYING = false
	global.PLAYER_IS_ATTACKING = false
