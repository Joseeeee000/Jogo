extends Node2D

# Chamado quando a fase (Node2D) carrega na tela
func _ready() -> void:
	# Ativa o som global chamado musica
	musica.play()
