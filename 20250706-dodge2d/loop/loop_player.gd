extends Node2D

# Player.gd  (挂在 Player 节点)

@export var follow_speed := 8.0        # 越大越“紧”，越小越“粘滞”
@export var max_speed    := 1000.0     # 可选：限制瞬时速度，0 表示不限制

@onready var _hud: HUD = get_tree().get_current_scene().get_node("Loop-hud") as HUD

var current_item: Interactable = null   # 当前可交互物（可选）

func _process(delta: float) -> void:
	var target := get_global_mouse_position()
	var to_target := target - global_position

	# 阻尼插值：指数衰减，帧率无关
	var factor := 1.0 - pow(0.001, follow_speed * delta)   # 0~1
	var step := to_target * factor

	# 若需要最大速度限制
	if max_speed > 0.0 and step.length() > max_speed * delta:
		step = step.normalized() * max_speed * delta

	global_position += step
	
	## item interaction
	#if current_item and current_item._player_in_range:
		#var ratio := current_item.get_ratio()
		#_hud.update_hold_progress(ratio, true)
	#else:
		#_hud.update_hold_progress(0.0, false)


func enter_interactable(item: Interactable) -> void:
	current_item = item
	# 这里也可以通知 HUD：show hold bar
	print("进入交互范围：", item.name)

func exit_interactable(item: Interactable) -> void:
	if current_item == item:
		current_item = null
		# 也可以通知 HUD：hide
		print("离开交互范围：", item.name)
