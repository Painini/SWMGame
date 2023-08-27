extends Node2D

var firebolt
var hitbox
var attackTimer: Timer
var canAttack: bool
var cursorPosition
var attackDirection
var collisionAngle
var speed


# Called when the node enters the scene tree for the first time.
func _ready():
	attackTimer = get_node("AttackTimer")
	canAttack = true
	speed = 50
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#Rotates wand to cursor position
	cursorPosition = get_global_mouse_position()
	attackDirection = cursorPosition - global_position
	collisionAngle = attackDirection.angle()
	rotation = collisionAngle
	
		
		
		
		
	if Input.is_action_just_pressed("fire"):
		if !canAttack:
			return
		attackTimer.start()
		canAttack = false	



func _on_attack_timer_timeout():
	canAttack = true


func _on_lightning_attack_area_entered(area):
	if area.name == "Hurtbox":
		area.get_parent().HP -= 5
		
		
		
		
	
