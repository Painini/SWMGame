extends CharacterBody2D
var player
var speed = 150
var chase = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var HP = 10
var collisionWorld
var collisionPlayer

func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	collisionWorld = get_node("CollisionShape2D")
	collisionPlayer = get_node("PlayerCollision/CollisionShape2D")
	
func _physics_process(delta):
	if HP < 1:
		death()
	velocity.y += gravity * delta
	if chase == true :
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Walk")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
			
		else:	
			
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * speed
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0	
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		
		
func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 3
	
	
	
func death():
	chase = false
	collisionWorld.disabled = true
	collisionPlayer.disabled = true
	gravity = 0
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
		


func _on_player_remember_body_exited(body):
	if body.name == "Player":
		chase = false

