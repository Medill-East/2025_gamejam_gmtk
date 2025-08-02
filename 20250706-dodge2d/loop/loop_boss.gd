extends CharacterBody2D
class_name Enemy

@export_node_path("Path2D") var patrol_path          # 在 Inspector 拖进 Path2D
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

func _ready():
	var path: Path2D = get_node(patrol_path)
	patrol_points = []
	var curve := path.curve
	var point_count := curve.point_count
	for i in point_count:
		patrol_points.append(curve.get_point_position(i))
		
	_vision_area.body_entered.connect(_on_player_spotted)
	_init_vision_shape()
	#_spawn_rays()

func _physics_process(delta):
	_patrol(delta)
	_update_vision(delta)

# ---------- 巡逻 ----------
func _patrol(delta):
	var target = patrol_points[_patrol_idx]
	var dir = (target - global_position).normalized()
	velocity = dir * move_speed
	move_and_slide()

	if global_position.distance_to(target) < 4.0:
		_patrol_idx = (_patrol_idx + 1) % patrol_points.size()

# ---------- 视锥朝向 & 遮挡 ----------
func _update_vision(delta):
	# 让 VisionArea 与敌人同角度（假设 Sprite 面向 +X）
	_vision_area.rotation = rotation

	# 遮挡检测：更新每条 RayCast2D 的目标点
	for i in _ray_holder.get_children():
		var ray := i as RayCast2D
		var angle := -fov_angle/2 + (ray.get_index() / float(ray_count-1)) * fov_angle
		ray.target_position = Vector2.RIGHT.rotated(deg_to_rad(angle)) * fov_range
		ray.force_raycast_update()

		# 如果射线被墙挡住，把视锥多边形缩短对应顶点（高级，可选）

# ---------- 生成初始形状 ----------
func _init_vision_shape():
	var verts: PackedVector2Array
	verts.append(Vector2.ZERO)                    # 扇形中心
	for i in range(ray_count):
		var angle := -fov_angle/2 + i * fov_angle / (ray_count-1)
		verts.append(Vector2.RIGHT.rotated(deg_to_rad(angle)) * fov_range)
	_vision_shape.points = verts
#
#func _spawn_rays():
	#for i in range(ray_count):
		#var rc := RayCast2D.new()
		#rc.collision_mask = 1 << WALL_LAYER       # 对墙体层检测
		#rc.enabled = true
		#_ray_holder.add_child(rc)

# ---------- 发现玩家 ----------
func _on_player_spotted(body: Node) -> void:
	if body is PLAYER:
		AUTOLOAD_LoopGameGD.fail()                               # 全局管理器里触发失败
