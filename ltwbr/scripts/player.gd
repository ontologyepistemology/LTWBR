extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $Camera3D/node/parry_arm/AnimationPlayer
@export var projectile_scene: PackedScene
@export var projectile_spawn_distance: float = 1.5

var is_parrying: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Parry") and not event.is_echo():
		if not is_parrying: 
			is_parrying = true
			animation_player.play("ulnaAction")
			await get_tree().create_timer(0.35).timeout
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
