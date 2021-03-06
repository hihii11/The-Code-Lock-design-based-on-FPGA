module xyz(sw,q,clk,back,flag,operate); 
input [9:0]sw;    //key 
input back;     //delete 
input clk; 
input [3:0]operate;   
output [27:0]q;    //register
output flag;     
reg [6:0]hex; 
reg [27:0]q; 
reg [27:0]password;    //code  
reg flag;      //50HZ clock 
reg d;  
initial  
 begin   q=28'b1000000100000010000001000000; 
 password=28'b1111001111100111110011111001;  //initial password 1111  
end  
parameter //7-segment displays 
    seg0 = 7'b1000000,  
    seg1 = 7'b1111001,         
    seg2 = 7'b0100100,           
    seg3 = 7'b0110000,            
    seg4 = 7'b0011001,          
    seg5 = 7'b0010010,          
    seg6 = 7'b0000010,           
    seg7 = 7'b1111000,         
    seg8 = 7'b0000000,           
    seg9 = 7'b0010000,    
 check   =4'b0001,    //operate   
 set     =4'b0010,    //new password  
 close   =4'b0100,    //close lock   
  in     =4'b1000;    //input password 
always @(posedge clk)         //segment display and delete         
case(operate)    
check:    if(q==28'b1111001111100111110011111001)  // constant password  
   flag<=1;    
  else if(password==q)   
  flag<=1;    
  else flag<=0;     
 set:    if(flag==1)    
   password<=q;      
 close: flag<=0 ;     
 in:     
    if(sw)     // input password 
 case(sw[9:0])     
 10'b0000000001: begin d=1;  hex<=seg0;  end    
 10'b0000000010: begin d=1;  hex<=seg1;  end    
 10'b0000000100: begin d=1;  hex<=seg2;  end    
 10'b0000001000: begin d=1;  hex<=seg3;  end    
 10'b0000010000: begin d=1;  hex<=seg4;  end    
 10'b0000100000: begin d=1;  hex<=seg5;  end    
 10'b0001000000: begin d=1;  hex<=seg6;  end    
 10'b0010000000: begin d=1;  hex<=seg7;  end    
 10'b0100000000: begin d=1;  hex<=seg8;  end    
 10'b1000000000: begin d=1;  hex<=seg9;  end     
default:begin d<=0;   hex<=hex; end    
endcase  
  else d<=0;  
 default hex<=hex; 
endcase     
reg d1;  
reg back1; 
initial d1=0; 
initial back1=0;
 always @(posedge clk )    
  begin        d1<=d;     
  back1<=back ; end   
always @( posedge clk)      
   begin     
   if(back1&&(!back))  begin q<=q>>7; q[27:21]<=seg0;end     
 else if(d1&&(!d))     
   begin q<=q<<7;  q[6:0]<=hex; end  
 end endmodule