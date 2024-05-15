module T_FF (
    input wire T,     // Entrada T
    input wire clk,   // Reloj
    input wire reset, // Señal de reset asincrónico
    output reg Q      // Salida Q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0; // Reset, establece Q a 0
        end else begin
            if (T) begin
                Q <= ~Q; // Invierte Q en el flanco de subida del reloj si T es 1
            end
        end
    end

endmodule
