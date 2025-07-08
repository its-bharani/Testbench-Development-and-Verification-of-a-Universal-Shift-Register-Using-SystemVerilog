class reg_trans;

rand logic [3:0]in;
rand logic s1,s0,MSB_in,LSB_in,clear_b;
logic [3:0]out;

constraint c1 {in inside {[0:15]};}
constraint c {{s1,s0} dist {2'b00:=25, 2'b01:=25, 2'b10:=25, 2'b11:=11};}
//constraint c2{ s1 dist {0:=50, 1:=50};}
//constraint c3{ s0 dist {0:=50, 1:=50};}
constraint c4 { MSB_in dist {0:=50, 1:=50};}
constraint c5 { LSB_in dist {0:=50, 1:=50};}
constraint c6 { clear_b dist {0:=30, 1:=70};}

virtual function void display(input string s);
begin
$display("------------------------%s-----------------------------",s);
$display("s1,s0=%d,%d",s1,s0);
$display("msb_in =%d",MSB_in);
$display("lsb_in =%d",LSB_in);
$display("in=%b",in);
$display("clear_b=%d",clear_b);
end
endfunction

endclass:reg_trans
~
