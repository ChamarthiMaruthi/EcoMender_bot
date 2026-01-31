module alu_decoder( 
    input            opb5,
    input [2:0]      funct3,
    input [6:0]      funct7,
    input [1:0]      ALUOp,
    output reg [4:0] ALUControl
);

wire funct7b5_masked = (opb5==1'b0 && funct3 == 3'b101) ? funct7[5] : (opb5 == 1'b0 ? 1'b0 : funct7[5]);
wire funct7b0_masked = (opb5==1'b0 && funct3 == 3'b101) ? funct7[0] : (opb5 == 1'b0 ? 1'b0 : funct7[0]);

    always @(*) begin
        case (ALUOp)
            2'b00:
                ALUControl = 5'b00000; // ADD for loads/stores
            2'b01:
                ALUControl = 5'b01000; // SUB for branches
            2'b10: begin
                casez ({opb5, funct7b0_masked, funct7b5_masked, funct3})
                    // I-type (opb5=0)
                    6'b0_0_0_000: ALUControl = 5'b00000; // ADDI
                    6'b0_0_0_010: ALUControl = 5'b00010; // SLTI
                    6'b0_0_0_011: ALUControl = 5'b00011; // SLTIU
                    6'b0_0_0_100: ALUControl = 5'b00100; // XORI
                    6'b0_0_0_110: ALUControl = 5'b00110; // ORI
                    6'b0_0_0_111: ALUControl = 5'b00111; // ANDI
                    6'b0_0_0_001: ALUControl = 5'b00001; // SLLI
                    6'b0_0_0_101: ALUControl = 5'b00101; // SRLI
                    6'b0_0_1_101: ALUControl = 5'b01101; // SRAI

                    // R-type (opb5=1, funct7[0]=0)
                    6'b1_0_0_000: ALUControl = 5'b00000; // ADD
                    6'b1_0_1_000: ALUControl = 5'b01000; // SUB
                    6'b1_0_0_001: ALUControl = 5'b00001; // SLL
                    6'b1_0_0_010: ALUControl = 5'b00010; // SLT
                    6'b1_0_0_011: ALUControl = 5'b00011; // SLTU
                    6'b1_0_0_100: ALUControl = 5'b00100; // XOR
                    6'b1_0_0_101: ALUControl = 5'b00101; // SRL
                    6'b1_0_1_101: ALUControl = 5'b01101; // SRA
                    6'b1_0_0_110: ALUControl = 5'b00110; // OR
                    6'b1_0_0_111: ALUControl = 5'b00111; // AND

                    // M-extension (opb5=1, funct7[0]=1, funct7[5]=0)
                    6'b1_1_0_000: ALUControl = 5'b01001; // MUL
                    6'b1_1_0_001: ALUControl = 5'b01010; // MULH
                    6'b1_1_0_010: ALUControl = 5'b01011; // MULHSU
                    6'b1_1_0_011: ALUControl = 5'b01100; // MULHU
                    6'b1_1_0_100: ALUControl = 5'b01110; // DIV
                    6'b1_1_0_101: ALUControl = 5'b01111; // DIVU
                    6'b1_1_0_110: ALUControl = 5'b10000; // REM
                    6'b1_1_0_111: ALUControl = 5'b10001; // REMU

                    default: ALUControl = 5'b00000;
                endcase
            end
            2'b11:
                ALUControl = 5'b00000;

            default:
                ALUControl = 5'b00000;
        endcase
    end
endmodule