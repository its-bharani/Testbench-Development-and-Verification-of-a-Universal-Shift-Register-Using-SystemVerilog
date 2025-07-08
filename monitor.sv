class reg_wr_mon;

virtual reg_if.WR_MON wrmon_if;

reg_trans data2rm=new();
reg_trans wr_data=new();

mailbox #(reg_trans)mon2rm;
mailbox #(reg_trans)drv2mon;
function new(virtual reg_if.WR_MON wrmon_if,
mailbox #(reg_trans)mon2rm,
mailbox #(reg_trans)drv2mon);
begin
        this.wrmon_if=wrmon_if;
        this.drv2mon=drv2mon;
        this.mon2rm=mon2rm;
//this.wr_data=new;
end
endfunction

virtual task monitor();
begin
        @(wrmon_if.wr_cb);
                begin
                        wr_data.s1<=wrmon_if.wr_cb.s1;
                        wr_data.s0<=wrmon_if.wr_cb.s0;
                        wr_data.MSB_in<=wrmon_if.wr_cb.MSB_in;
                        wr_data.LSB_in<=wrmon_if.wr_cb.LSB_in;
                        wr_data.clear_b<=wrmon_if.wr_cb.clear_b;
                        wr_data.in<=wrmon_if.wr_cb.in;
                end
end
endtask
virtual task start();
fork
forever
begin
        monitor();
        //drv2mon.get(data2rm);
        data2rm=new wr_data;//shallow copy
        mon2rm.put(data2rm);//put data to mailbox
//      data2rm.display("from wr_mon");

end
join_none
endtask
endclass
