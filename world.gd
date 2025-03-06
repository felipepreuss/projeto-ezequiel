extends Node3D

@onready var crosshair = $UI/Crosshair
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crosshair.position.x = get_viewport().size.x /2 - 36 # Replace with function body.
	crosshair.position.y = get_viewport().size.y /2 - 36

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
