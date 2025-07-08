class ref_model;

reg_trans w_data=new();
static logic  [3:0]ref_out=4'b0000;

mailbox #(reg_trans)mon2rm;
mailbox #(reg_trans)ref2sb;

function new(mailbox #(reg_trans)mon2rm,mailbox #(reg_trans)ref2sb);
        this.mon2rm=mon2rm;
        this.ref2sb=ref2sb;
//      this.w_data=new();
endfunction

virtual task reg_mod(reg_trans w_data);
        begin
                if(w_data.clear_b == 0)
                        ref_out<=4'b0000;

                else
                        begin
                                if({w_data.s1,w_data.s0} ==2'b00)
                                        ref_out<=ref_out;
                                else if({w_data.s1,w_data.s0} ==2'b01)
                                        ref_out<={w_data.MSB_in,w_data.in[3:1]};
                                else if({w_data.s1,w_data.s0} ==2'b10)
                                        ref_out<={w_data.in[2:0],w_data.LSB_in};
                                else //if({w_data.s1,w_data.s0} ==2'b11)
                                        ref_out<=w_data.in;
                        //      else
                        //              ref_out<=4'b0000;

                        end
end
endtask
virtual task start();
fork
begin
        forever
                begin
                        mon2rm.get(w_data);
                reg_mod(w_data);//w_data.display("from generator the data generated------");
                        $display("ref_out=%b",ref_out);//just to check
                        w_data.out=ref_out;
                        ref2sb.put(w_data);
//                      w_data.display("from reference_model");
end
end
join_none
endtask
endclass
