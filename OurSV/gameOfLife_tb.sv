`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic [63:0] seed, grid_evolve;
   logic reset, start, lfsr_begin;
   logic [1:0] curr_state;
   
   integer handle3;
   integer desc3;

   assign seed = 64'b0000_0100_0001_0010_0110_0100_0010_0100_0000_0000_0011_0100_0011_1100_0010_1000;

   // Instantiate DUT
    gameOfLife dut (clk, reset, start, lfsr_begin, seed, grid_evolve, curr_state);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #1 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("gameOfLife.out");
	// Tells when to finish simulation
  desc3 = handle3;
  $fdisplay(desc3, "before  \n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n", seed[63:56], seed[55:48], seed[47:40], seed[39:32], seed[31:24], seed[23:16], seed[15:8], seed[7:0]);
	#1000 $finish;		
     end

   always @(negedge clk)
     begin
	desc3 = handle3;
        $fdisplay(desc3, "State = %b\ninputs: reset = %b, start = %b, lfsr_begin = %b\nafter  \n%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n\n",curr_state, reset, start, lfsr_begin, grid_evolve[63:56], grid_evolve[55:48], grid_evolve[47:40], grid_evolve[39:32], grid_evolve[31:24], grid_evolve[23:16], grid_evolve[15:8], grid_evolve[7:0]);
     end   
   
   initial 
     begin      
    #0 reset = 1'b1;    
        #0 start = 1'b0;
        #0 lfsr_begin = 1'b0;
        #10 reset = 1'b0;
    #0 start = 1'b1;
    #20 lfsr_begin = 1'b1;
    #0 start = 1'b0;
    #20 start = 1'b1;
    #0 lfsr_begin = 1'b0;

     end

endmodule // gameOfLife_tb