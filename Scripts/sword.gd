extends Weapon

var rect_width: float = 128
var rect_height: float = 64
var rect_color: Color = Color.RED

var draw_attack_rect: bool = false
var draw_rect_local: Rect2
var frozen_rect_position: Vector2
var frozen_rect_size: Vector2
var attack_frozen := false

var damage_zone_duration := 0.2 # seconds
@onready var projectiles = get_node("/root/Game/Projectiles")

func _init(parent_node):
	# need to add it to the scene tree in order to access signals, get_tree()...
	super(parent_node)

func _ready():
	cooldown = 1
	damage = 1
	swing_speed = 1

func do_attack():
	var player_pos = get_parent().global_position

	# Lock the rect position and size
	frozen_rect_position = player_pos + Vector2(-rect_width / 2, -rect_height)
	frozen_rect_size = Vector2(rect_width, rect_height)

	# Use the frozen values for drawing and hit detection
	var world_rect := Rect2(frozen_rect_position, frozen_rect_size)
	draw_rect_local = Rect2(world_rect.position - global_position, world_rect.size)
	draw_attack_rect = true
	queue_redraw()

	# Delete bullets inside attack zone
	for bullet in projectiles.get_children():
		if world_rect.has_point(bullet.global_position):
			stance_meter.value += 5
			bullet.queue_free()

	# Hide the rectangle after damage_zone_duration seconds
	await get_tree().create_timer(damage_zone_duration).timeout
	draw_attack_rect = false
	queue_redraw()

func _draw():
	if draw_attack_rect:
		draw_rect(draw_rect_local, rect_color, false, 2.0)
