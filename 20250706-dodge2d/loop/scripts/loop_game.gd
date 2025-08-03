extends Node2D
class_name GAMELOOP

static var instance: GAMELOOP

var popup05 := preload("res://loop/popups/Dialogue/Dialogue_T05.tscn").instantiate()
var popupminigamechase := preload("res://loop/popups/popup-minigame-chase.tscn").instantiate()


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

		
func fail_minigame_chase():
	get_tree().paused = true
	#HUD.instance.show_fail_label("GAME OVER！")
	#AUTOLOAD_POPUP.update_text("CHASED!")
	#AUTOLOAD_POPUP.open()
	_popup_minigamechase()

func win():
	#running = false
	#AUTOLOAD_POPUP.instance.update_text("YOU WIN!")
	#AUTOLOAD_POPUP.instance.open()
	get_tree().change_scene_to_file("res://loop/loop-main-day2.tscn")

func _popup05():
	print("popup05")
	add_child(popup05)
	popup05.open()        # 打开&暂停	
	
func _popup_minigamechase():
	print("popupminigamechase")
	add_child(popupminigamechase)
	popupminigamechase.open()        # 打开&暂停	
