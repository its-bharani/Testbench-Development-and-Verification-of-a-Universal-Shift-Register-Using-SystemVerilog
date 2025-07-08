class reg_sb;
reg_trans r_data=new();reg_trans sb_data=new();


mailbox #(reg_trans)ref2sb;
mailbox #(reg_trans)mon2sb;

function new(mailbox #(reg_trans)ref2sb,
mailbox #(reg_trans)mon2sb);
        this.ref2sb=ref2sb;
        this.mon2sb=mon2sb;
endfunction

virtual task start();
fork forever
begin
        ref2sb.get(r_data);
        mon2sb.get(sb_data);
        check(sb_data);
end
join_none
endtask

virtual task check(reg_trans rdata);
begin
        if(r_data.out ==rdata.out)begin
        $display("r_data.out =%b ---rdata.out=%b ---data matches",r_data.out,rdata.out);
        //rdata.display("from duv");
        r_data.display("---data generated----------");
        end
        else begin
        $display("r_data.out =%b----------- rdata.out=%b------------not matching",r_data.out,rdata.out);

        r_data.display("---data generated----------");
        //rdata.display("from duv");
end
end
endtask
endclass
