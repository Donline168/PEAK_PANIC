if (instance_exists(obj_ZorritoLoco)) {
    // 1. Posición Y actual de la cámara
    var cam_y = camera_get_view_y(view_camera[0]);
    
    // 2. Altura a la que debe ir la cámara (mantiene al zorro en la parte media/baja)
    var objetivo_y = obj_ZorritoLoco.y - 450;

    // 3. SOLO SUBIR: Si el zorro llega más arriba de donde está la cámara, la cámara sube
    if (objetivo_y < cam_y) {
        // Usa lerp para que el movimiento hacia arriba sea suave y no brusco
        var nueva_y = lerp(cam_y, objetivo_y, 0.1);
        camera_set_view_pos(view_camera[0], 0, nueva_y);
    }
}