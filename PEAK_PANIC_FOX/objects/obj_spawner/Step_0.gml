var _cam_y = camera_get_view_y(view_camera[0]);

while (ultima_y > _cam_y - 100) {
    ultima_y -= 110; // Distancia vertical entre saltos
    var _random_x = irandom_range(60, room_width - 60); // Mantener dentro del margen vertical
    
    instance_create_layer(_random_x, ultima_y, "Instances", obj_plataforma);
}

// Eliminar plataformas antiguas
with (obj_plataforma) {
    if (y > _cam_y + camera_get_view_height(view_camera[0]) + 100) {
        instance_destroy();
    }
}