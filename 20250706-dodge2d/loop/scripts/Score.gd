# res://scripts/Score.gd
extends Node
class_name Score           # 可选

@export var required_score_day1:int = 3
@export var required_score_day2:int = 30

var points := 0
var health := 3

signal changed(new_points)
signal caught(death_count)

func _ready() -> void:
	points = 0
	health = 3

func add(value: int):
	points += value
	emit_signal("changed", points)

func caughtAdd():
	health -= 1
	emit_signal("caught")
