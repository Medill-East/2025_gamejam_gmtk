extends Node2D
class_name GAMELOOP

static var instance: GAMELOOP

func fail():
	get_tree().paused = true
	#HUD.instance.show_fail_label("GAME OVER！")
	POPUP.instance.update_text("GAME OVER!")
	POPUP.instance.open()
	
func _ready():
	instance = self
