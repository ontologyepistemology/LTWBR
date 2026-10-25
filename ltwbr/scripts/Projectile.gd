extends Area3D


@export var speed: float = 8.0

var direction: Vector3 = Vector3.ZERO

func _process(delta: float) -> void: 
	position += direction * speed * delta

func init(target_position: Vector3) -> void: 
	direction = (target_position - global_position).normalized()
	
# I'm genuinely coding sum bs my prof would've killed me if he saw this (wdym you don't have three separate files and just func calling in main?) 

func deflect() -> void:
	print("Deflection")
	print("Direction prior: ", direction)
	direction = -direction
	speed *= 1.5
	print("Direction after: ", direction)
