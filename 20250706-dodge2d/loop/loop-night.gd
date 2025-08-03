extends Control

func _ready() -> void:
	$Popup.visible = true

func _on_button_pressed() -> void:
	#pass # Replace with function body.
	get_tree().change_scene_to_file("res://loop/loop-main-day2.tscn")
