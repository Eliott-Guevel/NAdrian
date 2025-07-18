extends Weapon
class_name Laser
var player_bullet = load("res://Scenes/player_bullet.tscn")

func _init(parent_node):
	# need to add it to the scene tree in order to access signals, get_tree()...
	super(parent_node)

func _ready():
	cooldown = 2
	damage = 2

func do_attack():
	var pb = player_bullet.instantiate() 
	#add_child(pb)
	get_tree().current_scene.get_node("Projectiles").add_child(pb)
