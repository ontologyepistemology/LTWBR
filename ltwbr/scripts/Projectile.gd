extends Area3D

# I have given up on organization in any of these files because I'm just going to have to rewrite all of this at some point

@export var min_projectile_speed: float = 6.0
@export var max_projectile_speed: float = 12.0

@export var speed: float = randf_range(min_projectile_speed, max_projectile_speed)


var damage: int = calc_damage_via_speed() # I feel like I'm doing this in a roundabout way... 
var direction: Vector3 = Vector3.ZERO
var target: Node3D = null
var source_enemy: Node3D = null

func _process(delta: float) -> void: 
	position += direction * speed * delta





# func init(target_position: Vector3) -> void: 
	
	
# I'm genuinely coding sum bs my prof would've killed me if he saw this (wdym you don't have three separate files and just func calling in main?) 

func deflect() -> void:
	if source_enemy == null: 
		print("Nill")
		return
		
	var mesh = source_enemy.find_child("MeshInstance3D", true, false)
	var target_position: Vector3 = source_enemy.global_position
	
	if mesh is MeshInstance3D and mesh.mesh != null:
		target_position = mesh.global_transform * mesh.get_aabb().get_center()
	
	direction = (target_position - global_position).normalized()
	speed *= 1.5
	
	print("Parried!")
	 #calc_damage_via_speed()
	# print("Parried!")
	# print("Direction after: ", direction)
	
# Damage function

func _on_body_entered(body: Node3D) -> void:
	
	var damage_target: Node = body
	
	while damage_target != null and not damage_target.has_method("take_damage"):
		damage_target = body.get_parent()
		
	if damage_target != null:
		print("Damaging: ", damage_target.name)
		damage_target.take_damage(damage)
		queue_free()
		
func calc_damage_via_speed() -> int:
	damage = roundi(speed * 3.0)
	print(damage)
	return damage;
