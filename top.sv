interface reg_if (input bit clk);
        logic [3:0]out;
        logic [3:0]in;
        logic s1;logic s0,MSB_in,LSB_in,clear_b;

clocking dr_cb@(posedge clk);
default input #1 output #1;
output in;
output s1;
output s0;
output MSB_in;
output LSB_in;
output clear_b;
endclocking


clocking wr_cb@(posedge clk);
default input #1 output #1;
input in;
input s1;
input s0;
input MSB_in;
input LSB_in;
input clear_b;
endclocking

clocking rd_cb@(posedge clk);
default input #1 output #1;
input out;
endclocking

modport DRV(clocking dr_cb);
modport WR_MON(clocking wr_cb);
modport RD_MON(clocking rd_cb);
endinterface
package packages;
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "read_monitor.sv"
`include "monitor.sv"
`include "reference_model.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"
endpackage
module top();
import packages::*;
        reg clk;

        reg_if DUV_IF(clk);

        test t_h;
        shift_register DUV(.clk(clk),.in(DUV_IF.in),.s1(DUV_IF.s1),.s0(DUV_IF.s0),.MSB_in(DUV_IF.MSB_in),.LSB_in(DUV_IF.LSB_in),.out(DUV_IF.out),.clear_b(DUV_IF.clear_b));

initial begin
        clk=1'b0;
        forever #10 clk=~clk;
end

initial begin
        //if($test$plusargs("test"));
//begin
t_h=new(DUV_IF.DRV,DUV_IF.WR_MON,DUV_IF.RD_MON);
t_h.build();
t_h.run();
#500
$finish;

end
endmodule
