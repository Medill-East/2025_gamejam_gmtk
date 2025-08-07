extends CanvasLayer
class_name POPUPEOD
static var instance: POPUPEOD

@export var default_text: String = "这是静态弹窗内容。\n点击任意处关闭。"
@export var pause_on_open: bool = true

@export var _label: RichTextLabel
@export var _panel: Panel
@export var _btn: Button

@onready var _day: RichTextLabel = $Panel/Day
@onready var _required_destruction: RichTextLabel = $Panel/RequiredDestruction
@onready var _total_destruction: RichTextLabel = $"Panel/Total Destruction"
@onready var score_yes: Sprite2D = $Panel/UiWinScreenNew
@onready var score_no: Sprite2D = $Panel/UiFailScreenNew
var currentText: String

signal closed

func _ready() -> void:
	$MusicManager.play_music(load("res://Music/End-of-the-day.ogg"))
	instance = self
	visible = false
	currentText = _label.text

	_panel.gui_input.connect(_on_panel_input)
	#_btn.pressed.connect(close)
	#currentText = "Do your job!"

# -------- 公共接口 --------
func open() -> void:
	_label.text = currentText
	visible = true
	if pause_on_open:
		get_tree().paused = true

func close() -> void:
	if pause_on_open:
		get_tree().paused = false
	visible = false
	emit_signal("closed")

func update_text(string: String):
	currentText = string
	
func update_score(day: int, required: int, total: int):
	_day.text = str(day)
	_required_destruction.text = str(required)
	_total_destruction.text = str(total)

func eod_yes():
	score_yes.visible = true
	score_no.visible = false
	
func eod_no():
	score_yes.visible = false
	score_no.visible = true


# -------- 内部 --------
func _on_panel_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		close()


func _on_close_button_pressed() -> void:
	print("pressed to close")
	close()
	
	
	
