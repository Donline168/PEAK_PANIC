if (instance_exists(obj_fox)) {
    var _cam_y = camera_get_view_y(view_camera[0]);
    var _objetivo_y = obj_fox.y - 300;

    // La cámara solo sube para mantener el avance vertical
    if (_objetivo_y < _cam_y) {
        camera_set_view_pos(view_camera[0], 0, _objetivo_y);
    }
}