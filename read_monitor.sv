class reg_rd_mon;

virtual reg_if.RD_MON rdmon_if;

reg_trans data2sb=new();
reg_trans rd_data=new();

mailbox #(reg_trans) mon2sb;

function new(virtual reg_if.RD_MON rdmon_if,
mailbox #(reg_trans) mon2sb);

begin
        this.rdmon_if=rdmon_if;
        this.mon2sb=mon2sb;
        //this.rd_data=new();

end
endfunction

virtual task drive();
begin
@(rdmon_if.rd_cb)begin
        rd_data.out<=rdmon_if.rd_cb.out;
        //rd_data.display("from read monitor");
end
end
endtask
virtual task start();
fork
forever begin
        drive();
        data2sb = new rd_data;
        mon2sb.put(data2sb);//put data inot mailbox
//      $display("from read_monitor=%b",data2sb.out);
//      data2sb.display("from read_monitor");
//      rd_data.display("before shallow copy from read_monitor");

end
join_none
endtask
endclass
