extends Node2D

var item = 0
var active_node: Node2D = null
var velocity := Vector2.ZERO
var rotation_speed := 0.0

var spawning_enabled := true

const MIN_SPAWN_TIME = 10.0
const MAX_SPAWN_TIME = 15.0

const PLANET_POSITION = Vector2(300, 1500)
const GRAVITY_STRENGTH = 450000.0

@onready var timer = $Timer 
@onready var small_satellite = $"Small satelltite"
@onready var large_satellite = $"Large satellite"
@onready var scrap = $Scrap

func _ready() -> void:
	randomize_next_spawn_time()

func _process(delta: float) -> void:
	if active_node and active_node.visible:
		var vector_to_planet = PLANET_POSITION - active_node.global_position
		var distance = vector_to_planet.length()
		var direction = vector_to_planet.normalized()
		
		var gravity_force = direction * (GRAVITY_STRENGTH / (distance * distance))
		velocity += gravity_force * delta
		
		active_node.global_position += velocity * delta
		active_node.rotation += rotation_speed * delta
		
		if active_node.global_position.x < -150:
			disable_active_node()

func _on_timer_timeout() -> void:
	randomize_next_spawn_time()
	
	if not spawning_enabled:
		return
		
	item = randi_range(1, 3)
	if item == 1:
		pick_small()
	elif item == 2:
		pick_large()
	else:
		pick_scrap()

func randomize_next_spawn_time() -> void:
	if timer:
		timer.wait_time = randf_range(MIN_SPAWN_TIME, MAX_SPAWN_TIME)
		timer.start()

func reset_and_launch(node: Node2D):
	disable_active_node()
	
	small_satellite.hide()
	large_satellite.hide()
	scrap.hide()
	
	node.show()
	node.global_position = Vector2(600, randi_range(0, 960))
	velocity = Vector2(-150, -45)
	rotation_speed = randf_range(-1.5, 1.5)
	
	if node.has_method("set_deferred"):
		node.set_deferred("monitoring", true)
		node.set_deferred("monitorable", true)
	
	active_node = node

func disable_active_node():
	if active_node:
		active_node.hide()
		if active_node.has_method("set_deferred"):
			active_node.set_deferred("monitoring", false)
			active_node.set_deferred("monitorable", false)

func stop_spawning() -> void:
	spawning_enabled = false
	timer.stop() 

func start_spawning() -> void:
	spawning_enabled = true
	randomize_next_spawn_time()

func pick_small():
	reset_and_launch(small_satellite)

func pick_large():
	reset_and_launch(large_satellite)

func pick_scrap():
	reset_and_launch(scrap)

func _on_scrap_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	disable_active_node()

func _on_large_satellite_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	disable_active_node()

func _on_small_satelltite_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	disable_active_node()
