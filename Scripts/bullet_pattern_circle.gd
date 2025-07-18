extends BulletPattern

func _ready():
	fire_rate = 1
	super()

func fire():
	for i in range(10):
		#var b = enemy_bullet.instantiate()
		#b.initialize(Vector2(0, 1), 800)
		var b2 = enemy_bullet.instantiate()
		b2.scale.x = 5.0
		b2.initialize(Vector2(0, 1), 1000)
		var random = randf_range(-1.0, 1.0)
		#b.position = Vector2(enemy.position.x - i * 10, enemy.position.y)
		b2.position = Vector2(enemy.position.x + random * i * 100, enemy.position.y - 1000)
	
		# add bullets as children of Projectiles
		#get_tree().current_scene.get_node("Projectiles").add_child(b)
		get_tree().current_scene.get_node("Projectiles").add_child(b2)
