@tool
extends Collider

class_name DamageCollider

@export_category("Damage")
@export var damage_amount: int = 10
@export var explodes_on_hit: bool = true
@export var dies_on_hit: bool = true

signal damage_given(value: int)

func emit_damage_given(value: int):
	damage_given.emit(value)

func get_damage():
	return self.damage_amount

func apply_impact_effect():
	emit_damage_given(damage_amount)
	if dies_on_hit:
		GrannyUtils.print_with_parent(self, "DamageCollider dies_on_hit()")
		die()
	if explodes_on_hit:
		GrannyUtils.print_with_parent(self, "DamageCollider explodes_on_hit()")

func _on_area_entered(_area: Area3D) -> void:
	GrannyUtils.print_with_parent(self, "DamageCollider _on_area_entered()")
	apply_impact_effect()
