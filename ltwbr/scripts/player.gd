extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $Camera3D/node/parry_arm/AnimationPlayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Parry") and not event.is_echo():
		if not animation_player.is_playing():
			animation_player.play("ulnaAction")
