target = obj_ZorritoLoco;

// Obtener dimensiones reales de la vista
cam_w = camera_get_view_width(view_camera[0]);  // 320
cam_h = camera_get_view_height(view_camera[0]); // 180

if (instance_exists(target)) {
    // Centrar exactamente en la X del personaje
    var start_x = target.x - (cam_w / 2);
    
    // Posicionar la Y para que el personaje quede en la parte inferior-media
    var start_y = target.y - (cam_h * 0.6);
    
    // Limitar dentro de las dimensiones de la sala (Room)
    start_x = clamp(start_x, 0, room_width - cam_w);
    start_y = clamp(start_y, 0, room_height - cam_h);
    
    camera_set_view_pos(view_camera[0], start_x, start_y);
}