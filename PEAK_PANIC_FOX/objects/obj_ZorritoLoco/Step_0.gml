// 1. Obtener entradas del teclado
var key_left  = keyboard_check(vk_left) || keyboard_check(ord("A"));
var key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var key_jump  = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));

// 2. Calcular movimiento horizontal
var move = key_right - key_left;
hsp = move * spd;

// 3. Aplicar gravedad
vsp += grav;

// 4. Verificar si está en el suelo
var on_ground = place_meeting(x, y + 1, obj_wall);

// Saltar
if (on_ground && key_jump) {
    vsp = jump_spd;
}

// 5. Colisión Horizontal
if (place_meeting(x + hsp, y, solido)) {
    while (!place_meeting(x + sign(hsp), y, obj_wall)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// 6. Colisión Vertical
if (place_meeting(x, y + vsp, obj_wall)) {
    while (!place_meeting(x, y + sign(vsp), obj_wall)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

// -------------------------------------------------------------
// 7. CONTROL DE SPRITES Y ANIMACIONES
// -------------------------------------------------------------
var spr_idle = spr_fox_parao;    // Sprite quieto
var spr_walk = spr_fox_andando;    // Sprite caminando / corriendo
var spr_jump = spr_fox_saltando;    // Sprite saltando / en el aire

if (!on_ground) {
    sprite_index = spr_jump;
} else {
    if (hsp != 0) {
        sprite_index = spr_walk;
    } else {
        sprite_index = spr_idle;
    }
}

if (move != 0) {
    image_xscale = move;
}

// -------------------------------------------------------------
// 8. LÓGICA DE CAÍDA Y PÉRDIDA DE VIDAS (ARCADE)
// -------------------------------------------------------------
var current_cam_y = camera_get_view_y(view_camera[0]);
var current_cam_h = camera_get_view_height(view_camera[0]);

// Detectar si el personaje cayó por debajo del límite visible de la cámara
if (y > current_cam_y + current_cam_h + 32 && !is_dead) {
    is_dead = true;         // Bloquea ejecuciones repetidas
    global.vidas -= 1;       // Resta una vida

    if (global.vidas > 0) {
        // Aún le quedan vidas: reinicia el nivel actual
        room_restart();
    } else {
        // Se quedaron sin vidas: Fin de la partida
        // Puedes cambiar 'rm_final' por el nombre de tu pantalla de Game Over o reiniciar todo el juego
        if (room_exists(rm_final)) {
            room_goto(rm_final);
        } else {
            game_restart(); // Reinicia el juego completo si no tienes pantalla de Game Over
        }
    }
}