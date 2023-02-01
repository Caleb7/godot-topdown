extends KinematicBody2D

var run_velocity = Vector2.ZERO
var run_speed_max = 80
var run_accel = 15
var friction = 15
var dir = Vector2.ZERO

onready var anim = $Anim
onready var animTree = $AnimTree
onready var animState = animTree.get("parameters/playback")

func _ready():
	pass

func _physics_process(delta):
	mouse_move(delta)

func mouse_move(delta):
	var mouse_xy = get_global_mouse_position()
	var mouse_pressed = Input.is_mouse_button_pressed(1) || Input.is_mouse_button_pressed(2)
	if mouse_pressed && mouse_xy.distance_to(self.position) >= 10:
		dir = (mouse_xy - self.position).normalized()
		animTree.set("parameters/Run/blend_position", dir)
		animState.travel("Run")
	else:
		dir = Vector2.ZERO
	run_velocity = run_velocity.move_toward(dir * run_speed_max, run_accel)
	run_velocity = move_and_slide(run_velocity)

func wsad_move(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	if input_vector != Vector2.ZERO:
		animTree.set("parameters/Run/blend_position", input_vector)
		animState.travel("Run")
	run_velocity = run_velocity.move_toward(input_vector * run_speed_max, run_accel)
	run_velocity = move_and_slide(run_velocity)
