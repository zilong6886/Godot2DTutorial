extends Node2D

onready var explode = preload("res://scenes/Explosion.tscn").instance()

var sprite = null;

const sprites = [
	"enemy1_blue.png",
	"enemy1_green.png",
	"enemy1_red.png",
	"enemy1_yellow.png",
	"enemy2_blue.png",
	"enemy2_green.png",
	"enemy2_red.png",
	"enemy2_yellow.png",
]

var speed = 100

func _ready():
	speed = speed + (globals.currentStage * 10)

func _enter_tree():
	sprite = Sprite.new()
	sprite.texture = load("res://assets/graphics/enemies/" + sprites[randi()%sprites.size()])
	add_child(sprite)

func _process(delta):
	move_local_x(-speed*delta)
	
func _on_Area2D_area_entered(area):
	# Hit by bullet
	if area.get_collision_layer_bit(3):
		explode.set_position(self.get_position())
		get_parent().add_child(explode)
		globals.kills = globals.kills + 1
		queue_free()
