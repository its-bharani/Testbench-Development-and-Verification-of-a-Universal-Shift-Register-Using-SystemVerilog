class reg_drv;

virtual reg_if.DRV dr_if;//virtual interface

reg_trans data2duv=new();

mailbox #(reg_trans)gen2dr;
mailbox #(reg_trans)drv2mon;

function new(virtual reg_if.DRV dr_if,mailbox #(reg_trans)gen2dr,mailbox #(reg_trans)drv2mon);

        this.dr_if=dr_if;
        this.gen2dr=gen2dr;
        this.drv2mon=drv2mon;
endfunction

virtual task drive();
begin@(dr_if.dr_cb)begin
                dr_if.dr_cb.s1<=data2duv.s1;
                dr_if.dr_cb.s0<=data2duv.s0;
                dr_if.dr_cb.MSB_in<=data2duv.MSB_in;
                dr_if.dr_cb.LSB_in<=data2duv.LSB_in;
                dr_if.dr_cb.clear_b<=data2duv.clear_b;
                dr_if.dr_cb.in<=data2duv.in;
end
end
endtask

virtual task start();
fork forever
        begin
                gen2dr.get(data2duv);//get data from mailbox
                drive();
//              drv2mon.put(data2duv);//put into mailbox
//              data2duv.display("at driver----generated data----------------");
end
join_none

endtask
endclass
