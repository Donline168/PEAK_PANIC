// 1. Obtener entradas del teclado
var key_left  = keyboard_check(vk_left) || keyboard_check(ord("A"));
var key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var key_jump  = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));

// 2. Calcular movimiento horizontal (-1 hacia la izquierda, 1 hacia la derecha, 0 quieto)
var move = key_right - key_left;
hsp = move * spd;

// 3. Aplicar gravedad
vsp += grav;

// 4. Verificar si está en el suelo y saltar
var on_ground = place_meeting(x, y + 1, obj_wall);

if (on_ground && key_jump) {
    vsp = jump_spd;
}

// 5. Colisión Horizontal
if (place_meeting(x + hsp, y, obj_wall)) {
    while (!place_meeting(x + sign(hsp), y, obj_wall)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// 6. Colisión Vertical
if (place_meeting(x, y + vsp, solido)) {
    while (!place_meeting(x, y + sign(vsp), obj_wall)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;


// Cambia estos nombres por los nombres exactos de tus Sprites en el Asset Browser
var spr_idle = spr_fox_parao;    // Sprite quieto
var spr_walk = spr_fox_andando;    // Sprite caminando / corriendo
var spr_jump = spr_fox_saltando;    // Sprite saltando / en el aire

if (!on_ground) {
    // Si está en el aire (saltando o cayendo)
    sprite_index = spr_fox_saltando;
} else {
    // Si está en el suelo
    if (hsp != 0) {
        sprite_index = spr_fox_andando;   // En movimiento
    } else {
        sprite_index = spr_fox_parao;   // Detenido
    }
}

// Voltear el sprite según la dirección hacia la que mira
if (move != 0) {
    image_xscale = move;
}