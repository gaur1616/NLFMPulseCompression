module  signal_generator(CLOCK_50, 
				  signal);
					 

input CLOCK_50;
output [15:0] signal;


//Signal generator elements
reg [7:0] sinAddr = 0;
reg [15:0] sine;

//Variables to hold captured values
reg [15:0] signal; //vector with values of ROM

//Variables for FM generation
integer edge_cnt = 0;
reg [7:0] count = 8'd2;
integer tgrid_count=0;//
integer tgrid1=175;//T1 for frequency function change
parameter integer fgridcount = 320;//Symbol duration for pulse
integer flipped = 0;//Phase shifter

always@(posedge CLOCK_50)
begin
	signal <= sine;
	sinAddr <= sinAddr + count;
	
	if(tgrid_count>(fgridcount+319))
	begin
		tgrid_count = 0;
		edge_cnt = 0;
		flipped = 0;
		count = 8'd2;
		sinAddr <= 8'd0;
	end
	else if(tgrid_count>fgridcount)
	begin
		sinAddr <= 8'd0;
		count = 8'd0;
	end 
	else
	begin
		if (tgrid_count>tgrid1 && flipped==0)
		begin		
			count = 8'd6;
			sinAddr <= 8'd64;
			flipped = 1;
		end
		if(edge_cnt == 150)
		begin
			edge_cnt = 0;
			if(count<=8'd4)
			begin
				count <= count+8'd2;
			end
			else if (count>8'd4)
			begin
				count <= count+8'd4;
			end
		end
		edge_cnt = edge_cnt + 1;
	end
	
	tgrid_count=tgrid_count+1;
end


//Sin Wave ROM Table
always@(sinAddr)
	begin
		case(sinAddr)
			8'd0: sine = 16'd32768 ;
			8'd1: sine = 16'd33572 ;
			8'd2: sine = 16'd34376 ;
			8'd3: sine = 16'd35179 ;
			8'd4: sine = 16'd35980 ;
			8'd5: sine = 16'd36779 ;
			8'd6: sine = 16'd37576 ;
			8'd7: sine = 16'd38370 ;
			8'd8: sine = 16'd39161;
			8'd9: sine = 16'd39948 ;
			8'd10: sine = 16'd40730 ;
			8'd11: sine = 16'd41508 ;
			8'd12: sine = 16'd42280 ;
			8'd13: sine = 16'd43047 ;
			8'd14: sine = 16'd43807 ;
			8'd15: sine = 16'd44561 ;
			8'd16: sine = 16'd45308 ;
			8'd17: sine = 16'd46047 ;
			8'd18: sine = 16'd46778 ;
			8'd19: sine = 16'd47501;
			8'd20: sine = 16'd48215;
			8'd21: sine = 16'd48919 ;
			8'd22: sine = 16'd49614 ;
			8'd23: sine = 16'd50299 ;	
			8'd24: sine = 16'd50973 ;
			8'd25: sine = 16'd51636 ;
			8'd26: sine = 16'd52288 ;
			8'd27: sine = 16'd52928 ;
			8'd28: sine = 16'd53556 ;
			8'd29: sine = 16'd54171 ;
			8'd30: sine = 16'd54774 ;
			8'd31: sine = 16'd55363 ;			
			8'd32: sine = 16'd55938;
			8'd33: sine = 16'd56500 ;
			8'd34: sine = 16'd57047 ;
			8'd35: sine = 16'd57580 ;
			8'd36: sine = 16'd58098 ;
			8'd37: sine = 16'd58601 ;
			8'd38: sine = 16'd59088 ;
			8'd39: sine = 16'd59559 ;		
			8'd40: sine = 16'd60014;
			8'd41: sine = 16'd60452 ;
			8'd42: sine = 16'd60874 ;
			8'd43: sine = 16'd61279;
			8'd44: sine = 16'd61667;
			8'd45: sine = 16'd62037 ;
			8'd46: sine = 16'd62390 ;
			8'd47: sine = 16'd62725 ;	
			8'd48: sine = 16'd63042 ;
			8'd49: sine = 16'd63340 ;
			8'd50: sine = 16'd63621 ;
			8'd51: sine = 16'd63882 ;
			8'd52: sine = 16'd64125 ;
			8'd53: sine = 16'd64349 ;
			8'd54: sine = 16'd64554 ;
			8'd55: sine = 16'd64740 ;
			8'd56: sine = 16'd64906;
			8'd57: sine = 16'd65054 ;
			8'd58: sine = 16'd65181 ;
			8'd59: sine = 16'd65290 ;
			8'd60: sine = 16'd65378 ;
			8'd61: sine = 16'd65447 ;
			8'd62: sine = 16'd65497 ;
			8'd63: sine = 16'd65526 ;
			8'd64: sine = 16'd65535 ;
			8'd65: sine = 16'd65526 ;
			8'd66: sine = 16'd65497 ;
			8'd67: sine = 16'd65447;
			8'd68: sine = 16'd65378;
			8'd69: sine = 16'd65290 ;
			8'd70: sine = 16'd65181 ;
			8'd71: sine = 16'd65054 ;
			8'd72: sine = 16'd64906 ;
			8'd73: sine = 16'd64740 ;
			8'd74: sine = 16'd64554 ;
			8'd75: sine = 16'd64349 ;
			8'd76: sine = 16'd64125 ;
			8'd77: sine = 16'd63882 ;
			8'd78: sine = 16'd63621 ;
			8'd79: sine = 16'd63340 ;
			8'd80: sine = 16'd63042;
			8'd81: sine = 16'd62725;
			8'd82: sine = 16'd62390 ;
			8'd83: sine = 16'd62037 ;
			8'd84: sine = 16'd61667 ;
			8'd85: sine = 16'd61279 ;
			8'd86: sine = 16'd60874 ;
			8'd87: sine = 16'd60452 ;
			8'd88: sine = 16'd60014;
			8'd89: sine = 16'd59559 ;
			8'd90: sine = 16'd59088 ;		
			8'd91: sine = 16'd58601;
			8'd92: sine = 16'd58098;
			8'd93: sine = 16'd57580;
			8'd94: sine = 16'd57047 ;
			8'd95: sine = 16'd56500 ;
			8'd96: sine = 16'd55938 ;
			8'd97: sine = 16'd55363 ;
			8'd98: sine = 16'd54774 ;
			8'd99: sine = 16'd54171 ;
			8'd100: sine =16'd53556 ;
			8'd101: sine =16'd52928 ;
			8'd102: sine =16'd52288 ;
			8'd103: sine =16'd51636 ;
			8'd104: sine =16'd50973;
			8'd105: sine =16'd50299 ;
			8'd106: sine =16'd49614 ;
			8'd107: sine = 16'd48919 ;	
			8'd108: sine = 16'd48215 ;
			8'd109: sine = 16'd47501 ;
			8'd110: sine = 16'd46778 ;
			8'd111: sine = 16'd46047 ;
			8'd112: sine = 16'd45308 ;
			8'd113: sine = 16'd44561 ;
			8'd114: sine = 16'd43807 ;
			8'd115: sine = 16'd43047;
			8'd116: sine = 16'd42280;
			8'd117: sine = 16'd41508 ;
			8'd118: sine = 16'd40730 ;
			8'd119: sine = 16'd39948 ;
			8'd120: sine = 16'd39161 ;
			8'd121: sine = 16'd38370 ;
			8'd122: sine = 16'd37576 ;
			8'd123: sine = 16'd36779 ;
			8'd124: sine = 16'd35980 ;
			8'd125: sine = 16'd35179 ;
			8'd126: sine = 16'd34376 ;
			8'd127: sine = 16'd33572 ;
			8'd128: sine = 16'd32768;
			8'd129: sine = 16'd31964 ;
			8'd130: sine = 16'd31160 ;
			8'd131: sine = 16'd30357 ;
			8'd132: sine = 16'd29556 ;
			8'd133: sine = 16'd28757 ;
			8'd134: sine = 16'd27960 ;
			8'd135: sine = 16'd27166 ;
			8'd136: sine = 16'd26375;
			8'd137: sine = 16'd25588 ;
			8'd138: sine = 16'd24806 ;
			8'd139: sine = 16'd24028;
			8'd140: sine = 16'd23256;
			8'd141: sine = 16'd22489 ;
			8'd142: sine = 16'd21729 ;
			8'd143: sine = 16'd20975 ;
			8'd144: sine = 16'd20228 ;
			8'd145: sine = 16'd19489 ;
			8'd146: sine = 16'd18758 ;
			8'd147: sine = 16'd18035 ;
			8'd148: sine = 16'd17321 ;
			8'd149: sine = 16'd16617 ;
			8'd150: sine = 16'd15922 ;
			8'd151: sine = 16'd15237 ;	
			8'd152: sine = 16'd14563;
			8'd153: sine = 16'd13900 ;
			8'd154: sine = 16'd13248 ;
			8'd155: sine = 16'd12608 ;
			8'd156: sine = 16'd11980 ;
			8'd157: sine = 16'd11365 ;
			8'd158: sine = 16'd10762 ;
			8'd159: sine = 16'd10173 ;
			8'd160: sine = 16'd9598 ;
			8'd161: sine = 16'd9036 ;
			8'd162: sine = 16'd8489 ;
			8'd163: sine = 16'd7956;
			8'd164: sine = 16'd7438;
			8'd165: sine = 16'd6935 ;
			8'd166: sine = 16'd6448 ;
			8'd167: sine = 16'd5977 ;
			8'd168: sine = 16'd5522 ;
			8'd169: sine = 16'd5084 ;
			8'd170: sine = 16'd4662 ;
			8'd171: sine = 16'd4257 ;
			8'd172: sine = 16'd3869 ;
			8'd173: sine = 16'd3499 ;
			8'd174: sine = 16'd3146 ;
			8'd175: sine = 16'd2811 ;
			8'd176: sine = 16'd2494;
			8'd177: sine = 16'd2196;
			8'd178: sine = 16'd1915 ;
			8'd179: sine = 16'd1654 ;
			8'd180: sine = 16'd1411 ;
			8'd181: sine = 16'd1187 ;
			8'd182: sine = 16'd982 ;
			8'd183: sine = 16'd796 ;	
			8'd184: sine = 16'd630;
			8'd185: sine = 16'd482 ;
			8'd186: sine = 16'd355 ;		
			8'd187: sine = 16'd246;
			8'd188: sine = 16'd158;
			8'd189: sine = 16'd89;
			8'd190: sine = 16'd39 ;
			8'd191: sine = 16'd10 ;	
			8'd192: sine = 16'd0 ;
			8'd193: sine = 16'd10 ;
			8'd194: sine = 16'd39 ;
			8'd195: sine = 16'd89 ;
			8'd196: sine = 16'd158 ;
			8'd197: sine = 16'd246 ;
			8'd198: sine = 16'd355 ;
			8'd199: sine = 16'd482 ;
			8'd200: sine = 16'd630;
			8'd201: sine = 16'd796 ;
			8'd202: sine = 16'd982 ;
			8'd203: sine = 16'd1187 ;
			8'd204: sine = 16'd1411 ;
			8'd205: sine = 16'd1654 ;
			8'd206: sine = 16'd1915 ;
			8'd207: sine = 16'd2196 ;
			8'd208: sine = 16'd2494 ;
			8'd209: sine = 16'd2811 ;
			8'd210: sine = 16'd3146 ;
			8'd211: sine = 16'd3499;
			8'd212: sine = 16'd3869;
			8'd213: sine = 16'd4257 ;
			8'd214: sine = 16'd4662 ;
			8'd215: sine = 16'd5084 ;
			8'd216: sine = 16'd5522 ;
			8'd217: sine = 16'd5977 ;
			8'd218: sine = 16'd6448 ;
			8'd219: sine = 16'd6935;
			8'd220: sine = 16'd7438 ;
			8'd221: sine = 16'd7956 ;
			8'd222: sine = 16'd8489 ;
			8'd223: sine = 16'd9036 ;	
			8'd224: sine = 16'd9598;
			8'd225: sine = 16'd10173 ;
			8'd226: sine = 16'd10762;
			8'd227: sine = 16'd11365 ;
			8'd228: sine = 16'd11980 ;
			8'd229: sine = 16'd12608 ;
			8'd230: sine = 16'd13248 ;
			8'd231: sine = 16'd13900 ;
			8'd232: sine = 16'd14563;
			8'd233: sine = 16'd15237 ;
			8'd234: sine = 16'd15922 ;
			8'd235: sine = 16'd16617;
			8'd236: sine = 16'd17321;
			8'd237: sine = 16'd18035 ;
			8'd238: sine = 16'd18758 ;
			8'd239: sine = 16'd19489 ;	
			8'd240: sine = 16'd20228 ;
			8'd241: sine = 16'd20975 ;
			8'd242: sine = 16'd21729 ;
			8'd243: sine = 16'd22489 ;
			8'd244: sine = 16'd23256 ;
			8'd245: sine = 16'd24028 ;
			8'd246: sine = 16'd24806 ;
			8'd247: sine = 16'd25588 ;
			8'd248: sine = 16'd26375;
			8'd249: sine = 16'd27166 ;
			8'd250: sine = 16'd27960 ;
			8'd251: sine = 16'd28757 ;
			8'd252: sine = 16'd29556 ;
			8'd253: sine = 16'd30357 ;
			8'd254: sine = 16'd31160 ;
			8'd255: sine = 16'd31964 ;
			default: sine = 16'd0;
		endcase
		
	end	
	
endmodule
