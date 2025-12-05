@tool
extends Collider

@export var damage_amount: int
@export var explodes_on_hit: bool
@export var dies_on_hit: bool

signal damage_given(value: float)

func emit_damage_given(value: float):
	damage_given.emit(value)

func get_damage():
	return self.damage_amount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(_area: Area3D) -> void:
	pass
