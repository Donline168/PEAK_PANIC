// --- 1. DESACTIVAR INTERPOLACIÓN POR CÓDIGO (Doble seguridad) ---
gpu_set_texfilter(false);

// --- 2. CONFIGURAR LA RESOLUCIÓN DE CÁMARA BASE ---
var cam_w = 250; // Ancho base de cámara (10 tiles de 32px)
var cam_h = 320; // Alto base de cámara (5.6 tiles de 32px)

// Habilitar la vista 0
view_enabled = true;
view_visible[0] = true;

// Ajustar el tamaño del encuadre
camera_set_view_size(view_camera[0], cam_w, cam_h);

// --- 3. ESCALADO PERFECTO A PANTALLA COMPLETA ---
// Obtener el ancho y alto del monitor del jugador
var display_w = display_get_width();
var display_h = display_get_height();

// Ajustar el lienzo (surface) y el viewport al tamaño de la pantalla
surface_resize(application_surface, cam_w, cam_h);
view_set_wport(0, display_w);
view_set_hport(0, display_h);

// Poner el juego en pantalla completa
window_set_fullscreen(true);