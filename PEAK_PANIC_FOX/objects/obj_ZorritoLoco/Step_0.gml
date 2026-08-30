// -------------------------------------------------------------
// 1. OBTENER ENTRADAS DEL TECLADO
// -------------------------------------------------------------
var key_left  = keyboard_check(vk_left) || keyboard_check(ord("A"));
var key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));

// Registra cuando se presiona el botón por primera vez
var key_jump_pressed = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));

// Registra si se MANTIENE o SE SUELTA el botón
var key_jump_held    = keyboard_check(vk_space) || keyboard_check(ord("W"));
var key_jump_released = keyboard_check_released(vk_space) || keyboard_check_released(ord("W"));

// -------------------------------------------------------------
// 2. CÁLCULO DE MOVIMIENTO HORIZONTAL Y GRAVEDAD
// -------------------------------------------------------------
var move = key_right - key_left;
hsp = move * spd;

vsp += grav;

// 3. Aplicar gravedad
vsp += grav;

// -------------------------------------------------------------
// 4. VERIFICAR SUELO Y CONTROL DE SALTO VARIABLE
// -------------------------------------------------------------
var on_ground = false;
var snap_margin = 4;

if (vsp >= 0) {
    var inst = instance_place(x, y + max(1, vsp + snap_margin), plataforma);
    if (inst != noone) {
        if (bbox_bottom <= inst.bbox_top + snap_margin + vsp) {
            on_ground = true;
            if (!object_is_ancestor(inst.object_index, obj_tierra) && inst.object_index != obj_tierra) {
                safe_x = x;
                safe_y = y;
            }
        }
    }
}

// Iniciar salto completo desde el suelo
if (on_ground && key_jump_pressed) {
    vsp = jump_spd; // Aplica la fuerza máxima de inicio
}

// CORTE DE SALTO VARIABLE:
// Si el jugador suelta el botón mientras el personaje está subiendo, recortamos el impulso
if (key_jump_released && vsp < 0) {
    vsp = vsp * jump_cut;
}

// -------------------------------------------------------------
// 5. COLISIÓN HORIZONTAL (Mantiene tu código actual)
// -------------------------------------------------------------
if (place_meeting(x + hsp, y, solido)) {
    while (!place_meeting(x + sign(hsp), y, solido)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// -------------------------------------------------------------
// 6. COLISIÓN VERTICAL (Con tolerancia para saltos justos)
// -------------------------------------------------------------
if (vsp >= 0) {
    var inst = instance_place(x, y + vsp + snap_margin, plataforma);
    
    if (inst != noone) {
        // Si los pies estaban por encima o dentro del rango de tolerancia respecto al borde superior
        if (bbox_bottom <= inst.bbox_top + snap_margin + vsp) {
            // Posicionamos al personaje exactamente alineado con la parte superior de la plataforma
            y = inst.bbox_top - (bbox_bottom - y);
            vsp = 0;
        }
    }
}

// Aplicar velocidad vertical solo si no aterrizó en este frame
y += vsp;
// -------------------------------------------------------------
// 7. CONTROL DE SPRITES Y ANIMACIONES (Con parpadeo)
// -------------------------------------------------------------
var spr_idle = spr_fox_parao;
var spr_walk = spr_fox_andando;
var spr_jump = spr_fox_saltando;

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

// Manejo del temporizador de invulnerabilidad y efecto visual (parpadeo)
if (invulnerable) {
    inv_timer--;
    image_alpha = (inv_timer mod 6 < 3) ? 0.4 : 1.0; // Cambia transparencia rápidamente
    
    if (inv_timer <= 0) {
        invulnerable = false;
        image_alpha = 1.0; // Restablece visibilidad normal
    }
}

// -------------------------------------------------------------
// 8. COLISIÓN CON ENEMIGOS U OBSTÁCULOS
// -------------------------------------------------------------
var hit_enemy = instance_exists(obj_enemigo) && place_meeting(x, y, obj_enemigo);
var hit_hazard = instance_exists(obj_obstaculo) && place_meeting(x, y, obj_obstaculo);

// Solo activa daño si NO está en periodo de invulnerabilidad
if ((hit_enemy || hit_hazard) && !is_dead && !invulnerable) {
    is_dead = true;
}

// -------------------------------------------------------------
// 9. LÓGICA DE MUERTE, CAÍDA Y RESPAWN
// -------------------------------------------------------------
var current_cam_y = camera_get_view_y(view_camera[0]);
var current_cam_h = camera_get_view_height(view_camera[0]);

// Verificar si cayó por debajo del límite inferior visible de la cámara
if (y > current_cam_y + current_cam_h + 32) {
    is_dead = true;
}

// Procesar la pérdida de 1 sola vida al activarse 'is_dead'
if (is_dead) {
    global.vidas -= 1; // Resta exactametne 1 vida

    if (global.vidas > 0) {
        // Respawn en la última plataforma tocada
        x = safe_x;
        y = safe_y;
        hsp = 0;
        vsp = 0;
        
        // Activar 90 fotogramas (1.5 segundos a 60 FPS) de inmunidad
        invulnerable = true;
        inv_timer = 90;
        
        is_dead = false; // Desbloquea la lógica
    } else {
        // Game Over cuando se acaban las vidas
        if (room_exists(rm_final)) {
            room_goto(rm_final);
        } else {
            game_restart();
        }
    }
}