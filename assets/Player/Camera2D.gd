extends Camera2D


func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		self.zoom = Vector2(1,1)
