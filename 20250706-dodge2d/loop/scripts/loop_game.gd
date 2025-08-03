extends Node2D
class_name GAMELOOP

static var instance: GAMELOOP

func fail():
	get_tree().paused = true
	#HUD.instance.show_fail_label("GAME OVER！")
	POPUP.instance.update_text("GAME OVER!")
	POPUP.instance.open()
	print("fail")
	await POPUP.instance.closed
	if AUTOLOAD_SCORE.health <= 0:
		get_tree().change_scene_to_file("res://loop/Start.tscn")
	
func _ready():
	instance = self
