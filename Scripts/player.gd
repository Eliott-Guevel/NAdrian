extends Node2D

@onready var hp_meter = get_node("/root/Game/CanvasLayer/HPMeter")

var invincible := false
@onready var invincibility_timer = $InvincibilityTimer

enum Stance {SWORD, LASER}
var current_stance: Stance
@onready var stance_meter = get_node("/root/Game/CanvasLayer/StanceMeter")

var weapon: Weapon
#var sword = preload("res://Scenes/Sword.tscn").instantiate()
#var laser = preload("res://Scenes/Laser.tscn").instantiate()
var sword = preload("res://Scripts/sword.gd").new(self)
var laser = preload("res://Scripts/laser.gd").new(self)

var graze_cooldown: float
const GRAZE_COOLDOWN := 0.3 # seconds
var graze_state: bool

@onready var projectiles = get_node("/root/Game/Projectiles")

var speed: int
var velocity := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	set_stance(Stance.SWORD)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_vector = Vector2.ZERO

	# movement
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		position += input_vector * speed * delta
	
	#stance change (need to only call it once every button press)
	if Input.is_action_just_pressed("stance_change"):
		if(stance_meter.value == 100.0):
			stance_meter.value = 0.0
			
			if(current_stance == Stance.SWORD):
				set_stance(Stance.LASER)
				
			elif(current_stance == Stance.LASER):
				set_stance(Stance.SWORD)
	
	# weapon action
	weapon.update_cooldown(delta)
	if Input.is_action_just_pressed("shoot"):
		weapon.attack()
	
	if graze_cooldown > 0:
		graze_cooldown -= delta
		
func take_damage():
	if invincible:
		return  # Ignore damage while invincible
		
	hp_meter.value -= 1
	
	start_invincibility()
	
	if(hp_meter.value == 0):
		die()
		
func start_invincibility():
	invincible = true
	invincibility_timer.start(0.5)  # Duration in seconds, e.g. 0.5
	# player can't graze when hit
	graze_state = false
	# clignotement sprite ?
	$Sprite2D.modulate = Color(1, 0, 0)

func _on_invincibility_timer_timeout() -> void:
	invincible = false
	# player can graze again after getting hit
	graze_state = true
	# stop clignotement ?
	$Sprite2D.modulate = Color(1, 1, 1)
		
func die():
	# screen goes red
	var background = get_node("/root/Game/Background")
	background.color = Color(1, 0, 0, 0)

func set_stance(stance):
	current_stance = stance
	
	if stance == Stance.SWORD:
		$Sprite2D.modulate = Color(1, 1, 1)
		speed = 200
		weapon = sword
		
	if stance == Stance.LASER:
		$Sprite2D.modulate = Color(0, 0.5, 1)
		speed = 100
		weapon = laser

func _on_graze_area_area_entered(area: Area2D) -> void:
	# collision mask 1
	if(current_stance == Stance.LASER):
		var enemy_bullet = area.get_parent()
		if enemy_bullet in projectiles.get_children():
			#if player isn't currently being hit
			if(graze_state == true):
				# cooldown on graze for same projectile
				if graze_cooldown <= 0:
					graze_cooldown = GRAZE_COOLDOWN
					stance_meter.value += 10
