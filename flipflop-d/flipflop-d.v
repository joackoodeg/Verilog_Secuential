module D_FF (
    input wire D,     // Entrada de datos
    input wire clk,   // Reloj
    input wire reset, // Señal de reset asincrónico
    output reg Q      // Salida Q
);

    always @(posedge clk or posedge reset) begin //Activado por flanco de subida (positivo)
        if (reset) begin
            Q <= 1'b0; // Reset, establece Q a 0
        end else begin
            Q <= D; // Almacena el valor de D en el flanco de subida del reloj
        end
    end

endmodule
