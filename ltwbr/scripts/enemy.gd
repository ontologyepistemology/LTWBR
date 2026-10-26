extends Node3D

@export var projectile_scene: PackedScene
@export var fire_interval: float = 2.0
@export var projectile_speed: float = 8.0

@onready var projectile_spawn: Marker3D = $projectileSpawn

func _ready() -> void:
	fire_loop()
	
func fire_loop() -> void:
	while true: 
		await get_tree().create_timer(fire_interval).timeout
		spawn_projectile()
		
func spawn_projectile() -> void:
	# print("projectile scene value: ", projectile_scene)
	# print("is null: ", projectile_scene == null)
	
	if projectile_scene == null:
	#	print("error")
		return 
		
#	print("checkpoint: inst")
	var projectile = projectile_scene.instantiate()
#	print("test: ", projectile)
	get_tree().current_scene.add_child(projectile)
	
		
	var forward: Vector3 = -projectile_spawn.global_basis.z
	
	projectile.global_position = projectile_spawn.global_position
	# print("Skull spawned at: ", projectile.global_position)
	# print("Firing direction: ", forward)
	
	projectile.direction = forward
	projectile.speed = projectile_speed
		
