# res://scripts/Score.gd
extends Node
class_name Score           # 可选

@export var required_score_day1:int = 3
@export var required_score_day2:int = 30

var points := 0
signal changed(new_points)

func _ready() -> void:
	points = 0

func add(value: int):
	points += value
	emit_signal("changed", points)
