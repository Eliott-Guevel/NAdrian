extends Weapon

var rect_width: float = 128
var rect_height: float = 128
var rect_color: Color = Color.RED

var draw_attack_rect: bool = false
var draw_rect_local: Rect2
var frozen_rect_position: Vector2
var frozen_rect_size: Vector2
var attack_frozen := false

var damage_zone_duration := 0.3 # seconds
var damage_zone_timer := 0.0
var damage_dealt := false # Need to only inflict damage once, not for every frame of the parry
@onready var projectiles = get_node("/root/Game/Projectiles")
@onready var enemy = get_node("/root/Game/Enemy")
@onready var enemy_hitbox = enemy.get_node("HitboxArea/Hitbox")

func _init(parent_node):
	# need to add it to the scene tree in order to access signals, get_tree()...
	super(parent_node)

func _ready():
	cooldown = 1
	damage = 1
	swing_speed = 1

func update_cooldown(delta: float) -> void:
	# sword cooldown goes from cooldown (value) to 0.0
	if cooldown_counter > 0.0:
		cooldown_counter -= delta

func attack():
		if cooldown_counter <= 0.0:
			# reset cooldown after attack
			cooldown_counter = cooldown
			
			var player_pos = get_parent().global_position

			# Lock the rect position and size
			frozen_rect_position = player_pos + Vector2(-rect_width / 2, -rect_height)
			frozen_rect_size = Vector2(rect_width, rect_height)

			# Use the frozen values for drawing and hit detection
			var world_rect := Rect2(frozen_rect_position, frozen_rect_size)
			draw_rect_local = Rect2(world_rect.position - global_position, world_rect.size)
			draw_attack_rect = true
			damage_zone_timer = damage_zone_duration
			queue_redraw()

func _process(delta):
	if damage_zone_timer > 0:
		damage_zone_timer -= delta
		
		# Define world-space rect
		var world_rect = Rect2(frozen_rect_position, frozen_rect_size)
		
		# Inflict dmg to boss inside damage zone
		if(damage_dealt == false):
			var enemy_hitbox_size = enemy_hitbox.shape.size  # Vector2
			var top_left = enemy_hitbox.global_position - (enemy_hitbox_size * 0.5)
			var enemy_hitbox_rect = Rect2(top_left, enemy_hitbox_size)
			if world_rect.intersects(enemy_hitbox_rect):
				enemy.take_damage()
				damage_dealt = true

		# Delete bullets inside attack zone
		for bullet in projectiles.get_children():
			if world_rect.has_point(bullet.global_position):
				stance_meter.value += 50
				bullet.queue_free()

		# End of active zone time
		if damage_zone_timer <= 0:
			draw_attack_rect = false
			queue_redraw()
			damage_dealt = false

func _draw():
	if draw_attack_rect:
		draw_rect(draw_rect_local, rect_color, false, 2.0)
