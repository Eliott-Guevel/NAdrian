extends BulletPattern

func _ready():
	fire_rate = 1
	super()

func fire():
	var b = enemy_bullet.instantiate()
	# scales the bullet and its hitbox
	b.scale.x = 20.0
	var hitbox = b.get_node("Area2D/CollisionShape2D")
	# do fun things with moving / random small hitbox placement on wide bullet :)
	# need to fix hitbox scaling, only on center currently
	#b.collisionshape.radius = $Sprite2D.texture.get_width()
	b.initialize(Vector2(0, 1), 400)
	var random = randf_range(-1.0, 1.0)
		#var b2 = enemy_bullet.instantiate()
		#b2.initialize(Vector2(0, -1), 400)
	b.position = Vector2(enemy.position.x + random * 10, enemy.position.y)
		#b2.position = Vector2(enemy.position.x + i * 10, enemy.position.y + 600)
		
	# add bullets as children of Projectiles
	get_tree().current_scene.get_node("Projectiles").add_child(b)
		#get_tree().current_scene.get_node("Projectiles").add_child(b2)
