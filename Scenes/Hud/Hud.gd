extends Control

@onready var label_jewels: Label = $PC/HB/HBJewel/LabelJewels
@onready var label_coins: Label = $PC/HB/HBCoin/LabelCoins
@onready var key_image: TextureRect = $PC/KeyImage
@onready var label_exit: Label = $PC/LabelExit
@onready var level_complet_rect: ColorRect = $LevelCompletRect
@onready var continue_label: Label = $LevelCompletRect/VB/ContinueLabel
@onready var music: AudioStreamPlayer = $Music
const DARKLING = preload("res://Assets/Audio/Music/Darkling.mp3")
const PARADISE_FOUND = preload("res://Assets/Audio/Music/Paradise_Found.mp3")

func _ready() -> void:
	level_complet_rect.hide()

func _enter_tree() -> void:
	SignalHub.on_pickup_scores_updated.connect(on_pickup_scores_updated)
	SignalHub.on_jewels_collected.connect(on_jewels_collected)
	SignalHub.on_key_collected.connect(on_key_collected)
	SignalHub.on_level_completed.connect(on_level_completed)
	
func on_level_completed() -> void:
	show_game_over(false)
	
func show_game_over(_is_dead: bool):
	get_tree().paused = true
	level_complet_rect.show()
	await get_tree().create_timer(1.0).timeout
	continue_label.show()
	GrannyUtils.play_clip_plain(music, PARADISE_FOUND)
	
	
func on_pickup_scores_updated(pickup_scores: PickUpScores):
	label_jewels.text = "%d/%d" % [
		pickup_scores.jewels_count, pickup_scores.jewels_total
		]
	label_coins.text = "%d/%d" % [
		pickup_scores.coins_count, pickup_scores.coins_total
		]

func on_jewels_collected():
	key_image.show()
	var tween = create_tween()
	tween.set_loops(3)
	tween.tween_property(key_image, "modulate", Color(1, 1, 1, 0), 0.5)
	tween.tween_property(key_image, "modulate", Color(1, 1, 1, 1), 0.5)
	
func on_key_collected():
	key_image.hide()
	label_exit.show()	
