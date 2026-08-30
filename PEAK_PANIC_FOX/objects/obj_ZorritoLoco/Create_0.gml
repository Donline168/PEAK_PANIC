// --- Variables de movimiento ---
spd = 4.5;            // Velocidad de movimiento horizontal
grav = 0.5;          // Fuerza de la gravedad
jump_spd = -13;      // Fuerza de salto (valor negativo para ir hacia arriba)

// --- Variables de velocidad actual ---
hsp = 0;             // Velocidad horizontal actual
vsp = 0;             // Velocidad vertical actual

// --- Objeto de colisión ---
// Cambia 'obj_wall' por el nombre exacto de tu objeto pared/plataforma sólida
solido = obj_wall;

// --- Sistema de Vidas ---
if (!variable_global_exists("vidas")) {
    global.vidas = 3;
}

// Variable para evitar restar múltiples vidas en un mismo frame de caída
is_dead = false;