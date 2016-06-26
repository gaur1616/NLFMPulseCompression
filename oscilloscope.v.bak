module oscilloscope( CLOCK_50 , SWTCH ,
				  signal,
                    oVGA_CLK		  ,
                     		 oVS ,
                      		  oHS,
		    		  oBLANK_n,
                      	b_data	  ,
                    		  g_data,
                    		  r_data);

input CLOCK_50;
input SWTCH;
input [15:0] signal;
output oVGA_CLK;
output oVS;
output oHS;
output oBLANK_n;
output reg [7:0]b_data ;
output reg [7:0]g_data ;  
output reg [7:0]r_data;                     

// Variables for VGA Clock 
reg vga_clk_reg;                   
wire iVGA_CLK;

//Variables for (x,y) coordinates VGA
wire [10:0] CX;
wire [9:0] CY;

//Oscilloscope parameters
	//Horizontal
	parameter DivX=10.0;  				// number of horizontal division
	parameter Ttotal=0.000025;   		// total time represented in the screen
	parameter pixelsH=640.0;  		// number of horizontal pixels
	parameter IncPixX=Ttotal/(pixelsH-1.0);				// time between two consecutive pixels
	//Amplitude
	parameter DivY=8.0;  					// number of vertical divisions
	parameter Atotal=16.0;				// total volts represented in the screen
	parameter pixelsV=480.0;  			// number of vertical pixels	
	parameter IncPixY=Atotal/(pixelsV-1.0);	// volts between two consecutive pixels

// Sinusoidal wave amplitude	
parameter Amp=4.0;					// maximum amplitude of sinusoidal wave [-Amp, Amp]
parameter integer Apixels=Amp/IncPixY;	// number of pixels to represent the maximum amplitude	

//Vector to store the input signal (Section 6.1)
parameter integer nc = 9;						
reg [15:0] capturedVals [(nc*256)-1:0]; 		// vector with values of input signal
integer i = 0;							// index of the vector

//Read the signal values from the vector (Section 6.2)
integer j = 0; 								// read the correct element of the vector
parameter integer nf=2; 					//Vector points between two consecutive pixels 

// Sinusoidal movement parameters
parameter integer cf = 1;    //number of frames for each phase change
integer cf_count = 0;     //Counter to count from 0 to cf
integer mov = (nc*256)-nf;       //Phase of sinusoidal wave for each new frames

//Value of the current pixel (Section 6.2 and 6.3)
reg [9:0] ValforVGA; 
reg [9:0] oldValforVGA; 

//////////////////////////////////////////////////////////////////////////////////////////

// 25 MHz clock for the VGA clock

always @(posedge CLOCK_50)
begin
	vga_clk_reg = ~vga_clk_reg;
end
assign iVGA_CLK = vga_clk_reg;

assign oVGA_CLK = ~iVGA_CLK;


// instance VGA controller

VGA_Controller VGA_ins( .reset(1'b0),
                       			.vga_clk(iVGA_CLK),
                    		   	.BLANK_n(oBLANK_n),
                       			.HS(oHS),.VS(oVS),
				 	.CoorX(CX),
					.CoorY(CY)
					);
						

// Store input signal in a vector (Section 6.1)			

always@(negedge CLOCK_50)
begin

	if(i<((nc*256)-1))
		begin		
		i<=i+1;
		capturedVals[i]<=signal;
		end
end


// Read the correct point of the signal stored in the vector and calculate the pixel associated given the amplitude and the parameters of the oscilloscope (Section 6.2)

always@(negedge iVGA_CLK)
begin
	if(oBLANK_n)
		begin
			if(j<(nc*256)-nf)
			begin
				j <=  j + nf;	
			end
			else
			begin
				j<=0;
			end
			ValforVGA <= 239 + Apixels - ((2*Apixels*capturedVals[j])>>16);
		end
	else
		begin
			j<=mov;
		end
end
					

// Calculate the RGB values

always@(negedge iVGA_CLK)
begin 
	oldValforVGA<=ValforVGA;
	if(CY==ValforVGA)
		begin
		r_data<=8'd255;
		b_data<=0;
		g_data<=0;
		end
	else if((CY<oldValforVGA && CY>ValforVGA) || (CY>oldValforVGA && CY<ValforVGA))
		begin
		r_data<=8'd255;
		b_data<=0;
		g_data<=0;
		end
	//display the vertical guide lines
	else if (CX==63||CX==127||CX==191||CX==255||CX==319||CX==383||CX==447||CX==511||CX==575||CX==639)
		begin
		r_data<=8'd255;
		b_data<=255;
		g_data<=255;
		end
	//display the horizontal guide lines
	else if (CY==59||CY==119||CY==179||CY==239||CY==299||CY==359||CY==419||CY==479)
		begin
		r_data<=255;
		b_data<=255;
		g_data<=255;
		end
	
	//Everything else is black
	else
		begin
		r_data<=0;
		b_data<=0;
		g_data<=0;
		end
end

// To force that a displaced signal is sent through the VGA connector after cf frames  

always@(negedge oVS && SWTCH)
begin
	if(cf_count==cf)
	begin  
		cf_count<=0;
		if(mov>=0)
		begin
			mov <=  mov - nf; 
		end
		else
		begin
			mov<=(nc*256)-nf;
		end
	end
	else
	begin
		cf_count <= cf_count + 1;
	end
end

endmodule
