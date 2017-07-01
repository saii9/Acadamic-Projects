 `timescale 1ns / 1ps

module test;

reg door;
reg [3:0]row;
reg [2:0]col;
wire [4:0]lights;
wire key_signal;

elock_init uut(
  .door(door),
  .row(row),
  .col(col),
  .lights(lights),
  .key_signal(key_signal));

initial begin
$write("Test bench started \n");
	door = 1;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;

$write("------------------- Arming ---------------------------------------	 \n");
	row = 4'b0001;
	col = 4'b001;
	
	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
$write("--------------------Pass key Enter-------------------------------------- \n");
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
		
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
	row = 4'b0100; // 5
	col = 4'b010;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
	row = 4'b0100; // 5
	col = 4'b010;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
$write("--------------------------door close-------------------------------- \n");
	#200;
	door = 0;
	#500;
	door = 1;
	
$write("----------------------------trying to make alarm go off------------------------------	 \n");
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
		
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
	row = 4'b0100; // 5
	col = 4'b010;

	#200;
	
	row = 4'b0000;
	col = 4'b000;

	#700;
	
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
		
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
	row = 4'b0100; // 5
	col = 4'b010;

	#200;
	
	row = 4'b0000;
	col = 4'b000;

$write("----------------------------trying to unarm after alarm goes off------------------------------		 \n");
	
	#600;
	
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
		
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
	row = 4'b0100; // 5
	col = 4'b010;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
	row = 4'b0100; // 5
	col = 4'b010;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#600;
	
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
		
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
	
	row = 4'b1000; // 1
	col = 4'b100;

	#200;
	
	row = 4'b0000;
	col = 4'b000;
	
	#200;
		
	row = 4'b1000; // 1
	col = 4'b100;

end

endmodule

/*
	row = 4'b0001; // *
	col = 4'b100;

	row = 4'b0001; // #
	col = 4'b001;

	row = 4'b1000; // 1
	col = 4'b100;

	row = 4'b1000; // 2
	col = 4'b010;

	row = 4'b1000; // 3
	col = 4'b001;

	row = 4'b0100; // 4
	col = 4'b100;

	row = 4'b0100; // 5
	col = 4'b010;

	row = 4'b0100; // 6
	col = 4'b001;

	row = 4'b0010; // 7
	col = 4'b100;

	row = 4'b0010; // 8
	col = 4'b010;

	row = 4'b0010; // 9
	col = 4'b001;

	row = 4'b0001; // 0
	col = 4'b010;

*/