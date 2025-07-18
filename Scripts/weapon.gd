extends Node2D
class_name Weapon

@export var damage: int
@export var swing_speed: float
@export var cooldown: float
var cooldown_left: float = 0.0
@onready var stance_meter = get_node("/root/Game/CanvasLayer/StanceMeter")

func _init(parent_node):
	# need to add it to the scene tree in order to access signals, get_tree()...
	parent_node.add_child(self)

func attack():
	if cooldown_left <= 0.0:
		cooldown_left = cooldown
		do_attack()

func do_attack():
	pass
		
func update_cooldown(delta: float) -> void:
	if cooldown_left > 0.0:
		cooldown_left -= delta
