extends Control

@onready var health_component: HealthComponent = $HealthComponent

@onready var health_label: Label = %HealthLabel
@onready var health_bar: ProgressBar = %HealthBar
@onready var damage_amount: SpinBox = %DamageAmount
@onready var healing_amount: SpinBox = %HealingAmount
@onready var resurrect_amount: SpinBox = %ResurrectAmount

@onready var death_overlay: TextureRect = %DeathOverlay
@onready var death_label: Label = %DeathLabel

func _ready() -> void:
	death_overlay.hide()
	_on_health_component_health_changed(health_component.current_health, health_component.max_health)

func _on_health_component_health_changed(current_amount: int, max_amount: int) -> void:
	health_label.text = "Current: %s | Maximum: %s" % [current_amount, max_amount]
	health_bar.max_value = max_amount
	health_bar.value = current_amount

func _on_damage_button_pressed() -> void:
	health_component.take_damage(int(damage_amount.value))

func _on_healing_button_pressed() -> void:
	health_component.take_healing(int(healing_amount.value))

func _on_rez_plz_pressed() -> void:
	health_component.resurrect(int(resurrect_amount.value))

func _on_health_component_died(overkill: int) -> void:
	death_label.text = "You died... by %s amount!" % overkill
	death_overlay.modulate = Color.TRANSPARENT
	death_overlay.show()
	await tween_death_overlay(Color.WHITE)

func _on_health_component_resurrected() -> void:
	await tween_death_overlay(Color.TRANSPARENT)
	death_overlay.hide()

func tween_death_overlay(to_color: Color) -> void:
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(death_overlay, "modulate", to_color, 0.5)
	await tween.finished

func _on_spin_box_value_changed(value: float) -> void:
	health_component.max_health = int(value)

func _on_god_mode_toggled(toggled_on: bool) -> void:
	health_component.god_mode = toggled_on

func _on_exceed_max_toggled(toggled_on: bool) -> void:
	health_component.exceed_maximum_health = toggled_on

func _on_heal_difference_toggled(toggled_on: bool) -> void:
	health_component.heal_difference = toggled_on


func _on_label_meta_clicked(_meta: Variant) -> void:
	OS.shell_open(str("https://pixel-boy.itch.io/icon-godot-node"))
