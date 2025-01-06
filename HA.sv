module HA(output carry, sum, input a, b);
    assign sum = a ^ b;
    assign carry = a & b;
endmodule