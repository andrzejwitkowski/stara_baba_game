extends Node

class_name PickUpTracker

var pickup_scores: PickUpScores = PickUpScores.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_tree().get_nodes_in_group(PickUp.GROUP_NAME):
		if child is PickUp:
			match child.pickup_type:
				PickUp.PickUpType.Jewel:
					pickup_scores.jewels_total += 1
				PickUp.PickUpType.Coin:
					pickup_scores.coins_total += 1
	print(pickup_scores)
	SignalHub.emit_on_pickup_scored_updated(pickup_scores)

func _enter_tree() -> void:
	SignalHub.on_pickup_collected.connect(on_pickup_collected)
	
func on_pickup_collected(pick_up: PickUp):
	match pick_up.pickup_type:
		PickUp.PickUpType.Jewel:
			pickup_scores.jewels_count += 1
			if pickup_scores.all_jewels_collected():
				SignalHub.emit_on_jewels_collected()
			print("Jewel collected")
		PickUp.PickUpType.Coin:
			pickup_scores.coins_count += 1
			print("Coin collected")
		PickUp.PickUpType.Key:
			SignalHub.emit_on_key_collected()
			print("Key collected")
	SignalHub.emit_on_pickup_scored_updated(pickup_scores)
