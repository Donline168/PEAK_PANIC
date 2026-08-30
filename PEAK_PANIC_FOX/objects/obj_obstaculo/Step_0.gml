// 1. Desplazamiento hacia abajo
y += fall_speed;

// 2. Obtener la posición vertical y altura de la cámara actual
var cam_y = camera_get_view_y(view_camera[0]);
var cam_h = camera_get_view_height(view_camera[0]);

// 3. Autodestrucción si cae por debajo del borde visible inferior (+ 64 píxeles de margen)
if (y > cam_y + cam_h + 64) {
    instance_destroy();
}