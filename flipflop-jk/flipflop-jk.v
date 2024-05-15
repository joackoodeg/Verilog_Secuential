module JK_FF(
    input wire J, //S
    input wire K, //R
    input wire clk,
    input wire reset,
    output reg Q,
    output wire Q_bar
);
// Asignamos el valor de Q_bar como el complemento de Q
    assign Q_bar = ~Q;

//Bloque siempre sensible al flanco positivo del reloj o del reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0; //Resetea 
    end else begin
            case({J,K})
                2'b00: Q <= Q;        // No cambia
                2'b01: Q <= 1'b0;     // Resetea Q
                2'b10: Q <= 1'b1;     // Setea Q
                2'b11: Q <= ~Q;       // Toggle
                default: Q <= Q;      // Default case (redundante)
            endcase
        end
    end

endmodule

/*
EXTRA:

<=: Operador de asignación no bloqueante
    En los bloques secuenciales (always sensibles al reloj o reset), 
    se utiliza la asignación no bloqueante para garantizar que todas 
    las asignaciones ocurren simultáneamente al final del ciclo de reloj


*/


