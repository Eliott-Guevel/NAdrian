extends Node2D
class_name BulletPattern

# time between shots
@export var fire_rate: float
var enemy_bullet = load("res://Scenes/enemy_bullet.tscn")
var timer: Timer
@onready var enemy = get_tree().current_scene.get_node("Enemy")
@onready var player = get_tree().current_scene.get_node("Player")

func _init(parent_node):
	# need to add it to the scene tree in order to access signals, get_tree()...
	parent_node.add_child(self)

func start():
	#timer.start()
	pass

func stop():
	pass
	#timer.stop()
	#timer.queue_free()
