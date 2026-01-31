module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,
    input       [4:0]       alu_ctrl,
    output reg  [WIDTH-1:0] alu_out,
    output      zero,
    output reg  carryout
);

    wire [4:0] shamt = b[4:0];
    reg [WIDTH:0] sub_result;
    reg [WIDTH:0] add_result;
    
    always @(*) begin
        sub_result = {1'b0, a} - {1'b0, b};
        add_result = {1'b0, a} + {1'b0, b};
        carryout = 1'b0; // Default

        case (alu_ctrl)
            5'b00000: begin // ADD / ADDI / LW / SW
                alu_out = add_result[WIDTH-1:0];
                carryout = add_result[WIDTH];
            end
            5'b01000: begin // SUB / BRANCHES
                alu_out = sub_result[WIDTH-1:0];
                carryout = !sub_result[WIDTH];
            end
            5'b00001: alu_out = a << shamt;                                    // SLL/SLLI
            5'b00010: alu_out = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;    // SLT/SLTI
            5'b00011: alu_out = (a < b) ? 32'd1 : 32'd0;                      // SLTU/SLTIU
            5'b00100: alu_out = a ^ b;                                         // XOR/XORI
            5'b00101: alu_out = a >> shamt;                                    // SRL/SRLI
            5'b01101: alu_out = $signed(a) >>> shamt;                          // SRA/SRAI
            5'b00110: alu_out = a | b;                                         // OR/ORI
            5'b00111: alu_out = a & b;                                         // AND/ANDI
            5'b01001: alu_out = $signed(a) * $signed(b);                      // MUL
            5'b01010: alu_out = ($signed(a) * $signed(b)) >>> 32;             // MULH
            5'b01011: alu_out = ($signed(a) * $unsigned(b)) >>> 32;           // MULHSU
            5'b01100: alu_out = ($unsigned(a) * $unsigned(b)) >>> 32;         // MULHU
            5'b01110: alu_out = (b != 0) ? ($signed(a) / $signed(b)) : -1;   // DIV
            5'b01111: alu_out = (b != 0) ? (a / b) : {WIDTH{1'b1}};           // DIVU
            5'b10000: alu_out = (b != 0) ? ($signed(a) % $signed(b)) : a;    // REM
            5'b10001: alu_out = (b != 0) ? (a % b) : a;                       // REMU
            
            default: alu_out = 32'h00000000; // Changed from 0xFFFFFFFF
        endcase
    end
    
    assign zero = (alu_out == 32'b0);
endmodule