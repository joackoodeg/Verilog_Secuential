`timescale 1ns / 1ps
`default_nettype none
`define DUMPSTR(x) `"x.vcd`"

module JK_FF_Advanced_tb;

    // Parámetros de tiempo
    parameter PERIOD = 10; // Periodo del reloj (en unidades de tiempo)
    
    // Declaración de señales
    reg J;               // Entrada J
    reg K;               // Entrada K
    reg clk;             // Reloj
    reg reset_async;     // Reset asincrónico
    reg enable;          // Señal de habilitación
    wire Q;              // Salida Q
    wire Q_bar;          // Salida Q_bar

    // Instancia del flip-flop JK avanzado
    JK_FF_Advanced uut (
        .J(J),
        .K(K),
        .clk(clk),
        .reset_async(reset_async),
        .enable(enable),
        .Q(Q),
        .Q_bar(Q_bar)
    );

    // Generación del reloj
    always #((PERIOD / 2)) clk = ~clk; // Genera un ciclo de reloj de 50% de duty cycle

    // Inicialización de señales
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, JK_FF_Advanced_tb);

        clk = 0;
        reset_async = 1; // Activa el reset asincrónico inicialmente
        enable = 0;      // Desactiva la señal de habilitación inicialmente
        #100;            // Espera un poco de tiempo
        reset_async = 0; // Desactiva el reset asincrónico
        #100;            // Espera un poco de tiempo

        // Prueba de diferentes valores de entrada J y K con habilitación desactivada
        #10 J = 0; K = 0; #10 J = 0; K = 1; #10 J = 1; K = 0; #10 J = 1; K = 1;
        #100; // Espera un poco de tiempo

        // Habilita la señal de habilitación
        enable = 1;
        #100; // Espera un poco de tiempo

        // Prueba de diferentes valores de entrada J y K con habilitación activada
        #10 J = 0; K = 0; #10 J = 0; K = 1; #10 J = 1; K = 0; #10 J = 1; K = 1;
        #100; // Espera un poco de tiempo

        // Finaliza la simulación
        $finish;
    end

    // Monitorear cambios en las señales
    initial begin
        $monitor("Time=%0t, J=%b, K=%b, clk=%b, reset_async=%b, enable=%b, Q=%b, Q_bar=%b", $time, J, K, clk, reset_async, enable, Q, Q_bar);
    end

endmodule

/*
    Un ciclo de reloj de 50% de duty cycle se refiere a un ciclo de reloj donde la señal 
    de reloj pasa la mitad del tiempo en estado alto y la otra mitad del tiempo en estado 
    bajo durante cada período del reloj. Esto significa que el tiempo que la señal de reloj 
    permanece en estado alto es igual al tiempo que permanece en estado bajo.


        ____       ____       ____       ____       ____       ____       ____   
        |    |     |    |     |    |     |    |     |    |     |    |     |    |  
    ____|    |_____|    |_____|    |_____|    |_____|    |_____|    |_____|    |_
        ↑             ↑             ↑             ↑             ↑             ↑   
    Tiempo         Tiempo        Tiempo        Tiempo        Tiempo        Tiempo 
    Transcurrido   Transcurrido  Transcurrido  Transcurrido  Transcurrido  Transcurrido
    (Alto)         (Bajo)        (Alto)        (Bajo)        (Alto)        (Bajo)

*/