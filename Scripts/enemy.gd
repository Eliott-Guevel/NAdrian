extends Node2D

var bullet_pattern = preload("res://Scripts/bullet_pattern_simple.gd").new(self)
#@onready var player = get_parent().get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullet_pattern.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#rotate(0.5 * delta)
	#position.y += 200 * delta
