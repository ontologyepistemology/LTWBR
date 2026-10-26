extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $Camera3D/node/parry_arm/AnimationPlayer
@onready var camera: Camera3D = $Camera3D

@export var max_health: int = 100
@export var projectile_scene: PackedScene
@export var projectile_spawn_distance: float = 1.5
@export var mouse_sensitivity: float = 0.002

var health: int = 100
var is_parrying: bool = false
var camera_pitch: float = 0.0 # What's the difference between pitch and yaw again?

# Parrying functions! 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Parry") and not event.is_echo():
		if not is_parrying: 
			is_parrying = true
			animation_player.play("ulnaAction")
			await get_tree().create_timer(0.5).timeout
			is_parrying = false
	if event.is_action_pressed("fire_projectile") and not event.is_echo():
		fire_projectile()
			
func fire_projectile() -> void:
	if projectile_scene == null:
		return
	var projectile = projectile_scene.instantiate() 
	get_tree().current_scene.add_child(projectile)
	
	var spawn_position = $Camera3D.global_position \
		+ (-$Camera3D.global_transform.basis.z * projectile_spawn_distance)
		
	projectile.global_position = spawn_position
	projectile.init(
		spawn_position + (-$Camera3D.global_transform.basis.z * 20.0) # magic number hell
	)

func _on_area_3d_area_entered(area: Area3D) -> void:
	# print("Parry area detected: ", area.name)
	# print("Is parrying: ", is_parrying)
	if not is_parrying:
		return
	if area.has_method("deflect"):
		area.call("deflect")
	else:
		print("This area has no deflect() method")
		
		
		
# Mouse functions! 

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode ==  Input.MOUSE_MODE_CAPTURED:
			rotate_y(-event.relative.x * mouse_sensitivity)
			
			camera_pitch -= event.relative.y * mouse_sensitivity
			camera_pitch = clampf(camera_pitch, deg_to_rad(-85), deg_to_rad(85)) 
			camera.rotation.x = camera_pitch
			
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func take_damage(amount: int) -> void:
		health = max(health - amount, 0)
		print("Health ", health, "/", max_health)
		
		if health <= 0:
			print("GAME OVER")
