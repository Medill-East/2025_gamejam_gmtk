extends Node2D

var popup01 := preload("res://loop/popups/Dialogue/Dialogue_T01.tscn").instantiate()
var popup02 := preload("res://loop/popups/Dialogue/Dialogue_T02.tscn").instantiate()
var popup03 := preload("res://loop/popups/Dialogue/Dialogue_T03.tscn").instantiate()
var popup04 := preload("res://loop/popups/Dialogue/Dialogue_T04.tscn").instantiate()
var popup05 := preload("res://loop/popups/Dialogue/Dialogue_T05.tscn").instantiate()
var popup06 := preload("res://loop/popups/Dialogue/Dialogue_T06.tscn").instantiate()
var popup07 := preload("res://loop/popups/Dialogue/Dialogue_T07.tscn").instantiate()
var popup08 := preload("res://loop/popups/Dialogue/Dialogue_T08.tscn").instantiate()
var popupeod := preload("res://loop/popups/popup-eod.tscn").instantiate()

@onready var clocklabel = $"Loop-clock"
@onready var boss: = $"Loop-boss"

var current_hour

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	adjust_boss(false)
	_popup01()
	await popup01.closed
	#print("popup01closed")
	_popup02()
	await popup02.closed
	#print("popup02closed")
	await _wait_hour(9)
	await popup03.closed
	adjust_boss(true)
	await _wait_hour(10)
	await popupeod.closed
	if AUTOLOAD_SCORE.points < AUTOLOAD_SCORE.required_score_day1:
		get_tree().change_scene_to_file("res://loop/Start.tscn")
	else:
		get_tree().change_scene_to_file("res://loop/loop-main-day2.tscn")

func _wait_hour(target: int):
	while true:
		var hour : int = await clocklabel.hour_tick   # 等下一次整点
		#print(hour)
		if hour == target:
			if target == 9:
				_popup03()
			if target == 10:
				_popupeod()
			break                                     # 满足→退出函数执行一次

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#current_hour = await clocklabel.hour_tick
	#print(current_hour)
	#if current_hour == 20:
		#_popup03()

func adjust_boss(status: bool):
	boss.visible = status
	boss.set_process(status)
	boss.set_physics_process(status)
	
func _on_hour_tick(h):
	print("Ding！ %02d:00" % h)

func _popup01():
	print("popup01")
	add_child(popup01)
	popup01.open()        # 打开&暂停
	
func _popup02():
	print("popup02")
	add_child(popup02)
	popup02.open()        # 打开&暂停	

func _popup03():
	print("popup03")
	add_child(popup03)
	popup03.open()        # 打开&暂停	

func _popupeod():
	print("popupeod")
	add_child(popupeod)
	if AUTOLOAD_SCORE.points < AUTOLOAD_SCORE.required_score_day1:
		popupeod.eod_no()
	else:
		popupeod.eod_yes()
	popupeod.update_score(1,AUTOLOAD_SCORE.required_score_day1,AUTOLOAD_SCORE.points)
	popupeod.open()        # 打开&暂停	
	
