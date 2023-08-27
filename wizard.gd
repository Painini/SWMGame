extends CharacterBody2D
var player
var HP = 10
var seesPlayer
const fireboltPath = preload("res://enemy_firebolt.tscn")
var firebolt
var attackDirection
var attackAngle
var canAttack
var attackTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	player = get_node("../../Player/Player")
	seesPlayer = false
	canAttack = true
	attackTimer = get_node("AttackTimer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	attackDirection = player.position - global_position
	attackAngle = attackDirection.angle()
	
	if seesPlayer:
		if canAttack:
			fire()
			
func _process(_delta):
	if HP < 1:
		death()
		
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		seesPlayer = true
		print("Seeing Player")

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		seesPlayer = false
		
func _on_attack_timer_timeout():
	canAttack = true

func death():
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()	
	
func fire():
	firebolt = fireboltPath.instantiate()
	firebolt.rotation = attackAngle
	firebolt.direction = attackDirection
	firebolt.global_position = global_position
	get_tree().get_root().add_child(firebolt)
	attackTimer.start()
	canAttack = false	
