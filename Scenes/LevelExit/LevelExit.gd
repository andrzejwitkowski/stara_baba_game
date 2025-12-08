extends Node3D

@onready var label_holder: Node3D = $LabelHolder
@onready var label_key: Label3D = $LabelHolder/LabelKey
@onready var effects: AudioStreamPlayer3D = $Effects
var key_collected: bool = false

func _ready():
	SignalHub.on_key_collected.connect(on_key_collected)
	label_holder.hide()
	animate_label()
	
func on_key_collected():
	key_collected = true
	
func animate_label():
	var tween: Tween = create_tween()
	tween.set_loops()
	tween.tween_property(label_key, "visible", true, 0.6)
	tween.tween_property(label_key, "visible", false, 0.1)
	print("tweene")

func _on_exit_area_body_entered(_body: Node3D) -> void:
	if key_collected:
		label_key.text = "LEVEL COMPLETED"
		label_holder.show()
		SignalHub.emit_on_level_completed()
	else:
		label_holder.show()
		effects.play()
	
func _on_exit_area_body_exited(_body: Node3D) -> void:
	label_holder.hide()
