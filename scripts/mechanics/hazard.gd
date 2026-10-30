extends Area2D

@export var deadly_to: String = "fire"
@export var active: bool = true


func _ready():
	body_entered.connect(_on_body_entered)
	if has_node("Sprite2D"):
		$Sprite2D.visible = active


func _on_body_entered(body):
	_maybe_kill(body)


func _maybe_kill(body):
	if not active:
		return
	if not body.has_method("die"):
		return
	if deadly_to == "both" or body.element == deadly_to:
		body.die()


func activate():
	active = true
	if has_node("Sprite2D"):
		$Sprite2D.visible = true
	for body in get_overlapping_bodies():
		_maybe_kill(body)


func deactivate():
	active = false
	if has_node("Sprite2D"):
		$Sprite2D.visible = false
