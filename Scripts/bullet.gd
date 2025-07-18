extends Node2D
class_name Bullet

var dir: Vector2
var bullet_speed: int

func initialize(dir, bullet_speed):
	self.dir = dir
	self.bullet_speed = bullet_speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position += dir * delta * bullet_speed
