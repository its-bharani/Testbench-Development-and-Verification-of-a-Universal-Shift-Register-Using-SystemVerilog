class reg_env;

virtual reg_if.DRV dr_if;
virtual reg_if.WR_MON wrmon_if;
virtual reg_if.RD_MON rdmon_if;

mailbox #(reg_trans)gen2dr=new();
mailbox #(reg_trans)ref2sb=new();
mailbox #(reg_trans)mon2sb=new();
mailbox #(reg_trans)mon2rm=new();
mailbox #(reg_trans)drv2mon=new();
reg_gen gen_h;
reg_wr_mon wrmon_h;
reg_drv dri_h;
reg_rd_mon rdmon_h;
reg_sb sb_h;
ref_model model_h;

function new(virtual reg_if.DRV dr_if,
virtual reg_if.WR_MON wrmon_if,
virtual reg_if.RD_MON rdmon_if);
        this.dr_if=dr_if;
        this.wrmon_if=wrmon_if;
        this.rdmon_if=rdmon_if;
endfunction

virtual task build();
        gen_h=new(gen2dr);
        dri_h=new(dr_if,gen2dr,drv2mon);
        wrmon_h=new(wrmon_if,mon2rm,drv2mon);
        rdmon_h=new(rdmon_if,mon2sb);
        model_h=new(mon2rm,ref2sb);
        sb_h=new(ref2sb,mon2sb);
endtask
virtual task clear_duv();
        @(dr_if.dr_cb);
        dr_if.dr_cb.clear_b<=1'b0;
        repeat(2)
        @(dr_if.dr_cb);
        dr_if.dr_cb.clear_b<=1'b1;
endtask

virtual task start();
gen_h.start;
dri_h.start;
rdmon_h.start;
wrmon_h.start;
model_h.start;
sb_h.start;
endtask


virtual task run();
//clear_duv();
start();
endtask

endclass
