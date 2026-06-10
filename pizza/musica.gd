extends AudioStreamPlayer

# Chamado assim que o jogo inicia
func _ready() -> void:
	# Apenas carrega a música na memória, mas não toca ainda
	stream = load("res://musica/vida.mp3")
