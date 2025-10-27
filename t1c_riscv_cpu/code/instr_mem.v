// instr_mem.v - instruction memory

module instr_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 512) (
    input       [ADDR_WIDTH-1:0] instr_addr,
    output      [DATA_WIDTH-1:0] instr
);

// array of 64 32-bit words or instructions
reg [DATA_WIDTH-1:0] instr_ram [0:MEM_SIZE-1];
reg [7:0] byte_ram [0:MEM_SIZE*4-1];

integer i;
integer j;
integer x;
initial begin
    //$readmemh("rv32i_book.hex", instr_ram);
    //$readmemh("rv32i_test.hex", instr_ram);
	 //$readmemh("memory_file.hex", instr_ram);
	 //$readmemh("t2b_ex1.hex", byte_ram);
	 
	 // Initialize byte array
    for (j = 0; j < MEM_SIZE*4; j = j + 1) begin
        byte_ram[j] = 8'h00;
    end
	 
	 $readmemh("t2b_ex1.hex", byte_ram);
	 
	 // Convert little-endian bytes to 32-bit words
    // RISC-V stores bytes in little-endian order:
    // Address:  [3] [2] [1] [0]
    // Becomes:  MSB         LSB
    for (i = 0; i < MEM_SIZE; i = i + 1) begin
		  //$display("Entered the for loop.");
        instr_ram[i] = {byte_ram[i*4+3], byte_ram[i*4+2], 
                        byte_ram[i*4+1], byte_ram[i*4+0]};
    end
    
    $display("========================================");
    $display("Loaded: t2b_ex1.hex (byte format)");
    $display("Format: Verilog hex with @ markers");
    $display("========================================\n");
    
    $display("Instruction Memory Contents:");
    for (x = 0; x < 30; x = x + 1) begin
        if (instr_ram[x] !== 32'h00000000) begin
            $display("  [%2d] Addr 0x%03X: 0x%08h", x, x*4, instr_ram[x]);
        end
    end
    $display("========================================\n");
	
end


// word-aligned memory access
// combinational read logic
assign instr = instr_ram[instr_addr[31:2]];

endmodule

