class reg_gen;

reg_trans trans_h;
reg_trans data2send;
int no_of_trans=100;
mailbox #(reg_trans)gen2dr;
function new(mailbox #(reg_trans)gen2dr);
        this.gen2dr=gen2dr;
endfunction


virtual task start();
repeat(no_of_trans)begin

        trans_h=new;
        assert(trans_h.randomize());
        data2send=new trans_h;//shallow copy
        gen2dr.put(data2send);//put data into mailbox
end
endtask
endclass
~
