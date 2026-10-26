extends Area3D


@export var speed: float = 6.0
var direction: Vector3 = Vector3.ZERO
var target: Node3D = null
var source_enemy: Node3D = null

func _process(delta: float) -> void: 
	position += direction * speed * delta

func init(target_position: Vector3) -> void: 
	direction = (target_position - global_position).normalized()
	
# I'm genuinely coding sum bs my prof would've killed me if he saw this (wdym you don't have three separate files and just func calling in main?) 

func deflect() -> void:
	if source_enemy == null:
		print("No enemy")
		return
		
	# print("Deflection")
	# print("Direction prior: ", direction)
	
	direction = (source_enemy.global_position - global_position).normalized()
	speed *= 1.5
	print("Parried!")
	# print("Direction after: ", direction)
