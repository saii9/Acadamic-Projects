`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Wayne state university FPGA
// Engineer: Sundeep,
// 
// Create Date:    16:37:37 04/03/2016 
// Design Name: keypad based electonic door lock
// Module Name:    ecode 
// Project Name: electronic lock system
// Description: to lock a door by a keypad lock
//////////////////////////////////////////////////////////////////////////////////
module ecode(
input wire arm,   //pound is to arm
input wire unarm, //star is to arm 
input wire openreq,
input wire [15:0]keys,
output reg[4:0] lights,
input wire door
);

//states   auarmed     locked      open        alarm
parameter S0 = 3'b000, S1 =3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100 ;


//reg[15:0] keys=keysw;
//reg [15:0]keys;
reg [2:0]state = S0;
reg [3:0]s1failcount=0;
reg [3:0]s2pchangeflag=0;
reg [3:0]s4keyflag=0;
reg [15:0]pass = 16'h1155;
parameter mpass = 16'h1111;
wire iedge;


always @(posedge door)
begin
	//$write("door command recieved \n");
	if (state == S2)
	begin
		//$write("state going from S2 to S1 on door close \n");
		state = S1;
	end 
end

assign iedge= arm || unarm || openreq;

/*
always @(posedge unarm) 
	//$write("unarm command recieved \n");

always @(posedge arm) 
	//$write("arm command recieved \n");

always @(posedge openreq)
	//$write("open req command recieved : the key = %h\n",keys);
*/

always @(posedge iedge)
	begin
		//$write(" running code on posedge	\n");
		case(state)
/*unarmed*/	S0:if(arm == 1)
					begin
						//$write(" State S0 -> S1	:# - Arm command\n");
						state <= S1;
					end
/*locked*/	S1:if(pass == keys)
						begin
							//$write(" State locked S1 -> S2 open:correct key %h\n",keys);
							state <= S2;
							s1failcount <= 0;
						end
					else
						begin
							if(s1failcount <= 0)	
								begin
								
									s1failcount <= s1failcount + 1;
									//$write(" State locked S1 -> S3 fail:incorrect key  count%h\n",s1failcount);
									state <= S3;
									#250
									//$write(" State fail S3 -> S1 locked\n");
									state <= S1;
								end
							else 
								begin
									//$write(" State locked S1 -> S4 alarm\n");
									state <= S4;
									s1failcount <= 0;
								end
						end
			
      		S2:if(arm == 1) 	
					begin
						//$write(" State open S2 -> S1 locked on #\n");
						state <= S1;
					end
					else if(door == 1) 
						begin
							//$write(" State open S2 -> S1 locked on door\n");
							state<=S1;
						end
					else if(unarm == 1) 
						begin
							//$write(" State open S2 -> S0 unarmed on *\n");
							state <= S0;
						end
					else if(openreq == 1) 
						begin
							//$write(" Password Change attempt\n");
							if (s2pchangeflag == 1)
								begin
									//$write(" Password Change : new passkey entered %h\n",keys);
									pass <= keys;
								end
							else if(mpass == keys)
								begin
									//$write(" Password Change : master passkey entered %h\n",keys);
									s2pchangeflag <= 1;
								end
							else 
								begin
									//$write(" Password Change : incorrect master passkey entered %h\n",keys);
									s2pchangeflag <= 0;
								end
						end
				S4: if((mpass == keys) && (s4keyflag == 1))
						begin
							//$write(" State alarm S4 -> S0 unarm, master passkey entered\n");							
							state <= S0;
							s4keyflag <= 0;
						end
					 else if((pass == keys) && (s4keyflag == 0))
						begin
							//$write(" Alarm pass key entered, enter master passkey to unarm\n");							
							s4keyflag <= 1;
						end
					else
						begin
							//$write(" Alarm Wrong key: passkey first and master key next, Entered:%h\n",keys);
							s4keyflag <= 0;
							//$write(" State alarm S4 -> S3 fail\n");							
							state <= S3;
							#250
							//$write(" State fail S3 -> S4 alarm\n");
							state <= S4;
						end
		
			default state <= S0;
	endcase
end

always @(*)
	begin
		case(state) //bits stnd for : alarm,locked,armed,fail,open
				S0: lights = 5'b00000;  //unarmed
				S1: lights = 5'b01100;	//locked
				S2: lights = 5'b00101;	//open
				S3: lights = 5'b01110;  //fail
				S4: lights = 5'b11100;  //alarm
		  default lights = 5'b00000;  //unarmed
		endcase
	end
endmodule
	

module key_scan(	input wire [3:0] row ,
						input wire [2:0] col ,
						output wire armw,
						output wire unarmw, 
						output wire [15:0] keysw,
						output wire openreqw,
						output wire key_signal
						);


reg arm;
reg unarm;
reg [15:0] keys;
reg openreq;
					

reg [1:0] rower;
reg [1:0] column;
reg [2:0] count= 0;
reg [3:0] key_press;
reg [15:0] key_com;

//wire key_signal;
assign key_signal=row[0]|row[1]|row[2]|row[3];

always@(posedge key_signal)
	begin
		//$write("key Scan :Scanning \n");
		if(row[0]&col[2])
		begin
			//$write("key Scan :un Arming \n");
			unarm = 1 ;
		end
		else if(row[0]&col[0])
		begin
			//$write("key Scan :Arming \n");
			arm = 1 ;
		end
		else
		begin
			//$write("key Scan : row : %b , col : %b\n",row,col);
			
				  if(row[3] == 1) rower = 2'b00;
			else if(row[2] == 1) rower = 2'b01;
			else if(row[1] == 1) rower = 2'b10;
			else if(row[0] == 1) rower = 2'b11;
		
				  if(col[2] == 1) column = 2'b00;
			else if(col[1] == 1) column = 2'b01;
			else if(col[0] == 1) column = 2'b10;
			
			//$write("key Scan : rower : %b , column : %b\n",rower,column);
			
			
			if(row[0] & col[1]) key_press = 1'hA;
			else if(row[3] & col[2]) begin
			key_press = 1'h1;
			//$write("key Scan one : pressed key : %h\n",key_press);
			
			end
			else key_press = 4'b0001 + rower * 3 + column;
			//$write("key Scan : pressed key : %h\n",key_press);
			
			if(count == 0) key_com = 4'h0000;
			if(count < 3)
				begin
					//$write("key Scan 1: key_com : %h\n",key_com);
					key_com = key_com << 4;
					//$write("key Scan 2: key_com : %h\n",key_com);
					key_com = key_com + key_press ;
					//$write("key Scan 3: key_com : %h\n",key_com);								
					count = count + 1;
					//$write("key Scan 4: count : %h\n",count);
			
				end
			else
				begin
					//$write("key Scan 1: key_com : %h\n",key_com);
					key_com = key_com << 4;
					//$write("key Scan 2: key_com : %h\n",key_com);
					key_com = key_com + key_press ;
					//$write("key Scan 3: key_com : %h\n",key_com);								
					keys = key_com; 
					key_com = 16'b0 ;
					//$write("key Scan 4: Requesting open : %h\n",key_com);
					openreq = 1;
					count = 0;
				end
			
			#200;
			openreq=0;
			arm = 0;
			unarm = 0;
		end
	end
	
	assign armw = arm;
	assign keysw = keys;
	assign openreqw = openreq;
	assign unarmw = unarm;
	
endmodule

module elock_init (
input wire door,
input wire [3:0] row ,
input wire [2:0] col ,
output wire [4:0] lights,
output wire key_signal
);

wire [15:0]keys;
wire openreq;
wire arm;
wire unarm;

key_scan U1(.row(row),
				.col(col),
				.armw(arm),
				.unarmw(unarm),
				.keysw(keys),
				.openreqw(openreq),
				.key_signal(key_signal)
				);

ecode U2(.arm(arm),   //pound is to arm
			.unarm(unarm), //star is to arm 
			.openreq(openreq),
			.keys(keys),
			.lights(lights),
			.door(door)
			);

endmodule
