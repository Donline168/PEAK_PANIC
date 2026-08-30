// --- Variables de movimiento ---
spd = 4.5;
grav = 0.5;
// Fuerza de salto
jump_spd = -15;      // Salto MÁXIMO (mantenido)
jump_spd_min = -7;   // Salto MÍNIMO (un solo toque rápido)
jump_cut = 0.45;     // Factor para cortar el impulso al soltar el botón (entre 0 y 1)

hsp = 0;
vsp = 0;

solido = obj_calle;
plataforma = obj_techito

// --- Sistema de Vidas ---
if (!variable_global_exists("vidas")) {
    global.vidas = 3;
}

is_dead = false;

// --- Invulnerabilidad al recibir daño ---
invulnerable = false; // Indica si el personaje es inmune temporalmente
inv_timer = 0;        // Contador para quitar la invulnerabilidad

// --- Registro de Posición Segura ---
safe_x = x;
safe_y = y;