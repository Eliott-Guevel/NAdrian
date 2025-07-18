extends Node2D
class_name BulletPattern

# time between shots
@export var fire_rate: float
var fire_timer: Timer
var enemy_bullet = load("res://Scenes/enemy_bullet.tscn")
@onready var enemy = get_tree().current_scene.get_node("Enemy")
@onready var player = get_tree().current_scene.get_node("Player")
@onready var collision_shape = $Area2D/CollisionShape2D

func _ready():
	fire_timer = Timer.new()
	fire_timer.wait_time = fire_rate
	fire_timer.autostart = true
	fire_timer.one_shot = false
	fire_timer.timeout.connect(fire)
	add_child(fire_timer)

	#fire()
	
func fire():
	pass
