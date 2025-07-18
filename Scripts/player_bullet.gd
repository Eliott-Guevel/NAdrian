extends Bullet
@onready var player = get_node("/root/Game/Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dir = Vector2(0, -1)
	bullet_speed = 500
	position = player.global_position

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	# put collision code with player here
	pass
