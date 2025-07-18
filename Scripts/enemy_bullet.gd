extends Bullet

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	# put collision code with player here (collision mask 2)
	area.get_parent().take_damage()
