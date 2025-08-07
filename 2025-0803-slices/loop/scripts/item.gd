extends Node2D
class_name Interactable   # 便于自动补全

signal hover_start(interactable)
signal hover_end(interactable)
var isHovering: bool = false

@export var item_score:= 1
@export var item_type:= "prop"

@export var hold_threshold := 0.8      # 长按秒数
@export var highlight_mode := 0        # 0=shader, 1=sprite
@export var interact_text  := "长按 E 交互"  # 可用于 UI 提示

var _player_in_range: bool = false
var _hold_time: float = 0.0
var _orig_material: Material

@export var _sprite        = Sprite2D
@export var _highlight_spr = Sprite2D
@export var _area          = Area2D

@export var bar2d: Node2D
#@export var bar_offset_px := Vector2(0, 0)   # 条离物体上移像素
#var bar: Control                     # 屏幕上的条实例
#@onready var _hud: HUD = get_tree().get_current_scene().get_node("Loop-hud") as HUD

signal destroyed(item_type:String, item_score: int)

@export var left_limit := -60.0
@export var right_limit :=  60.0
@export var turn_speed :=  40.0
@onready var detection: Area2D = get_node_or_null("VisionArea")
var is_camera: bool             # true = 有视锥，需要旋转

var break_sfx := preload("res://SFX/destruction-normal.wav")
var bonus_sfx := preload("res://SFX/destruction-bonus.ogg")

func _ready() -> void:
	#is_camera = detection != null
	#if is_camera:
		#detection.body_entered.connect(_on_player_seen_by_camera)
	
	#if detection!=null
		#print("has vision area")
	_area.body_entered.connect(_on_body_entered)
	_area.body_exited.connect(_on_body_exited)
	_highlight_spr.visible = false
	#_orig_material = _sprite.material_override
	#bar = HUD.instance.create_world_bar()      # 拿到条；HUD 用单例

func _process(delta: float) -> void:
	# 位置跟随
	#if bar.visible:
		#var cam := get_viewport().get_camera_2d()
		#if cam:
			#var screen_pos: Vector2 = cam.world_to_screen(global_position)
			#bar.position = screen_pos + bar_offset_px   # (0,-24) 之类
#
	#
	#if not _player_in_range:
		#return
	# press to interact
	#if _player_in_range:
		#if Input.is_action_pressed("Interact"):
			#_hold_time += delta
			#if _hold_time >= hold_threshold:
				#_do_interact()
				#_hold_time = 0.0           # 重置，防止连触发
		#else:
			#_hold_time = 0.0               # 松开就归零，可在 UI 上显示进度
		#_update_bar()
	#else:
		#bar2d.visible = false        # 离开范围就隐藏
		
	# hover to interact
	if isHovering && _player_in_range:
		_hold_time += delta
		_update_bar()
		if _hold_time >= hold_threshold:
			_do_interact()
			_hold_time = 0.0           # 重置，防止连触发
	else:
		_hold_time = 0.0
		bar2d.visible = false        # 离开范围就隐藏

func _physics_process(delta):
	if is_camera:
		rotation += deg_to_rad(turn_speed) * delta
		if rotation_degrees > right_limit or rotation_degrees < left_limit:
			turn_speed = -turn_speed        # 来回扫动

func _on_player_seen_by_camera(body):
	if body.is_in_group("player"):          # 根据你的玩家节点名调整
		_player_in_range = true
		print("camera see player")
		#AUTOLOAD_SCORE.health -= 1
		AUTOLOAD_SCORE.caughtAdd()
		AUTOLOAD_LoopGameGD.fail()

func _update_bar():
	bar2d.visible = true
	var pb := bar2d.get_node("Bar") as ProgressBar
	pb.value = _hold_time / hold_threshold * 100.0

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):          # 根据你的玩家节点名调整
		_player_in_range = true
		# _enable_highlight(true)
		# TODO: 在屏幕或 UI 中显示交互提示，例如调用 HUD.show_hint(interact_text)
		# 安全检查：若玩家脚本没实现该方法也不会崩
		if body.has_method("enter_interactable"):
			body.enter_interactable(self)

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		_player_in_range = false
		_hold_time = 0.0
		_enable_highlight(false)
		# TODO: HUD.hide_hint()
		if body.has_method("exit_interactable"):
			body.exit_interactable(self)

func _enable_highlight(state: bool) -> void:
	match highlight_mode:
		#0:  # shader
			#_sprite.material_override = preload("res://Highlight.tres") if state else _orig_material
		1:  # extra sprite
			_highlight_spr.visible = state

func _do_interact() -> void:
	# 这里写真正的互动逻辑，比如开门、拾取物品、弹对话框……
	print("Item %s interacted!" % name)
	# 例如：queue_free()  # 播完动画后销毁
	queue_free()  # 播完动画后销毁
	bar2d.visible = false            # 交互完成后可隐藏或 queue_free()
	AUTOLOAD_SCORE.add(item_type,item_score)
	emit_signal("destroyed", item_type, item_score)
	#destroySFXNormal()

# 方便外部直接拿 0~1 的进度
func get_ratio() -> float:
	return _hold_time / hold_threshold
	
#
#func _on_detect_body_entered(body: Node2D) -> void:
	#pass # Replace with function body.
#
#
#func _on_detect_body_exited(body: Node2D) -> void:
	#pass # Replace with function body.


func _on_detect_mouse_entered() -> void:
	print("mouse entered")
	isHovering = true
	emit_signal("hover_start", self)   # 通知玩家 / HUD
	#_highlight(true)                   # 比如变色或显示轮廓
	#pass # Replace with function body.


func _on_detect_mouse_exited() -> void:
	isHovering = false
	#pass # Replace with function body.
	emit_signal("hover_end", self)
	#_highlight(false)

func destroySFXNormal():
	_play_sfx_at_position(break_sfx, global_position)
	queue_free()

func destroySFXBonus():
	_play_sfx_at_position(bonus_sfx, global_position)
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
