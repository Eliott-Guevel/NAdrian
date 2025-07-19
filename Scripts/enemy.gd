extends Node2D

var current_pattern_scene: PackedScene
var current_pattern: BulletPattern

var bullet_pattern_simple: PackedScene = preload("res://Scenes/bullet_pattern_simple.tscn")
var simple_instance
var bullet_pattern_circle: PackedScene = preload("res://Scenes/bullet_pattern_circle.tscn")
var circle_instance

@export var health = 5
@onready var game = get_node("/root/Game")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pattern_start(bullet_pattern_simple)
	
func pattern_start(new_pattern_scene: PackedScene):
	set_pattern_scene(new_pattern_scene)
	add_child(current_pattern)
	current_pattern.fire()
	
func set_pattern_scene(new_pattern_scene: PackedScene):
	current_pattern_scene = new_pattern_scene
	current_pattern = new_pattern_scene.instantiate()
	
func _on_pattern_timer_timeout() -> void:
	current_pattern.queue_free()
	
	# when a PackedScene is instantiated, it becomes a Node2D here, so need to save current_pattern_scene
	if(current_pattern_scene == bullet_pattern_simple):
		set_pattern_scene(bullet_pattern_circle)
	elif(current_pattern_scene == bullet_pattern_circle):
		set_pattern_scene(bullet_pattern_simple)
	
	pattern_start(current_pattern_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#movement
	
	#rotate(0.5 * delta)
	#position.y += 200 * delta
	
func take_damage():
	#no need for i-frames since each weapon has a cooldown
	health -= 1
	
	# change color to indicate that the enemy has been hit
	$Sprite2D.modulate = Color(0, 0, 0)
	await get_tree().create_timer(0.5).timeout
	$Sprite2D.modulate = Color(1, 0, 0)
	
	if(health == 0):
		game.end()
