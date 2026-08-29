if (instance_exists(target)) {
    var current_cam_x = camera_get_view_x(view_camera[0]);
    var current_cam_y = camera_get_view_y(view_camera[0]);
    
    // 1. Posición Y objetivo (mantiene al personaje al 60% de la pantalla)
    var target_cam_y = target.y - (cam_h * 0.6);
    
    // 2. Si prefieres que en X siga al personaje (centrado horizontalmente):
    var target_cam_x = target.x - (cam_w / 2);
    target_cam_x = clamp(target_cam_x, 0, room_width - cam_w);
    
    // --- LÓGICA DE CÁMARA ARCADE VERTICAL ---
    // Solo sube si la nueva posición objetivo está MÁS ARRIBA (valor Y menor)
    if (target_cam_y < current_cam_y) {
        
        // Seguir suavemente hacia arriba
        var new_y = lerp(current_cam_y, target_cam_y, 0.1);
        new_y = max(new_y, 0); // No salir por el techo de la room
        
        // Aplicar posición (usamos target_cam_x si quieres seguimiento horizontal o current_cam_x si X es fija)
        camera_set_view_pos(view_camera[0], target_cam_x, new_y);
    } else {
        // Si no sube en Y, mantenemos la Y bloqueada pero actualizamos X si se mueve de lado
        camera_set_view_pos(view_camera[0], target_cam_x, current_cam_y);
    }
}