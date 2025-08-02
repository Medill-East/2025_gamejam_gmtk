extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://loop/loop-main-1217PM.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
