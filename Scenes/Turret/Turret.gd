extends Node3D

class_name Turret

const TURRET_BULLET = preload("res://Scenes/Turret/TurretBullet.tscn")

@onready var link_player: LinkPlayer = $LinkPlayer
@onready var effect: AudioStreamPlayer3D = $Effect
@onready var shoot_timer: Timer = $ShootTimer
@onready var pivot: Node3D = $Pivot
@onready var shoot_point: Marker3D = $Pivot/ShootPoint

func _process(delta: float) -> void:
	if !link_player.granny:
		return
	
	var flat_position: Vector3 = link_player.granny_pos_set_y(global_position.y)
	
	if !link_player.granny_too_close(global_position) and !shoot_timer.is_stopped():
		pivot.look_at(flat_position, Vector3.UP)


func _on_player_detection_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	shoot_timer.start()


func _on_player_detection_body_shape_exited(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	shoot_timer.stop()


func _on_shoot_timer_timeout() -> void:
	shoot()
	
func shoot():
	var bullet = TURRET_BULLET.instantiate()
	SignalHub.emit_on_add_new_scene(bullet, shoot_point.global_position)
	effect.stop()
	effect.play()
