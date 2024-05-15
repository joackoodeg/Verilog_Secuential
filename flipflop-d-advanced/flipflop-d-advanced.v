module D_FF_Advanced (
    input wire D,         // Entrada de datos
    input wire clk,       // Reloj
    input wire reset_async,  // Reset asincrónico
    input wire reset_sync,   // Reset síncrono
    input wire enable,    // Señal de habilitación
    output reg Q         // Salida Q
);

    always @(posedge clk or posedge reset_async or posedge reset_sync) begin
        if (reset_async) begin
            Q <= 1'b0;  // Reset asincrónico, establece Q a 0
        end else if (reset_sync) begin
            Q <= 1'b0;  // Reset síncrono, establece Q a 0 en el flanco de subida del reloj
        end else if (enable) begin
            Q <= D;     // Almacena el valor de D en el flanco de subida del reloj si la señal de habilitación está activa
        end
    end

endmodule
