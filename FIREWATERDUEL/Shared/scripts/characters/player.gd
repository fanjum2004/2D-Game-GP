extends CharacterBody2D

signal died

@export var element: String = "fire"
@export var input_prefix: String = "p1"

const SPEED = 180.0
const JUMP_VELOCITY = -360.0
const PUSH_STRENGTH = 420.0
const PUSH_RANGE = 40.0
const PUSH_COOLDOWN = 0.7

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var alive = true
var push_timer = 0.0


func _ready():
	add_to_group("players")
	if element == "fire":
		modulate = Color(1.0, 0.45, 0.3)
	else:
		modulate = Color(0.35, 0.65, 1.0)


func _physics_process(delta):
	if not alive:
		return

	if push_timer > 0:
		push_timer -= delta

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed(input_prefix + "_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSfx.play()

	var direction = 0.0
	if Input.is_action_pressed(input_prefix + "_right"):
		direction = 1.0
	elif Input.is_action_pressed(input_prefix + "_left"):
		direction = -1.0

	if direction != 0.0:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0
		if is_on_floor():
			$AnimatedSprite2D.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 2.0)
		if is_on_floor():
			$AnimatedSprite2D.play("idle")

	if not is_on_floor():
		$AnimatedSprite2D.play("jump")

	if Input.is_action_just_pressed(input_prefix + "_push") and push_timer <= 0:
		push_timer = PUSH_COOLDOWN
		_try_push()

	move_and_slide()



func _try_push():
	for other in get_tree().get_nodes_in_group("players"):
		if other == self or not other.alive:
			continue
		if position.distance_to(other.position) <= PUSH_RANGE:
			var dir = signf(other.position.x - position.x)
			if dir == 0:
				dir = 1.0
			other.velocity.x = dir * PUSH_STRENGTH
			other.velocity.y = -140.0


func die():
	if not alive:
		return
	alive = false
	visible = false
	set_physics_process(false)
	for c in get_children():
		if c is CollisionShape2D:
			c.set_deferred("disabled", true)
	died.emit()
