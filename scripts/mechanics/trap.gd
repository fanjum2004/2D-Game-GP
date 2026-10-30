extends Area2D

@export var hazard_path: NodePath
@export var arm_delay: float = 0.7
@export var active_duration: float = 1.3
@export var reset_delay: float = 0.6

var hazard: Node = null
var triggered: bool = false


func _ready():
	body_entered.connect(_on_body_entered)
	if hazard_path != NodePath():
		hazard = get_node(hazard_path)


func _on_body_entered(body):
	if triggered or hazard == null:
		return
	if not body.is_in_group("players"):
		return
	_trigger()


func _trigger():
	triggered = true
	$IdleSprite.visible = false
	$ArmedSprite.visible = true

	await get_tree().create_timer(arm_delay).timeout
	hazard.activate()

	await get_tree().create_timer(active_duration).timeout
	hazard.deactivate()
	$IdleSprite.visible = true
	$ArmedSprite.visible = false

	await get_tree().create_timer(reset_delay).timeout
	triggered = false
