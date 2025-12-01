extends PickUp

const KEY_APPEARS = preload("res://Assets/Audio/Effects/key-appears.wav")
const KEY_COLLECT = preload("res://Assets/Audio/Effects/key_collect.ogg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_disable()
	SignalHub.on_jewels_collected.connect(_enable)

func _enable():
	set_deferred("monitoring", true)
	show()
	GrannyUtils.play_clip(effects, KEY_APPEARS)
	
func kill():
	effects.stream = KEY_COLLECT
	super()
