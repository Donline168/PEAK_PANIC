// Evento Step
// Si el jugador está sobre esta plataforma, iniciamos la cuenta regresiva
if (!touch_started && instance_exists(obj_ZorritoLoco)) {
    if (place_meeting(x, y - 1, obj_ZorritoLoco)) {
        touch_started = true;
        alarm[0] = tiempo_desaparicion * game_get_speed(gamespeed_fps);
    }
}