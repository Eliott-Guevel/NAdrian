extends Weapon
class_name Laser
var player_laser = load("res://Scenes/player_laser.tscn")
@onready var player = get_node("/root/Game/Player")
var laser_charging := false

func _init(parent_node):
	# need to add it to the scene tree in order to access signals, get_tree()...
	super(parent_node)

func _ready():
	cooldown = 2
	damage = 2

func update_cooldown(delta: float) -> void:
	#laser cooldown goes from 0.0 to cooldown
	if cooldown_counter < cooldown:
		cooldown_counter += delta

func attack():
	#charging laser
	#to prevent player from slowing down when laser isn't ready
	if(laser_charging == false):
		player.speed = 100
			#update_cooldown(delta)
		laser_charging = true
	
func _process(delta: float) -> void:
	if laser_charging:
		if(cooldown_counter >= cooldown):
			var pb = player_laser.instantiate()
			get_tree().current_scene.get_node("Projectiles").add_child(pb)
				
			# back to normal state
			player.speed = 200
			cooldown_counter = 0.0
			laser_charging = false
