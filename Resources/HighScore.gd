extends Resource


class_name HighScore


@export var score: int = 0
@export var date_scored: String = GrannyUtils.formatted_dt()


func _init(
	p_score: int = 0, 
	p_date_scored: String = GrannyUtils.formatted_dt()
	) -> void:
	score = p_score
	date_scored = p_date_scored
	
	
