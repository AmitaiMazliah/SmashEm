extends CollisionShape2D

@export_color_no_alpha var highlight_color : Color
@export var width : float = 4

func _draw():
	var radius = shape.radius
	draw_arc(position, radius, 0, 360, 32, highlight_color, width)
