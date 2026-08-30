// --- Variables de movimiento ---
spd = 4.5;
grav = 0.5;
jump_spd = -10;

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