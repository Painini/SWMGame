extends Node2D
var direction = Vector2.ZERO
var animator

func _ready():
	animator = get_node("AnimationPlayer")
	animator.play("Reflect")
	
	
func _on_area_2d_area_entered(area):
	if (area.is_in_group("projectile")):
		area.get_parent().direction = get_global_mouse_position() - global_position
		area.get_parent().speed = 500
		animator.stop()
		animator.play("Reflect")
