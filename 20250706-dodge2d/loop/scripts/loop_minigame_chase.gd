extends Node2D
class_name MINIGAME_CHASE

static var instance: MINIGAME_CHASE

var timerParent := preload("res://loop/minigame-chase/loop-minigame-chase.tscn")
var popup05 := preload("res://loop/popups/Dialogue/Dialogue_T05.tscn").instantiate()

@onready var timer: = $CanvasLayer/Label

@export var START_TIME := 5.0          # 生存多少秒胜利
var time_left := 0.0
var running := true                  # 用于暂停逻辑

func _ready():
	$MusicManager.play_music(load("res://Music/mini-game 1.ogg"))
	instance = self
	_reset_game()

func _reset_game():
	time_left = START_TIME
	running = true
	timer.text = str(roundi(time_left))
	get_tree().paused = false       # 防上把暂停过
	
func _process(delta):
	if not running:
		return                       # 停止计时

	time_left -= delta
	#HUD.instance.update_timer(time_left)
	timer.text = str(roundi(time_left))


	if time_left <= 0.0:
		win()
		
func fail():
	get_tree().paused = true
	#HUD.instance.show_fail_label("GAME OVER！")
	#AUTOLOAD_POPUP.update_text("CHASED!")
	#AUTOLOAD_POPUP.open()
	_popup05()

func win():
	running = false
	#AUTOLOAD_POPUP.instance.update_text("YOU WIN!")
	#AUTOLOAD_POPUP.instance.open()
	get_tree().change_scene_to_file("res://loop/loop-main-day2.tscn")

func _popup05():
	print("popup05")
	add_child(popup05)
	popup05.open()        # 打开&暂停	
