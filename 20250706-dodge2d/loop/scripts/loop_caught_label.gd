extends Label

func _ready():
	AUTOLOAD_SCORE.caught.connect(_on_caught)
	self.text = str(AUTOLOAD_SCORE.health)

func _on_caught():
	self.text = str(AUTOLOAD_SCORE.health)
