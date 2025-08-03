extends Label

func _ready():
	AUTOLOAD_SCORE.changed.connect(_on_score_changed)
	self.text = str(AUTOLOAD_SCORE.points)

func _on_score_changed(p):
	self.text = str(p)
