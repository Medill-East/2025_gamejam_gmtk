# res://scripts/Score.gd
extends Node
class_name Score           # 可选

var popup09 := preload("res://loop/popups/Dialogue/Dialogue_T09.tscn").instantiate()
var popup10 := preload("res://loop/popups/Dialogue/Dialogue_T10.tscn").instantiate()
var popup11 := preload("res://loop/popups/Dialogue/Dialogue_T11.tscn").instantiate()
var popup12 := preload("res://loop/popups/Dialogue/Dialogue_T12.tscn").instantiate()
var popup13 := preload("res://loop/popups/Dialogue/Dialogue_T13.tscn").instantiate()
var popup14 := preload("res://loop/popups/Dialogue/Dialogue_T14.tscn").instantiate()
var popup15 := preload("res://loop/popups/Dialogue/Dialogue_T15.tscn").instantiate()
var popup16 := preload("res://loop/popups/Dialogue/Dialogue_T16.tscn").instantiate()
var popup17 := preload("res://loop/popups/Dialogue/Dialogue_T17.tscn").instantiate()
var popup18 := preload("res://loop/popups/Dialogue/Dialogue_T18.tscn").instantiate()

var break_sfx := preload("res://SFX/destruction-normal.wav")
var bonus_sfx := preload("res://SFX/destruction-bonus.ogg")

@export var required_score_day1:int = 300
@export var required_score_day2:int = 500

var points := 0
var health := 3

signal changed(new_total: int, gained: int, bonus: int)
#signal changed(new_points)
signal caught(death_count)

# 例：打碎 5 台 computer 奖励 500 分； 3 棵 plant 奖励 300 分
var bonus_threshold := {
	"pottedplant": { "count": 3, "reward": 50 },
	"tablelight": { "count": 3, "reward": 50 },
	"computer": { "count": 3, "reward": 50 },
	"watermachine": { "count": 1, "reward": 50 },
	"coffemachine": { "count": 1, "reward": 50 },
	"keyboard": { "count": 3, "reward": 50 },
	"telephone": { "count": 3, "reward": 50 },
	"chair": { "count": 3, "reward": 50 },
	"printer": { "count": 1, "reward": 50 },
	"camera": { "count": 3, "reward": 50 }  
}


func _ready() -> void:
	points = 0
	health = 3

#func add(value: int):
	#points += value
	#emit_signal("changed", points)

func caughtAdd():
	health -= 1
	emit_signal("caught")


#var chain  : Dictionary = {
	#"pottedplant":3, 
	#"tablelight": 3,
	#"computer": 3,
	#"watermachine": 3,
	#"coffemachine": 3,
	#"keyboard": 3,
	#"telephone": 3,
	#"chair": 3,
	#"printer": 3,
	#"camera": 2}  

var chain  : Dictionary = {}  

# 自定义奖励规则：第 n 件同类 = base + extra(n)
func _extra(n: int, base: int) -> int:
	# 例：第 1 件 0，2 件多 50%，3 件多 100%，之后封顶
	var mul : int = clamp((n - 1) * 0.5, 0.0, 1.0)
	return int(base * mul)

func add(item_type: String, base: int):
	var n : int = chain.get(item_type, 0) + 1
	chain[item_type] = n
	
	var bonus  := 0
	if bonus_threshold.has(item_type):
		var data = bonus_threshold[item_type]
		if n >= data["count"]:
			bonus = data["reward"]
			chain[item_type] = 0          # ① 达标后清零 → 只能拿一次
			print("bonus")
			match item_type:	
				"pottedplant": _popup09() 
				"tablelight": _popup10() 
				"computer": _popup11() 
				"watermachine": _popup12() 
				"coffemachine": _popup13() 
				"keyboard": _popup14() 
				"telephone": _popup15() 
				"chair": _popup16() 
				"printer": _popup17() 
				"camera": _popup18()
			#destroySFXBonus()
			

	var gained := base + bonus
	points += gained
	emit_signal("changed", points, gained, bonus)
#
	#var bonus  := _extra(n, base)
	#var gained := base + bonus
	#points += gained
#
	#emit_signal("changed", points, gained, bonus)
	#if bonus > 0:
		#match item:
			#"pottedplant": _popup09() 
			#"tablelight": _popup10() 
			#"computer": _popup11() 
			#"watermachine": _popup12() 
			#"coffemachine": _popup13() 
			#"keyboard": _popup14() 
			#"telephone": _popup15() 
			#"chair": _popup16() 
			#"printer": _popup17() 
			#"camera": _popup18()

func _popup09():
	print("popup09")
	add_child(popup09)
	popup09.open()        # 打开&暂停	

func _popup10():
	print("popup10")
	add_child(popup10)
	popup10.open()        # 打开&暂停	
	
func _popup11():
	print("popup11")
	add_child(popup11)
	popup11.open()        # 打开&暂停	
	
func _popup12():
	print("popup12")
	add_child(popup12)
	popup12.open()        # 打开&暂停	
	
func _popup13():
	print("popup13")
	add_child(popup13)
	popup13.open()        # 打开&暂停	
	
func _popup14():
	print("popup14")
	add_child(popup14)
	popup14.open()        # 打开&暂停	
	
func _popup15():
	print("popup15")
	add_child(popup15)
	popup15.open()        # 打开&暂停	
	
func _popup16():
	print("popup16")
	add_child(popup16)
	popup16.open()        # 打开&暂停	
	
func _popup17():
	print("popup17")
	add_child(popup17)
	popup17.open()        # 打开&暂停	
	
func _popup18():
	print("popup18")
	add_child(popup18)
	popup18.open()        # 打开&暂停	
	


func destroySFXBonus():
	_play_sfx_at_position(bonus_sfx, Vector2(330, 240))
	queue_free()

func _play_sfx_at_position(stream: AudioStream, pos: Vector2) -> void:
	var p := AudioStreamPlayer2D.new()
	p.stream = stream
	p.position = pos
	p.autoplay = false
	p.bus = "SFX"            # 可选：路由到 SFX bus
	get_tree().current_scene.add_child(p)
	p.play()
	p.finished.connect(p.queue_free)
