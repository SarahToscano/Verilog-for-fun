module LS161a(
    input [3:0] D,        // Parallel Input
    input CLK,            // Clock
    input CLR_n,          // Active Low Asynchronous Reset
    input LOAD_n,         // Enable Parallel Input
    input ENP,            // Count Enable Parallel
    input ENT,            // Count Enable Trickle
    output [3:0]Q,        // Parallel Output 	
    output RCO            // Ripple Carry Output (Terminal Count)
); 

	reg [3:0] counter;
	reg cout;
	
	always@(posedge CLK) begin
		if (CLR_n==1'b0) begin
			counter=4'b0000;
			cout = 1'b0;
		end
		else begin
			if(LOAD_n==1'b0) begin
				counter=D;
			end
			else if ((ENP == 1'b1) & (ENT == 1'b1))  begin
				if(counter==4'b1111) begin
					cout<=1'b1; 
					counter<=4'b0000;
				end
				else begin 
					counter<=counter+1; 
					cout<=1'b0; 
				end
			end
		end
	end
	
	assign Q = counter;
	assign RCO = cout;
	
endmodule
