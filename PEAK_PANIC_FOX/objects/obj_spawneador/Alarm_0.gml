// 1. Obtener la posición actual de la cámara
var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
var cam_w = camera_get_view_width(view_camera[0]);

// 2. Definir márgenes para que no aparezcan justo en el borde exacto de la pantalla
var margin = 32; 

// 3. Generar una coordenada X aleatoria entre la parte izquierda y derecha de la vista
var random_x = random_range(cam_x + margin, cam_x + cam_w - margin);

// 4. Posición Y justo por encima del borde superior visible de la cámara
var spawn_y = cam_y - 32;

// 5. Crear la instancia del obstáculo
instance_create_layer(random_x, spawn_y, "Instancias_personaje", obj_obstaculo);

// 6. Reiniciar la alarma con un nuevo intervalo aleatorio
alarm[0] = irandom_range(spawn_rate_min, spawn_rate_max);