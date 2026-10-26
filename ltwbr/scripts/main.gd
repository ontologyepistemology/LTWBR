extends Node3D

@onready var death_screen: CanvasLayer = $death_screen

func show_death_screen() -> void:
	death_screen.visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($death_screen/death_text, "modulate:a", 1.0, 1.5)



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and not get_tree().paused:
		show_death_screen()
