extends CharacterBody2D


var speed = 0
const maxSpeed = 200
const maxSprintSpeed = 280
var acceleration = 2400
var decceleration = 50
const JUMP_VELOCITY = -320.0
const meleePath = preload("res://melee_attack_player.tscn")
var melee
var cursorPosition
var attackDirection
var attackAngle
var meleePos
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var rotNode
var attackTimer: Timer
var canAttack: bool

func _ready():
	attackTimer = get_node("AttackTimer")
	canAttack = true
	meleePos = get_node("RotationNode/MeleePos")
	rotNode = get_node("RotationNode")

func _process(delta):
	cursorPosition = get_global_mouse_position()
	attackDirection = cursorPosition - global_position
	attackAngle = attackDirection.angle()
	rotNode.rotation = attackAngle
	
	if is_instance_valid(melee):
		melee.global_position = meleePos.global_position
		
func _physics_process(delta):
	if Game.playerHP < 1:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if (is_on_floor()):
		acceleration = 2400
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		acceleration = 1600
	
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		speed += acceleration * delta
		if speed > maxSpeed:
			speed = maxSpeed
		velocity.x = direction * speed
	else:
		speed = 0
		if speed < 0:
			speed = 0
		velocity.x = move_toward(velocity.x, 0, decceleration)
	move_and_slide()
	
	if Input.is_action_just_pressed("sec_fire"):
		meleeAttack()
	
func meleeAttack():
	if !canAttack:
		return
	melee = meleePath.instantiate()
	melee.rotation = attackAngle
	melee.global_position = meleePos.global_position
	get_tree().get_root().add_child(melee)
	attackTimer.start()
	canAttack = false
	


func _on_scene_loader_body_entered(body):
	if body.get_parent().name == "Player":
		get_tree().change_scene_to_file("main.tscn")


func _on_attack_timer_timeout():
	canAttack = true
