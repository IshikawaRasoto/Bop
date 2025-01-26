extends Area2D

@onready var cutscene_final: AnimationPlayer = $"../Cutscene_final"

var player : bolha = null

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("bolha"):
		player = body
		player.set_initialized(false)
		cutscene_final.play("end")
		await get_tree().create_timer(15).timeout  # Aguarda 1 segundo 
		
	
