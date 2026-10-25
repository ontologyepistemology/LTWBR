extends Area3D


@export var speed: float = 8.0

var direction: Vector3 = Vector3.ZERO

func _process(delta: float) -> void: 
	position += direction * speed * delta

func init(target_position: Vector3) -> void: 
	direction = (target_position - global_position).normalized()
