`timescale 1ps/1ps

module BBOX_CROSS_H(
	input wire clk,
	input wire reset,	
	input wire start,
	input wire [6:0]box_in_x0,
	input wire [6:0]box_in_xn,
	input wire [5:0]box_in_y0,
	input wire [5:0]box_in_yn,		
	input wire [8:0]box_in_size,
	input wire [511:0] box_flag_true,
	
	output reg [8:0]addr,	
	output reg [6:0]box_out_x0,
	output reg [6:0]box_out_xn,
	output reg [5:0]box_out_y0,
	output reg [5:0]box_out_yn,
	output reg [8:0]box_out_size,
	output reg [31:0]box_out_cnt,
	output reg box_out_en,
	output reg cross_complete
	);

reg [511:0] box_flag_2;
reg [8:0] reg1 = 9'd0;
reg [8:0] point_tmp = 9'd0;
reg [6:0] box_x0 = 7'd0;
reg [5:0] box_y0 = 6'd0;
reg [6:0] box_xn = 7'd0;
reg [5:0] box_yn = 6'd0;
reg [6:0] box_temp_x0;
reg [5:0] box_temp_y0;
reg [6:0] box_temp_xn;
reg [5:0] box_temp_yn;
reg test_st;
reg [511:0] box_flag;
reg [8:0] box_pointer;
reg [8:0] box_cnt;
reg [8:0] temp_cnt;
reg [4:0] time_cnt = 5'd0;
reg [8:0] reg2;
reg first_bit;
reg flag_x1;
reg flag_y1;
reg flag_x2;
reg flag_y2;
reg box_update;

//reg box_update = 0;
reg [8:0] loop_cnt = 9'd0;
	
always @(posedge clk) 
begin
		if (reset==1)
			box_out_size<=0;
		reg2 <= reg1;
		box_out_en <= 0;
		if ((time_cnt > 5'd0)&&(time_cnt < 5'd4)|| ((time_cnt > 5'd4)&&(time_cnt < 5'd12)) ||((time_cnt > 5'd13)&&(time_cnt < 5'd21)))
		begin				
			time_cnt <= time_cnt + 1'd1;					
		end;
		if ((start)&&(box_in_size >= 9'd1))
		begin		
			//init count
			cross_complete = 0;
			addr <= 9'd0;
			
			box_out_x0 <= 7'd0;
			box_out_y0 <= 6'd0;
			box_out_xn <= 7'd0;
			box_out_yn <= 6'd0;	
			
			box_x0 <= 7'd0;
			box_y0 <= 6'd0;
			box_xn <= 7'd0;
			box_yn <= 6'd0;
			
			box_temp_x0 <= 7'd0;
			box_temp_y0 <= 6'd0;
			box_temp_xn <= 7'd0;
			box_temp_yn <= 6'd0;
			
			box_out_cnt <= 32'd0;
			box_out_size <= 9'd0;
			
			box_flag <= box_flag_true;
			box_pointer = 9'd1;
	
			reg1 <= 9'd0;
			reg2 <= 9'd0;			
	
			box_cnt <= 9'd1;
			temp_cnt <= 9'd0;								
			time_cnt <= 5'd1;			
		end
		
		//read box temp
		if(time_cnt == 5'd1)
		begin		
			addr <= temp_cnt;
			reg1 <= temp_cnt;							
		end

		//save first box
		if ((time_cnt == 5'd3)&&(box_flag[temp_cnt] == 1'd1))
		begin
			// если всего один элемент выдать его координаты
			if (box_in_size == 9'd1)
			begin			
				cross_complete <= 1;
				box_out_x0 <= box_in_x0;
				box_out_y0 <= box_in_y0;
				box_out_xn <= box_in_xn;
				box_out_yn <= box_in_yn;
				box_out_en <= 1;
				box_out_size <= box_out_size + 1'd1;
				time_cnt <= 5'd31; 
				// выход** !
			end
			// перед обновлением box temp выводим его координаты
			if(temp_cnt !=  9'd0)
			begin
				box_out_x0 <= box_temp_x0;
				box_out_y0 <= box_temp_y0;
				box_out_xn <= box_temp_xn;
				box_out_yn <= box_temp_yn;
				box_out_en <= 1;
				box_out_size <= box_out_size + 1'd1;
			end
			box_temp_x0 <= box_in_x0;
			box_temp_y0 <= box_in_y0;
			box_temp_xn <= box_in_xn;
			box_temp_yn <= box_in_yn;
			box_flag[temp_cnt] <= 1'b0;		// <=	
		end		
		
		// **comparison boxs**
		box_update = 0;
		flag_x1 = 0;
		flag_y1 = 0;
		flag_x2 = 0;
		flag_y2 = 0;			
		test_st <= 0;
		
		if ((time_cnt == 5'd4)&&(box_flag[reg2]))
		begin	
			box_x0 <= box_in_x0;
			box_y0 <= box_in_y0;
			box_xn <= box_in_xn;
			box_yn <= box_in_yn;	
			if  ((box_temp_x0 >= box_in_x0)&&(box_temp_x0 <= box_in_xn))
			begin			
				flag_x1 = 1;						
			end
			if  ((box_temp_x0 < box_in_x0)&&(box_in_x0  <= box_temp_xn)) 
			begin	
				flag_x2 = 1;						
			end
			if ((box_temp_y0 >= box_in_y0)&&(box_temp_y0 <=  box_in_yn)) 
			begin					
				flag_y1 = 1;
			end
			if ((box_temp_y0 < box_in_y0)&&(box_in_y0 <= box_temp_yn)) 
			begin					
				flag_y2 = 1;
			end					
			if((flag_x1 || flag_x2)&&(flag_y1 || flag_y2))
			begin		
				// update bbox
				box_update = 1;
				
				if(box_in_x0 < box_temp_x0)
					box_temp_x0 <= box_in_x0;				
				
				if(box_in_y0 < box_temp_y0)
					box_temp_y0 <= box_in_y0;

				if(box_in_xn >  box_temp_xn)
					box_temp_xn <= box_in_xn;
					
				if(box_in_yn >  box_temp_yn)
					box_temp_yn <= box_in_yn;
					
				// reset flag box
				box_flag[reg2] <= 1'd0;	
				time_cnt <= 5'd5;
				// дальше ни чего делеть не надо!  time=5
			end
		end			
				
	//********************************************
			
		if (time_cnt == 5'd5)
		begin	
			//обновление указателя на первый элемент	
			//point_tmp = box_pointer; // нельзя так делать выше могут быть элементы
			first_bit = 0;
			loop_cnt = 9'd511;
			while( loop_cnt > 9'd0 )	
			begin
				loop_cnt = loop_cnt - 1'd1;
				if (box_flag[loop_cnt[8:0] ] == 1'd1)
				begin				
						box_pointer = loop_cnt[8:0];
				end			
			end
		end	
		// смотрим результат обновляем указатели	
		if (time_cnt == 5'd12)
		begin
			if(box_pointer < box_in_size)
//			if(first_bit)	
			begin	
				addr <= box_pointer;
				reg1 <= box_pointer;					
				box_cnt <= box_pointer + 1'd1;									
				time_cnt <= 5'd3; // тк 1 элемент читался на текущем проходе!   time=3	!
			end
			else begin
			// если нет единиц то обработка завершина 
				box_out_x0 <= box_temp_x0;
				box_out_y0 <= box_temp_y0;
				box_out_xn <= box_temp_xn;
				box_out_yn <= box_temp_yn;
				box_out_en <= 1;
				cross_complete <= 1;					
				box_out_size <= box_out_size + 1'd1;
				time_cnt <= 5'd31;
			end				
		end
		//read element
		if ( (time_cnt >= 5'd2)&&(time_cnt <= 5'd4) && 		
			(box_in_size >= 10'd2)&&(box_cnt < box_in_size ) )				
		begin
			addr <= box_cnt;
			reg1 <= box_cnt;
			box_cnt <= box_cnt + 1'd1;
		end	
		// если  максимальное значение и нет объединения то обновляем box temp  
		if ((time_cnt == 5'd4)&&(reg2 == (box_in_size - 1'd1))&&(~box_update))	
		begin	
			time_cnt <= 5'd14;
			temp_cnt <= box_pointer;
			point_tmp = box_pointer;
			box_flag_2 = box_flag;		
			box_flag_2[point_tmp] = 1'd0;
			
			//обновление указателя на первый элемент				
			loop_cnt = 9'd511;
			first_bit = 0;
			
			while( loop_cnt > 9'd0 )
			begin
				loop_cnt = loop_cnt - 1'd1;
				if (box_flag_2[loop_cnt[8:0] ] == 1'd1 ) 		
				begin
						box_pointer = loop_cnt[8:0];
				end				
			end
		end
		// ждем 7 тактов
		if (time_cnt == 5'd21)
		begin	
			// если нет единиц то обработка завершина
			if(box_pointer >= box_in_size)
//			if((~first_bit)||(temp_cnt == box_in_size))
			begin				
				// выводим координаты
				box_out_x0 <= box_temp_x0;
				box_out_y0 <= box_temp_y0;
				box_out_xn <= box_temp_xn;
				box_out_yn <= box_temp_yn;
				box_out_en <= 1;
				box_out_size <= box_out_size + 1'd1;				
				time_cnt <= 5'd22;
			end
			else begin
				box_cnt <= box_pointer;
				time_cnt <= 5'd1; 
			end
		end
		//  вывод последнего элемента  			
		if (time_cnt == 5'd22)
		begin
			box_out_x0 <= box_x0;
			box_out_y0 <= box_y0;
			box_out_xn <= box_xn;
			box_out_yn <= box_yn;
			box_out_en <= 1;
			cross_complete <= 1;	
			box_out_size <= box_out_size + 1'd1;
			time_cnt <= 5'd31;				
		end
end
endmodule
