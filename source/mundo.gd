extends Node2D
class_name Mundo

@onready var inst_mundo: Mundo = $"."
@onready var inst_bolha: bolha = $CharacterBody2D
@onready var fade_in: AnimationPlayer = $OpeningCutscene/Fade_in
@onready var meteoro: AnimatedSprite2D = $OpeningCutscene/Meteoro_Player/Meteoro
@onready var meteor_sound: AudioStreamPlayer = $OpeningCutscene/Meteoro_Player/Meteoro/MeteorSound
@onready var meteoro_player: AnimationPlayer = $OpeningCutscene/Meteoro_Player
@onready var bolha_player: AnimationPlayer = $OpeningCutscene/Bolha_Player


@onready var fade_white: AnimationPlayer = $OpeningCutscene/Fade_white

var inicio_jogo = true


func _ready() -> void:
	
	if inicio_jogo:
		print("inicio jogo")
		inicio_jogo = false
		inst_bolha.set_initialized(false)
		inst_bolha.visible = false
		fade_in.play("Fade_In")
		await get_tree().create_timer(2).timeout  # Aguarda 1 segundo 
		meteor_sound.play()
		meteoro.play("default")
		meteoro_player.play("meteoro_caindo")
		await get_tree().create_timer(18).timeout  # Aguarda 1 segundo
		inst_bolha.visible = true
		await get_tree().create_timer(1).timeout  # Aguarda 1 segundo
		bolha_player.play("bolha_humano")
		await get_tree().create_timer(11).timeout  # Aguarda 1 segundo
		inst_bolha.set_initialized(true)
		
	
	
	
	
