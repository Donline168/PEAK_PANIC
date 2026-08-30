// Tiempo entre apariciones (expresado en fotogramas / frames)
// En un juego a 60 FPS, 60 frames equivalen a 1 segundo.
spawn_rate_min = 30;   // Mínimo 1 segundo
spawn_rate_max = 120;  // Máximo 3 segundos

// Iniciar la primera cuenta regresiva con un tiempo aleatorio
alarm[0] = irandom_range(spawn_rate_min, spawn_rate_max);