extends RigidBody2D

class_name Agent2D

signal moved
signal turn_ended

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@export var starting_velocity: float = 5
@export var starting_health: int = 100
@export var starting_damage: int = 5

var is_my_turn: bool
var moving: bool
var current_velocity: float
var max_health: int
var current_health: int
var current_damage: int
var previous_velocity: Vector2
var is_player: bool

var is_being_aimed: bool :
	set(value):
		is_being_aimed = value
		queue_redraw()
	get: return is_being_aimed

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	current_velocity = starting_velocity
	max_health = starting_health
	current_health = max_health
	current_damage = starting_damage

func _physics_process(_delta) -> void:
	if linear_velocity.length_squared() > 2:
		moving = true
	elif linear_velocity.length_squared() < 2:
		moving = false
	previous_velocity = linear_velocity

func move(direction: Vector2) -> void:
	if is_my_turn:
		print(name, " is moving in direction=", direction, " speed=", current_velocity)
		apply_impulse(direction * current_velocity)
		moved.emit()

func start_turn() -> void:
	print(self.name, " turns has started")
	is_my_turn = true

func end_turn() -> void:
	print(self.name, " turns has ended")
	is_my_turn = false
	turn_ended.emit()

func take_damage(damage: int) -> void:
	current_health -= damage
	print(name, " took ", damage, " and left with current_health ", current_health)

func heal(amount: int) -> void:
	current_health += amount
	if (current_health > max_health):
		current_health = max_health
	print(name, " healed ", amount, " and now has current_health ", current_health)

func die() -> void:
	print(name, " is now dead")
	queue_free()

func _on_body_entered(body: Node) -> void:
	if !is_my_turn and body is Agent2D:
		var attacker = body as Agent2D
		take_damage(attacker.current_damage)

func _draw() -> void:
	if is_being_aimed:
		draw_arc(Vector2.ZERO, collision_shape.shape.radius, 0, 360, 64, Color.RED, 2)
