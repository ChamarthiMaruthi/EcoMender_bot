`timescale 1 ns/1 ns

module tb_1;

// registers to send data
reg clk;
reg reset;
reg Ext_MemWrite;
reg [31:0] Ext_WriteData, Ext_DataAdr;

// Wire Ouputs from Instantiated Modules
wire [31:0] WriteData, DataAdr, ReadData;
wire MemWrite;
wire [31:0] PC, Result;

// Initialize Top Module
t1c_riscv_cpu uut (clk, reset, Ext_MemWrite, Ext_WriteData, Ext_DataAdr, MemWrite, WriteData, DataAdr, ReadData, PC, Result);

integer fault_instrs = 0, i = 0, fw = 0, flag = 0;

// Memory-mapped addresses for t2b_ex1.c program
localparam N_ADDR           = 32'h02000000;
localparam SUM_ADDR         = 32'h02000004;
localparam CPU_DONE_ADDR    = 32'h02000008;

// Expected value: Sum of 1 to 20 = 210
localparam EXPECTED_SUM     = 32'd210;
localparam N_VALUE          = 32'd20;

integer cycle_count = 0;
integer sum_updates = 0;
reg [31:0] last_sum = 0;
integer mem_write_count = 0;

// generate clock to sequence tests
always begin
    clk <= 1; # 5; clk <= 0; # 5;
end

// Initialize memory-mapped values and reset
initial begin
    reset = 1;
    Ext_MemWrite = 0; 
    Ext_DataAdr = 32'b0; 
    Ext_WriteData = 32'b0; 
    #10; // Wait one clock cycle
    
    // Enable external memory write
    Ext_MemWrite = 1;
    
    // Write N = 20 to memory address 0x02000000
    Ext_DataAdr = N_ADDR;
    Ext_WriteData = N_VALUE;
    #10; // Wait for write to complete
    $display("Time: %0t | Written N=%0d to address 0x%08h", $time, N_VALUE, N_ADDR);
    
    // Initialize SUM = 0 at address 0x02000004
    Ext_DataAdr = SUM_ADDR;
    Ext_WriteData = 32'd0;
    #10; // Wait for write to complete
    
    // Initialize CPU_DONE = 0 at address 0x02000008
    Ext_DataAdr = CPU_DONE_ADDR;
    Ext_WriteData = 32'd0;
    #10; // Wait for write to complete
    
    // Disable external writes
    Ext_MemWrite = 0;
    Ext_DataAdr = 32'b0;
    Ext_WriteData = 32'b0;
    #10; // Wait one cycle
    
    // Verify memory contents BEFORE releasing reset
    $display("========================================");
    $display("Memory Initialization Check:");
    $display("  data_ram[0] (N)        = 0x%08h (expected 0x00000014)", uut.datamem.data_ram[0]);
    $display("  data_ram[1] (SUM)      = 0x%08h (expected 0x00000000)", uut.datamem.data_ram[1]);
    $display("  data_ram[2] (CPU_DONE) = 0x%08h (expected 0x00000000)", uut.datamem.data_ram[2]);
    $display("========================================");
    
    // NOW release reset
    #10;
    reset = 0;
    #10; // Wait one more cycle after reset release
    
    $display("========================================");
    $display("Testing t2b_ex1.c - Sum of Natural Numbers");
    $display("N = %0d", N_VALUE);
    $display("Expected SUM = %0d", EXPECTED_SUM);
    $display("========================================");
    $display("Looking for writes to:");
    $display("  N_ADDR:        0x%08h", N_ADDR);
    $display("  SUM_ADDR:      0x%08h", SUM_ADDR);
    $display("  CPU_DONE_ADDR: 0x%08h", CPU_DONE_ADDR);
    $display("========================================\n");
end

// Monitor ALL memory writes with addresses (only first 60 to avoid spam)
always @(negedge clk) begin
    if (!reset && MemWrite) begin
        mem_write_count = mem_write_count + 1;
        
        // Print first 60 memory writes to see what's happening
        if (mem_write_count <= 60) begin
            $display("[MEM WRITE %3d] Cycle: %5d | Addr: 0x%08h | Data: 0x%08h (%0d)", 
                     mem_write_count, cycle_count, DataAdr, WriteData, WriteData);
        end
        else if (mem_write_count == 61) begin
            $display("\n... (suppressing further memory write details) ...\n");
        end
        
        // Check for SUM address
        if (DataAdr === SUM_ADDR) begin
            sum_updates = sum_updates + 1;
            last_sum = WriteData;
        end
        
        // Check for CPU_DONE flag
        if (DataAdr === CPU_DONE_ADDR && WriteData === 32'd1) begin
            $display("\n========================================");
            $display("CPU_DONE flag set!");
            $display("========================================");
            $display("Final SUM = %0d", last_sum);
            $display("Total SUM updates: %0d", sum_updates);
            $display("Total cycles: %0d", cycle_count);
            $display("Total memory writes: %0d", mem_write_count);
            $display("========================================");
            
            if (last_sum === EXPECTED_SUM) begin
                $display("✓ TEST PASSED: SUM is correct!");
                fw = $fopen("results.txt","w");
                $fdisplay(fw, "%02h","No Errors");
                $display("No errors encountered, congratulations!");
                $fclose(fw);
            end
            else begin
                $display("✗ TEST FAILED: Expected %0d, Got %0d", EXPECTED_SUM, last_sum);
                fault_instrs = fault_instrs + 1;
                fw = $fopen("results.txt","w");
                $fdisplay(fw, "%02h","Errors");
                $display("Error(s) encountered, please check your design!");
                $fclose(fw);
            end
            $stop;
        end
    end
end

// Monitor PC and instruction execution (first 60 cycles)
always @(negedge clk) begin
    if (!reset && cycle_count <= 60) begin
        $display("[EXEC %3d] PC: 0x%08h | Instr: 0x%08h | Result: 0x%08h", 
                 cycle_count, PC, uut.Instr, Result);
    end
    else if (!reset && cycle_count == 61) begin
        $display("\n... (suppressing instruction trace) ...\n");
    end
end

// Cycle counter
always @(posedge clk) begin
    if (!reset) begin
        cycle_count = cycle_count + 1;
    end
end

// Timeout mechanism (prevent infinite loops)
always @(negedge clk) begin
    if (cycle_count > 100000) begin
        $display("\n========================================");
        $display("✗ TEST TIMEOUT: CPU did not complete in 100000 cycles");
        $display("========================================");
        $display("DIAGNOSTICS:");
        $display("  Last PC: 0x%08h", PC);
        $display("  Last Instruction: 0x%08h", uut.Instr);
        $display("  Last Result: 0x%08h", Result);
        $display("  Last SUM value: %0d", last_sum);
        $display("  Total memory writes: %0d", mem_write_count);
        $display("  SUM updates: %0d", sum_updates);
        $display("\nDATA MEMORY (first 10 locations):");
        for (i = 0; i < 10; i = i + 1) begin
            $display("  data_ram[%0d] = 0x%08h", i, uut.datamem.data_ram[i]);
        end
        $display("========================================\n");
        fw = $fopen("results.txt","w");
        $fdisplay(fw, "%02h","Errors");
        $display("Error(s) encountered, please check your design!");
        $fclose(fw);
        $stop;
    end
end

endmodule
