// Reinicio por pérdida de vidas
if (global.vidas <= 0) {
    game_restart();
}

// Condición de Victoria: Alcanzar la cima (ejemplo: 5000 puntos)
var _puntaje_objetivo = 5000;

if (global.puntos >= _puntaje_objetivo) {
    if (room_exists(rm_final)) {
        room_goto(rm_final);
    }
}