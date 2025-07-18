extends "res://Scripts/bullet_pattern.gd"

func _init(parent_node):
	super(parent_node)
	fire_rate = 0.2
	
	self.timer = Timer.new()
	self.timer.wait_time = fire_rate
	self.timer.one_shot = false
	self.timer.connect("timeout", Callable(self, "fire"))
	parent_node.add_child(self.timer)

func start():
	timer.start()

func stop():
	timer.stop()
	timer.queue_free()

func fire():
	for i in range(10):
		var b = enemy_bullet.instantiate()
		b.initialize(Vector2(0, 1), 400)
		var b2 = enemy_bullet.instantiate()
		b2.initialize(Vector2(0, -1), 400)
		b.position = Vector2(enemy.position.x - i * 10, enemy.position.y)
		b2.position = Vector2(enemy.position.x + i * 10, enemy.position.y + 600)
	
		# add bullets as children of Projectiles
		get_tree().current_scene.get_node("Projectiles").add_child(b)
		get_tree().current_scene.get_node("Projectiles").add_child(b2)
