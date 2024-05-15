module JK_FF_Advanced (
    input wire J,         // Entrada J
    input wire K,         // Entrada K
    input wire clk,       // Reloj
    input wire reset_async,  // Reset asincrónico
    input wire enable,    // Señal de habilitación
    output reg Q,        // Salida Q
    output wire Q_bar     // Salida Q_bar
);
// Asignamos el valor de Q_bar como el complemento de Q
    assign Q_bar = ~Q;

    always @(posedge clk or posedge reset_async) begin
        if (reset_async) begin
            Q <= 1'b0;   // Reset asincrónico, establece Q a 0
        end else if (enable) begin
            case ({J, K})
                2'b00: Q <= Q;   // No change
                2'b01: Q <= 1'b0;  // Reset
                2'b10: Q <= 1'b1;  // Set
                2'b11:Q <= ~Q;  // Toggle
                default: Q <= Q;  // Default case (redundante)
            endcase
        end
    end
endmodule


/* OTRO CASO EXPLICITANDO MAS Q_BAR:

   always @(posedge clk or posedge reset_async) begin
        if (reset_async) begin
            Q <= 1'b0;   // Reset asincrónico, establece Q a 0
            Q_bar <= 1'b1; // Reset asincrónico, establece Q_bar a 1
        end else if (enable) begin
            case ({J, K})
                2'b00: begin  // No change
                    Q <= Q;
                    Q_bar <= Q_bar;
                end
                2'b01: begin  // Reset
                    Q <= 1'b0;
                    Q_bar <= 1'b1;
                end
                2'b10: begin  // Set
                    Q <= 1'b1;
                    Q_bar <= 1'b0;
                end
                2'b11: begin  // Toggle
                    Q <= ~Q;
                    Q_bar <= ~Q_bar;
                end
            endcase
        end
    end

*/
