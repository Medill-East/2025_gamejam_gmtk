extends CharacterBody2D

@export var speed       := 120.0
@export var drop_period := 0.25        # 每 0.25 秒留一次块
@export var block_scene := preload("res://loop/minigame-chase/loop-minigame-chase-trailblock.tscn")

@export var minigame_chase_player: MINI_CHASE_PLAYER
@export var trail_root: Node2D
#@onready var player := $mini"
#@onready var trail_root := $"../TrailRoot"

var _drop_timer := 0.0

func _physics_process(delta):
	# 1️⃣ 朝玩家追踪
	var dir : Vector2 = (minigame_chase_player.global_position - global_position).normalized()
	velocity = dir * speed
	move_and_slide()

	# 2️⃣ 定时丢障碍
	_drop_timer += delta
	if _drop_timer >= drop_period:
		_drop_timer = 0.0
		_spawn_block()
	
	#_patrol(delta)
	_update_vision(delta)
	print(velocity.x)
	if velocity.x < 0 and facing_left != true:
		scale.x = 1
		facing_left = true
	elif velocity.x > 0 and facing_left == true:
		scale.x = -1
		facing_left = false

func _spawn_block():
	var blk := block_scene.instantiate()
	blk.global_position = global_position
	trail_root.add_child(blk)

# ---------- 发现玩家 ----------
func _on_player_spotted(body: Node) -> void:
	if body is MINI_CHASE_PLAYER:
		#AUTOLOAD_MINIGAME_CHASE.instance.fail()                               # 全局管理器里触发失败
		AUTOLOAD_LoopGameGD.instance.fail_minigame_chase()                               # 全局管理器里触发失败
		
		
		
var patrol_points: Array[Vector2]
@export var move_speed := 80.0               # 像素/秒
@export var fov_angle := 90.0                # 视场角 (deg)
@export var fov_range := 200.0               # 视距
@export var ray_count := 4                  # 遮挡检测用射线数量

@onready var _vision_area: Area2D = $VisionArea
@onready var _vision_shape: ConvexPolygonShape2D = $VisionArea/VisionShape.shape
@onready var _ray_holder := $RayCastHolder

var _patrol_idx := 0
var _player_ref: PLAYER = null

# rotation
var facing_left = true
var THRESH := 10 # 像素/秒

func _ready():
	_vision_area.body_entered.connect(_on_player_spotted)
	#_init_vision_shape()
	#_spawn_rays()

# ---------- 巡逻 ----------
func _patrol(delta):
	var target = patrol_points[_patrol_idx]
	var dir = (target - global_position).normalized()
	velocity = dir * move_speed
	move_and_slide()

	if global_position.distance_to(target) < 4.0:
		_patrol_idx = (_patrol_idx + 1) % patrol_points.size()

	# scale = 1, left
	# scale = -1, right
	#var facing_left := scale.x > 0   # 初始化
	#moving to left
	print(velocity.x)
	if velocity.x < 0 and facing_left != true:
		scale.x = 1
		facing_left = true
	elif velocity.x > 0 and facing_left == true:
		scale.x = -1
		facing_left = false

# ---------- 视锥朝向 & 遮挡 ----------
func _update_vision(delta):
	# 让 VisionArea 与敌人同角度（假设 Sprite 面向 +X）
	#_vision_area.rotation = rotation

	# 遮挡检测：更新每条 RayCast2D 的目标点
	for i in _ray_holder.get_children():
		var ray := i as RayCast2D
		var angle := -fov_angle/2 + (ray.get_index() / float(ray_count-1)) * fov_angle
		ray.target_position = Vector2.RIGHT.rotated(deg_to_rad(angle)) * fov_range
		ray.force_raycast_update()

		# 如果射线被墙挡住，把视锥多边形缩短对应顶点（高级，可选）
