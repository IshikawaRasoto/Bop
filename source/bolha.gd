extends CharacterBody2D
class_name bolha

const GRAVITY = 100.0
const MOUSE_PUSH_STRENGTH = 5000.0
var initialized = false
var explodiu = false
var mouse_encostou = false
var mouse_position: Vector2
@onready var pop: AudioStreamPlayer = $Pop

const SPAWN_Y = 503
const SPAWN_X = -551


func set_initialized(state: bool):
	initialized = state
	
func get_initialized() -> bool:
	return initialized

func delay(seconds: float) -> void:
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = seconds
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()  # Remove o timer da cena após o uso


func _physics_process(delta: float) -> void:
	
	if !initialized:
		return
	
	if not is_on_floor() and !explodiu:
		velocity.y += GRAVITY * delta

	mouse_position = get_local_mouse_position()
	var distance = mouse_position.length()

	if distance > 0.0 and distance < 315 and mouse_encostou == false and !explodiu:
		var direction = mouse_position.normalized()
		var push_force = direction * 20 * (MOUSE_PUSH_STRENGTH / distance)
		velocity -= push_force * delta	
		
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !initialized:
		return
	
	explodiu = true
	$Sprite2D.visible = false
	velocity.y = 0
	velocity.x = 0
	pop.play()
	await get_tree().create_timer(1.0).timeout  # Aguarda 1 segundo
	#get_tree().reload_current_scene()
	respawn()

func _on_ready() -> void:
	if !initialized:
		return
	
	$Sprite2D.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_encostou = false
	explodiu = false

func bolha():
	pass

func respawn():
	set_initialized(false)
	position.x = SPAWN_X
	position.y = SPAWN_Y
	await get_tree().create_timer(2).timeout  # Aguarda 1 segundo
	set_initialized(true)
	$Sprite2D.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_encostou = false
	explodiu = false


func _on_area_2d_mouse_entered() -> void:
		mouse_encostou = true
		pop.play()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
