`timescale 1ns / 1ps

module alu_decoder_tb();
    reg funct7_5, op5;
    reg [1:0] aluop;
    reg [2:0] funct3;
    wire [2:0] alucontrol;
    
    integer i;
    reg test_failed;
    
    alu_decoder dut(
        .funct7_5(funct7_5), .op5(op5),
        .aluop(aluop),
        .funct3(funct3),
        .alucontrol(alucontrol)
        );
        
        initial
            begin
                funct7_5 = 0; op5 = 0; aluop = 0; funct3 = 0;
                
                //Test 1:
                aluop = 2'b00;
                #1;
                if (alucontrol === 3'b000)
                    $display ("Test 1 PASSED: control signal for lw and sw instruction's add tested, alucontrol = %b", alucontrol);
                else
                    $display ("Test 1 FAILED: expected 000, got %b", alucontrol);
                
                //Test 2:
                aluop = 2'b01;
                #1;
                if (alucontrol === 3'b001)
                    $display ("Test 2 PASSED: control signal for beq instruction's subtract tested, alucontrol = %b", alucontrol);
                else
                    $display ("Test 2 FAILED: expected 001, got %b", alucontrol);
                
                //Test 3:
                aluop = 2'b10;
                funct3 = 3'b000;
                op5 = 1'b1; funct7_5 = 1'b1;
                #1;
                if (alucontrol === 3'b001)
                    $display ("Test 3.1 PASSED: control signal for sub instruction tested, alucontrol = %b", alucontrol);
                else
                    $display ("Test 3.1 FAILED: expected 001, got %b", alucontrol);
                
                test_failed = 1'b0;
                for (i = 0; i < 3; i = i + 1)
                    begin
                        {op5,funct7_5} = i[1:0];
                        #1;
                        if (alucontrol !== 3'b000)
                            begin
                                $display ("Test 3.2 FAILED: {op5,funct7_5} = %b, expected 000, got %b", {op5,funct7_5}, alucontrol);    
                                test_failed = 1'b1;
                            end
                    end
                    if (!test_failed)
                            $display ("Test 3.2 PASSED: control signal for add instruction tested, alucontrol = %b", alucontrol);
                
                //Test 4:
                aluop = 2'b10;
                funct3 = 3'b010;
                #1;
                if (alucontrol === 3'b101)
                    $display ("Test 4 PASSED: control signal for slt instruction tested, alucontrol = %b", alucontrol);
                else
                    $display ("Test 4 FAILED: expected 101, got %b", alucontrol);
                
                //Test 5:
                aluop = 2'b10;
                funct3 = 3'b110;
                #1;
                if (alucontrol === 3'b011)
                    $display ("Test 5 PASSED: control signal for or instruction tested, alucontrol = %b", alucontrol);
                else
                    $display ("Test 5 FAILED: expected 011, got %b", alucontrol);
                    
                //Test 6:
                aluop = 2'b10;
                funct3 = 3'b111;
                #1;
                if (alucontrol === 3'b010)
                    $display ("Test 6 PASSED: control signal for and instruction tested, alucontrol = %b", alucontrol);
                else
                    $display ("Test 6 FAILED: expected 010, got %b", alucontrol);
                
                //Test 7:
                aluop = 2'b10;
                funct3 = 3'b011;
                #1;
                if (alucontrol === 3'bx)
                    $display ("Test 7 PASSED: default case for funct3 tested, alucontrol = %b", alucontrol);
                else
                    $display ("Test 7 FAILED: expected xxx, got %b", alucontrol);
                    
                //Test 8:
                aluop = 2'b11;
                #1;
                if (alucontrol === 3'bx)
                    $display ("Test 8 PASSED: dafault case for aluop tested, alucontrol = %b", alucontrol);
                else
                    $display ("Test 8 FAILED: expected xxx, got %b", alucontrol);
                
                $finish;
                
            end

endmodule
