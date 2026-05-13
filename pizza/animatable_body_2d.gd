extends AnimatableBody2D

const WAIT_DURATION := 1.0

@onready var plataforma = self

@export var move_speed := 3.0
@export var distance := 192
@export var move_horizontal := true

var follow := Vector2.ZERO
var plataforma_center := Vector2.ZERO

func _ready() -> void:
	plataforma_center = plataforma.position
	move_platform()

func _physics_process(_delta: float) -> void:
	plataforma.position = plataforma.position.lerp(follow, 0.5)

func move_platform():

	var move_direction = Vector2.RIGHT * distance if move_horizontal else Vector2.UP * distance

	var duration = move_direction.length() / move_speed

	var plataforma_tween = create_tween().set_loops()

	plataforma_tween.set_trans(Tween.TRANS_LINEAR)
	plataforma_tween.set_ease(Tween.EASE_IN_OUT)

	
	plataforma_tween.tween_property(
		self,
		"follow",
		plataforma_center + move_direction,
		duration
	).set_delay(WAIT_DURATION)

	
	plataforma_tween.tween_property(
		self,
		"follow",
		plataforma_center,
		duration
	).set_delay(WAIT_DURATION)
