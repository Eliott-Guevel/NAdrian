extends Node2D
@onready var stance_meter = $CanvasLayer/StanceMeter
@onready var enemy = $Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	# change color of stance_meter when it's full to Red
	if(stance_meter.value == 100.0):
		stance_meter.tint_progress = Color(1, 0, 0)
	#reset color
	else:
		stance_meter.tint_progress = Color(1, 1, 1)

#boss defeated
func end():
	enemy.hide()
