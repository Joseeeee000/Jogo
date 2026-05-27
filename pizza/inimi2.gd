extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const SPEED = 50
const GRAVITY = 900
const DISTANCIA = 100

var direcao = 1
var posicao_inicial = 0.0

func _ready():

	posicao_inicial = global_position.x

func _physics_process(delta):

	# Gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	# Movimento
	velocity.x = SPEED * direcao

	# Distância máxima
	if global_position.x >= posicao_inicial + DISTANCIA:
		direcao = -1
		anim.flip_h = true

	if global_position.x <= posicao_inicial - DISTANCIA:
		direcao = 1
		anim.flip_h = false

	move_and_slide()

	anim.play("anda")


func _on_player_f_body_entered(body: Node2D) -> void:

	if body.is_in_group("player"):

		get_tree().reload_current_scene()


func _on_fim_body_entered(body: Node2D) -> void:

	if body.is_in_group("player"):

		# Verifica se o player está caindo
		if body.velocity.y > 0:

			# Faz o player quicar
			body.velocity.y = -250

			# Remove o inimigo
			queue_free()
