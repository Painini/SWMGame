extends Node2D

var animator
# Called when the node enters the scene tree for the first time.
func _ready():
	animator = get_node("AnimationPlayer")
	animator.play("Attack")


#Prob use animatorplayer on each enemy to do a "hit" animation
func _on_area_2d_area_entered(area):
	if (area.is_in_group("hurtbox")):
		area.get_parent().HP -= 5
		animator.stop()
		animator.play("Hit")
