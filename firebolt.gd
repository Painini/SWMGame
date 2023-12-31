extends Node2D

var speed = 500
var animator
var direction = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	animator = get_node("AnimationPlayer")
	get_node("AnimatedSprite2D").play("fire")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	position += direction.normalized() * delta * speed


func _on_area_2d_body_entered(body):
	if body.is_in_group("walls") || body.is_in_group("enemy"):
		speed = 0
		animator.play("Hit")




func _on_area_2d_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.get_parent().HP -= 5
		animator.play("Hit")
		print("did damage")
	
