// 1. Dibujar el Puntaje en la esquina superior izquierda
draw_set_color(c_white); // Color de texto blanco
draw_text(20, 20, "PUNTAJE: " + string(global.puntos));

// 2. Dibujar las Vidas
draw_text(20, 40, "VIDAS: " + string(global.vidas));