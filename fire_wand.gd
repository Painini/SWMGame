extends Node2D

var firebolt
var hitbox
var attackTimer: Timer
var canAttack: bool
var cursorPosition
var attackDirection
var attackAngle
var attackPos
const fireboltPath = preload("res://firebolt.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	attackTimer = get_node("AttackTimer")
	canAttack = true
	attackPos = get_node("AttackPos")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#Rotates wand to cursor position
	cursorPosition = get_global_mouse_position()
	attackDirection = cursorPosition - global_position
	attackAngle = attackDirection.angle()
	rotation = attackAngle


func _physics_process(delta):
	if Input.is_action_just_pressed("fire"):
		if !canAttack:
			return
		fire()

func _on_attack_timer_timeout():
	canAttack = true
		
		
		
func fire():
	firebolt = fireboltPath.instantiate()
	firebolt.rotation = attackAngle
	firebolt.direction = attackDirection
	firebolt.global_position = attackPos.global_position
	get_tree().get_root().add_child(firebolt)
	attackTimer.start()
	canAttack = false	
