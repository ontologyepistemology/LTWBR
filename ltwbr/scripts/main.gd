extends Node3D
@onready var triumph_screen: CanvasLayer = $triumph_screen
@onready var death_screen: CanvasLayer = $death_screen
@onready var health_bar: ProgressBar = $HUD_temp/HealthBar
@onready var player = $player
@onready var health_label: Label = $HUD_temp/VITALITY

var health_tween: Tween

func show_death_screen() -> void:
	death_screen.visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($death_screen/death_text, "modulate:a", 1.0, 1.5)

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().reload_current_scene()

# HealthBar

func _ready() -> void:
	health_bar.max_value = player.max_health
	health_bar.value = player.health
	

func update_health_bar(current_health: int, max_health: int) -> void:
		health_bar.max_value = max_health
		health_label.text = str(current_health) + "/" + str(max_health) # I <3 concatenation SM. 
		
		if health_tween and health_tween.is_running():
			health_tween.kill()
		
		health_tween = create_tween()
		health_tween.tween_property(
			health_bar,
			"value",
			current_health,
			0.25
			)

func show_triumph_screen() -> void:
	triumph_screen.visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 

func _on_triumph_button_pressed() -> void: 
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().reload_current_scene()
