extends Node3D

@export var max_health: int = 100
var health: int = 100
@export var projectile_scene: PackedScene
@export var fire_interval: float = 2.0
@export var min_projectile_speed: float = 6.0
@export var max_projectile_speed: float = 12.0

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
	projectile.direction = forward
	projectile.speed = randf_range(min_projectile_speed, max_projectile_speed)
	projectile.target = get_tree().current_scene.get_node("player")
	print("Rspeed: ", projectile.speed)
	projectile.source_enemy = self
		
		
func take_damage(amount: int) -> void:
	print("Damage received: ", amount)
	print("Health before hit: ", health)
	
	health = max(health - amount, 0)
	
	print("Enemy Health: ", health, "/", max_health)
	
	if health <= 0:
		print("Foe Vanquished!")
		get_tree().current_scene.show_triumph_screen()
		queue_free()
