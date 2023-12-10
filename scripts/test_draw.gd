extends CanvasItem

class_name TestDraw

var _center: Vector2
var _radius: float

func set_parameters(center: Vector2, radius: float):
	_center = center
	_radius = radius
	print("cennter ", center, " radius ", radius)
	queue_redraw()

func _draw():
	print("drawing")
	draw_arc(_center, _radius, 0, 360, 32, Color.RED, 5)
