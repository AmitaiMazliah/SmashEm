extends CollisionShape2D

@export_color_no_alpha var highlight_color : Color
@export var width : float = 4

func _draw():
	var radius = shape.radius
	draw_circle_arc(self.position, radius, 0 , 360, highlight_color, width)

func draw_circle_arc(center, radius, angle_from, angle_to, color, width: float = -1):
	var nb_points = 32
	var points_arc = PackedVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color, width)
