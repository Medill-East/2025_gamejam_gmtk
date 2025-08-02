# TextClock.gd
extends Label

@export var realtime      := true        # true = 系统时钟
@export var speed_factor  := 1800      # 非实时：1=真实秒；60=1秒=1分钟
@export var start_seconds := 0.0         # 非实时起始 0-86399 秒

var sim_seconds := 0.0                   # 游戏内累计秒

signal hour_tick(current_hour: int)

var _prev_hour := -1

func _ready():
	if not realtime:
		sim_seconds = clamp(start_seconds, 0.0, 86399.0)

func _process(delta):
	var h:int; var m:int; var s:int

	if realtime:
		var now := Time.get_datetime_dict_from_system()
		h = now.hour
		m = now.minute
		s = now.second
	else:
		# ► 更新并“环绕”到 0-86400 区间
		sim_seconds = fmod(sim_seconds + delta * speed_factor, 86400.0)

		var total := int(sim_seconds)    # 用整数做取模更安全
		h = total / 3600
		m = (total % 3600) / 60
		s =  total % 60

	#text = "%02d:%02d:%02d" % [h, m, s]  # 显示 HH:MM
	text = "%02d:%02d" % [h, m]  # 显示 HH:MM
	
	# ……原有计算 h,m,s …
	if h != _prev_hour:                 # 整点刚好跨过
		_prev_hour = h
		emit_signal("hour_tick", h)     # 对外广播
