# res://scripts/Score.gd
extends Node
class_name Score           # 可选

var points := 0
signal changed(new_points)

func add(value: int):
	points += value
	emit_signal("changed", points)
