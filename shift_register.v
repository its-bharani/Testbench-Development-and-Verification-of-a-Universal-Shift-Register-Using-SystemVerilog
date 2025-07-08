module shift_register(output reg [3:0]out,input [3:0]in,input s1,s0,MSB_in,LSB_in,clk,clear_b);

always@(posedge clk,negedge clear_b)
begin
        if(clear_b == 0)
                out <= 4'b0000;
        else
                case({s1,s0})
                        2'b00:out<=out;
                        2'b01:out<={MSB_in,in[3:1]};
                        2'b10:out<={in[2:0],LSB_in};
                        2'b11:out<=in;
                        default:out<=4'b0000;
                endcase
        end
                endmodule
