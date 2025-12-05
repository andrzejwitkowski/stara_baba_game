@tool
extends Collider

class_name HurtBox

signal died
signal damage_taken(amount: int)

@export_category("Hurt Receiver")
@export var kills_paranet_on_death: bool = true
@export var dies_on_single_impact: bool = false
@export var max_health: int = 100


var current_health: int:
	get: return current_health
	set(value):
		current_health = value
		if current_health < 0:
			current_health = 0
	
func _ready() -> void:
	super()
	current_health = max_health
	
func take_damage(amount: int) -> void:
	if amount <=0 : return
	current_health -= amount
	damage_taken.emit(amount)
	
	if current_health <= 0:
		die()
	
func take_hit(amount: int) -> void:
	GrannyUtils.print_with_parent(self," HurtBox take_hit")
	if dies_on_single_impact:
		GrannyUtils.print_with_parent(self," HurtBox dies_on_single_impact")
		take_damage(current_health + 1)
	else:
		take_damage(amount)
	
func die() -> void:
	died.emit()
	if kills_paranet_on_death:
		super()
	
func _on_area_entered(area: Area3D) -> void:
	GrannyUtils.print_with_parent(self," HurtBox _on_area_entered")
	if area is DamageCollider:
		GrannyUtils.print_with_parent(self," HurtBox _on_area_entered")
		take_hit(area.get_damage())
