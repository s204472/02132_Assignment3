module DataMemory(
  input         clock,
  input  [15:0] io_address,
  output [31:0] io_dataRead,
  input         io_writeEnable,
  input  [31:0] io_dataWrite,
  input         io_testerEnable,
  input  [15:0] io_testerAddress,
  output [31:0] io_testerDataRead,
  input         io_testerWriteEnable,
  input  [31:0] io_testerDataWrite
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] memory [0:65535]; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_addr; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_2_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_2_addr; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_1_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_1_addr; // @[DataMemory.scala 18:20]
  wire  memory__T_1_mask; // @[DataMemory.scala 18:20]
  wire  memory__T_1_en; // @[DataMemory.scala 18:20]
  wire [31:0] memory__T_3_data; // @[DataMemory.scala 18:20]
  wire [15:0] memory__T_3_addr; // @[DataMemory.scala 18:20]
  wire  memory__T_3_mask; // @[DataMemory.scala 18:20]
  wire  memory__T_3_en; // @[DataMemory.scala 18:20]
  wire [31:0] _GEN_5 = io_testerWriteEnable ? io_testerDataWrite : memory__T_data; // @[DataMemory.scala 27:32]
  wire [31:0] _GEN_11 = io_writeEnable ? io_dataWrite : memory__T_2_data; // @[DataMemory.scala 37:26]
  assign memory__T_addr = io_testerAddress;
  assign memory__T_data = memory[memory__T_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_2_addr = io_address;
  assign memory__T_2_data = memory[memory__T_2_addr]; // @[DataMemory.scala 18:20]
  assign memory__T_1_data = io_testerDataWrite;
  assign memory__T_1_addr = io_testerAddress;
  assign memory__T_1_mask = 1'h1;
  assign memory__T_1_en = io_testerEnable & io_testerWriteEnable;
  assign memory__T_3_data = io_dataWrite;
  assign memory__T_3_addr = io_address;
  assign memory__T_3_mask = 1'h1;
  assign memory__T_3_en = io_testerEnable ? 1'h0 : io_writeEnable;
  assign io_dataRead = io_testerEnable ? 32'h0 : _GEN_11; // @[DataMemory.scala 26:17 DataMemory.scala 34:17 DataMemory.scala 40:19]
  assign io_testerDataRead = io_testerEnable ? _GEN_5 : 32'h0; // @[DataMemory.scala 24:23 DataMemory.scala 30:25 DataMemory.scala 36:23]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 65536; initvar = initvar+1)
    memory[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(memory__T_1_en & memory__T_1_mask) begin
      memory[memory__T_1_addr] <= memory__T_1_data; // @[DataMemory.scala 18:20]
    end
    if(memory__T_3_en & memory__T_3_mask) begin
      memory[memory__T_3_addr] <= memory__T_3_data; // @[DataMemory.scala 18:20]
    end
  end
endmodule
module Accelerator(
  input         clock,
  input         reset,
  input         io_start,
  output        io_done,
  output [15:0] io_address,
  input  [15:0] io_dataRead,
  output        io_writeEnable,
  output [15:0] io_dataWrite
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] stateReg; // @[Accelerator.scala 27:25]
  reg [15:0] xReg; // @[Accelerator.scala 30:17]
  reg [15:0] yReg; // @[Accelerator.scala 31:17]
  reg [15:0] pixelReg; // @[Accelerator.scala 32:21]
  wire  _T = 4'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_1 = 4'h1 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = yReg == 16'h13; // @[Accelerator.scala 55:17]
  wire  _T_3 = xReg != 16'h13; // @[Accelerator.scala 55:40]
  wire  _T_4 = _T_2 & _T_3; // @[Accelerator.scala 55:32]
  wire [31:0] _T_5 = xReg * 16'h14; // @[Accelerator.scala 56:28]
  wire [31:0] _GEN_118 = {{16'd0}, yReg}; // @[Accelerator.scala 56:41]
  wire [31:0] _T_7 = _T_5 + _GEN_118; // @[Accelerator.scala 56:41]
  wire [31:0] _T_9 = _T_7 + 32'h190; // @[Accelerator.scala 56:48]
  wire [15:0] _T_11 = xReg + 16'h1; // @[Accelerator.scala 61:22]
  wire  _T_12 = xReg == 16'h0; // @[Accelerator.scala 62:25]
  wire  _T_13 = yReg == 16'h0; // @[Accelerator.scala 62:47]
  wire  _T_14 = _T_12 | _T_13; // @[Accelerator.scala 62:39]
  wire  _T_15 = xReg == 16'h13; // @[Accelerator.scala 62:69]
  wire  _T_16 = yReg != 16'h13; // @[Accelerator.scala 62:92]
  wire  _T_17 = _T_15 & _T_16; // @[Accelerator.scala 62:84]
  wire  _T_18 = _T_14 | _T_17; // @[Accelerator.scala 62:61]
  wire [15:0] _T_25 = yReg + 16'h1; // @[Accelerator.scala 66:22]
  wire  _T_28 = _T_15 & _T_2; // @[Accelerator.scala 67:40]
  wire [31:0] _GEN_3 = _T_28 ? _T_9 : _T_7; // @[Accelerator.scala 67:64]
  wire [31:0] _GEN_8 = _T_18 ? _T_9 : _GEN_3; // @[Accelerator.scala 62:107]
  wire  _GEN_9 = _T_18 | _T_28; // @[Accelerator.scala 62:107]
  wire [31:0] _GEN_14 = _T_4 ? _T_9 : _GEN_8; // @[Accelerator.scala 55:55]
  wire  _GEN_15 = _T_4 | _GEN_9; // @[Accelerator.scala 55:55]
  wire  _T_37 = 4'h2 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_38 = pixelReg == 16'h0; // @[Accelerator.scala 79:22]
  wire [31:0] _T_48 = _T_7 - 32'h1; // @[Accelerator.scala 86:48]
  wire [31:0] _GEN_21 = _T_38 ? _T_9 : _T_48; // @[Accelerator.scala 79:36]
  wire  _T_49 = 4'h3 == stateReg; // @[Conditional.scala 37:30]
  wire [31:0] _T_62 = _T_7 + 32'h1; // @[Accelerator.scala 99:48]
  wire [31:0] _GEN_26 = _T_38 ? _T_9 : _T_62; // @[Accelerator.scala 91:36]
  wire  _T_63 = 4'h4 == stateReg; // @[Conditional.scala 37:30]
  wire [15:0] _T_73 = xReg - 16'h1; // @[Accelerator.scala 112:29]
  wire [31:0] _T_74 = _T_73 * 16'h14; // @[Accelerator.scala 112:42]
  wire [31:0] _T_76 = _T_74 + _GEN_118; // @[Accelerator.scala 112:55]
  wire [31:0] _GEN_32 = _T_38 ? _T_9 : _T_76; // @[Accelerator.scala 104:36]
  wire  _T_77 = 4'h5 == stateReg; // @[Conditional.scala 37:30]
  wire [31:0] _T_88 = _T_11 * 16'h14; // @[Accelerator.scala 125:42]
  wire [31:0] _T_90 = _T_88 + _GEN_118; // @[Accelerator.scala 125:55]
  wire [31:0] _GEN_38 = _T_38 ? _T_9 : _T_90; // @[Accelerator.scala 117:36]
  wire  _T_91 = 4'h6 == stateReg; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_44 = _T_38 ? _T_9 : _T_9; // @[Accelerator.scala 130:36]
  wire [15:0] _GEN_46 = _T_38 ? 16'h0 : 16'hff; // @[Accelerator.scala 130:36]
  wire  _T_107 = 4'h7 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_108 = yReg < 16'h12; // @[Accelerator.scala 145:18]
  wire [31:0] _T_113 = _T_7 + 32'h191; // @[Accelerator.scala 146:48]
  wire [15:0] _T_115 = yReg + 16'h2; // @[Accelerator.scala 150:22]
  wire [31:0] _GEN_49 = _T_108 ? _T_113 : _T_113; // @[Accelerator.scala 145:31]
  wire  _T_123 = 4'h8 == stateReg; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_56 = _T_107 ? _GEN_49 : 32'h0; // @[Conditional.scala 39:67]
  wire  _GEN_62 = _T_107 ? 1'h0 : _T_123; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_63 = _T_91 ? _GEN_44 : _GEN_56; // @[Conditional.scala 39:67]
  wire  _GEN_64 = _T_91 | _T_107; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_65 = _T_91 ? _GEN_46 : 16'h0; // @[Conditional.scala 39:67]
  wire  _GEN_69 = _T_91 ? 1'h0 : _GEN_62; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_70 = _T_77 ? _GEN_38 : _GEN_63; // @[Conditional.scala 39:67]
  wire  _GEN_71 = _T_77 ? _T_38 : _GEN_64; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_72 = _T_77 ? 16'h0 : _GEN_65; // @[Conditional.scala 39:67]
  wire  _GEN_77 = _T_77 ? 1'h0 : _GEN_69; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_78 = _T_63 ? _GEN_32 : _GEN_70; // @[Conditional.scala 39:67]
  wire  _GEN_79 = _T_63 ? _T_38 : _GEN_71; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_80 = _T_63 ? 16'h0 : _GEN_72; // @[Conditional.scala 39:67]
  wire  _GEN_85 = _T_63 ? 1'h0 : _GEN_77; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_86 = _T_49 ? _GEN_26 : _GEN_78; // @[Conditional.scala 39:67]
  wire  _GEN_87 = _T_49 ? _T_38 : _GEN_79; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_88 = _T_49 ? 16'h0 : _GEN_80; // @[Conditional.scala 39:67]
  wire  _GEN_93 = _T_49 ? 1'h0 : _GEN_85; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_94 = _T_37 ? _GEN_21 : _GEN_86; // @[Conditional.scala 39:67]
  wire  _GEN_95 = _T_37 ? _T_38 : _GEN_87; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_96 = _T_37 ? 16'h0 : _GEN_88; // @[Conditional.scala 39:67]
  wire  _GEN_101 = _T_37 ? 1'h0 : _GEN_93; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_102 = _T_1 ? _GEN_14 : _GEN_94; // @[Conditional.scala 39:67]
  wire  _GEN_103 = _T_1 ? _GEN_15 : _GEN_95; // @[Conditional.scala 39:67]
  wire [15:0] _GEN_104 = _T_1 ? 16'h0 : _GEN_96; // @[Conditional.scala 39:67]
  wire  _GEN_109 = _T_1 ? 1'h0 : _GEN_101; // @[Conditional.scala 39:67]
  wire [31:0] _GEN_113 = _T ? 32'h0 : _GEN_102; // @[Conditional.scala 40:58]
  assign io_done = _T ? 1'h0 : _GEN_109; // @[Accelerator.scala 42:11 Accelerator.scala 161:15]
  assign io_address = _GEN_113[15:0]; // @[Accelerator.scala 40:14 Accelerator.scala 56:20 Accelerator.scala 63:20 Accelerator.scala 68:20 Accelerator.scala 73:20 Accelerator.scala 80:20 Accelerator.scala 86:20 Accelerator.scala 92:20 Accelerator.scala 99:20 Accelerator.scala 105:20 Accelerator.scala 112:20 Accelerator.scala 118:20 Accelerator.scala 125:20 Accelerator.scala 131:20 Accelerator.scala 137:20 Accelerator.scala 146:20 Accelerator.scala 152:20]
  assign io_writeEnable = _T ? 1'h0 : _GEN_103; // @[Accelerator.scala 39:18 Accelerator.scala 57:24 Accelerator.scala 64:24 Accelerator.scala 69:24 Accelerator.scala 81:24 Accelerator.scala 93:24 Accelerator.scala 106:24 Accelerator.scala 119:24 Accelerator.scala 132:24 Accelerator.scala 138:24 Accelerator.scala 147:24 Accelerator.scala 153:24]
  assign io_dataWrite = _T ? 16'h0 : _GEN_104; // @[Accelerator.scala 41:16 Accelerator.scala 58:22 Accelerator.scala 65:22 Accelerator.scala 70:22 Accelerator.scala 82:22 Accelerator.scala 94:22 Accelerator.scala 107:22 Accelerator.scala 120:22 Accelerator.scala 133:22 Accelerator.scala 139:22 Accelerator.scala 148:22 Accelerator.scala 154:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  xReg = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  yReg = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  pixelReg = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      stateReg <= 4'h0;
    end else if (_T) begin
      if (io_start) begin
        stateReg <= 4'h1;
      end
    end else if (_T_1) begin
      if (!(_T_4)) begin
        if (!(_T_18)) begin
          if (_T_28) begin
            stateReg <= 4'h8;
          end else begin
            stateReg <= 4'h2;
          end
        end
      end
    end else if (_T_37) begin
      if (_T_38) begin
        stateReg <= 4'h7;
      end else begin
        stateReg <= 4'h3;
      end
    end else if (_T_49) begin
      if (_T_38) begin
        stateReg <= 4'h1;
      end else begin
        stateReg <= 4'h4;
      end
    end else if (_T_63) begin
      if (_T_38) begin
        stateReg <= 4'h1;
      end else begin
        stateReg <= 4'h5;
      end
    end else if (_T_77) begin
      if (_T_38) begin
        stateReg <= 4'h1;
      end else begin
        stateReg <= 4'h6;
      end
    end else if (_T_91) begin
      stateReg <= 4'h1;
    end else if (_T_107) begin
      stateReg <= 4'h1;
    end
    if (_T) begin
      if (io_start) begin
        xReg <= 16'h0;
      end
    end else if (_T_1) begin
      if (_T_4) begin
        xReg <= _T_11;
      end
    end else if (!(_T_37)) begin
      if (!(_T_49)) begin
        if (!(_T_63)) begin
          if (!(_T_77)) begin
            if (!(_T_91)) begin
              if (_T_107) begin
                if (!(_T_108)) begin
                  xReg <= _T_11;
                end
              end
            end
          end
        end
      end
    end
    if (_T) begin
      if (io_start) begin
        yReg <= 16'h0;
      end
    end else if (_T_1) begin
      if (_T_4) begin
        yReg <= 16'h0;
      end else if (_T_18) begin
        yReg <= _T_25;
      end
    end else if (!(_T_37)) begin
      if (_T_49) begin
        if (_T_38) begin
          yReg <= _T_25;
        end
      end else if (_T_63) begin
        if (_T_38) begin
          yReg <= _T_25;
        end
      end else if (_T_77) begin
        if (_T_38) begin
          yReg <= _T_25;
        end
      end else if (_T_91) begin
        if (_T_38) begin
          yReg <= _T_25;
        end else begin
          yReg <= _T_25;
        end
      end else if (_T_107) begin
        if (_T_108) begin
          yReg <= _T_115;
        end else begin
          yReg <= 16'h0;
        end
      end
    end
    if (!(_T)) begin
      if (_T_1) begin
        if (!(_T_4)) begin
          if (!(_T_18)) begin
            if (!(_T_28)) begin
              pixelReg <= io_dataRead;
            end
          end
        end
      end else if (_T_37) begin
        if (!(_T_38)) begin
          pixelReg <= io_dataRead;
        end
      end else if (_T_49) begin
        if (!(_T_38)) begin
          pixelReg <= io_dataRead;
        end
      end else if (_T_63) begin
        if (!(_T_38)) begin
          pixelReg <= io_dataRead;
        end
      end else if (_T_77) begin
        if (!(_T_38)) begin
          pixelReg <= io_dataRead;
        end
      end
    end
  end
endmodule
module SystemTop(
  input         clock,
  input         reset,
  output        io_done,
  input         io_start,
  input         io_testerDataMemEnable,
  input  [15:0] io_testerDataMemAddress,
  output [31:0] io_testerDataMemDataRead,
  input         io_testerDataMemWriteEnable,
  input  [31:0] io_testerDataMemDataWrite
);
  wire  dataMemory_clock; // @[SystemTop.scala 18:26]
  wire [15:0] dataMemory_io_address; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_dataRead; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_writeEnable; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_dataWrite; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_testerEnable; // @[SystemTop.scala 18:26]
  wire [15:0] dataMemory_io_testerAddress; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_testerDataRead; // @[SystemTop.scala 18:26]
  wire  dataMemory_io_testerWriteEnable; // @[SystemTop.scala 18:26]
  wire [31:0] dataMemory_io_testerDataWrite; // @[SystemTop.scala 18:26]
  wire  accelerator_clock; // @[SystemTop.scala 19:27]
  wire  accelerator_reset; // @[SystemTop.scala 19:27]
  wire  accelerator_io_start; // @[SystemTop.scala 19:27]
  wire  accelerator_io_done; // @[SystemTop.scala 19:27]
  wire [15:0] accelerator_io_address; // @[SystemTop.scala 19:27]
  wire [15:0] accelerator_io_dataRead; // @[SystemTop.scala 19:27]
  wire  accelerator_io_writeEnable; // @[SystemTop.scala 19:27]
  wire [15:0] accelerator_io_dataWrite; // @[SystemTop.scala 19:27]
  DataMemory dataMemory ( // @[SystemTop.scala 18:26]
    .clock(dataMemory_clock),
    .io_address(dataMemory_io_address),
    .io_dataRead(dataMemory_io_dataRead),
    .io_writeEnable(dataMemory_io_writeEnable),
    .io_dataWrite(dataMemory_io_dataWrite),
    .io_testerEnable(dataMemory_io_testerEnable),
    .io_testerAddress(dataMemory_io_testerAddress),
    .io_testerDataRead(dataMemory_io_testerDataRead),
    .io_testerWriteEnable(dataMemory_io_testerWriteEnable),
    .io_testerDataWrite(dataMemory_io_testerDataWrite)
  );
  Accelerator accelerator ( // @[SystemTop.scala 19:27]
    .clock(accelerator_clock),
    .reset(accelerator_reset),
    .io_start(accelerator_io_start),
    .io_done(accelerator_io_done),
    .io_address(accelerator_io_address),
    .io_dataRead(accelerator_io_dataRead),
    .io_writeEnable(accelerator_io_writeEnable),
    .io_dataWrite(accelerator_io_dataWrite)
  );
  assign io_done = accelerator_io_done; // @[SystemTop.scala 23:11]
  assign io_testerDataMemDataRead = dataMemory_io_testerDataRead; // @[SystemTop.scala 34:28]
  assign dataMemory_clock = clock;
  assign dataMemory_io_address = accelerator_io_address; // @[SystemTop.scala 28:25]
  assign dataMemory_io_writeEnable = accelerator_io_writeEnable; // @[SystemTop.scala 30:29]
  assign dataMemory_io_dataWrite = {{16'd0}, accelerator_io_dataWrite}; // @[SystemTop.scala 29:27]
  assign dataMemory_io_testerEnable = io_testerDataMemEnable; // @[SystemTop.scala 36:30]
  assign dataMemory_io_testerAddress = io_testerDataMemAddress; // @[SystemTop.scala 33:31]
  assign dataMemory_io_testerWriteEnable = io_testerDataMemWriteEnable; // @[SystemTop.scala 37:35]
  assign dataMemory_io_testerDataWrite = io_testerDataMemDataWrite; // @[SystemTop.scala 35:33]
  assign accelerator_clock = clock;
  assign accelerator_reset = reset;
  assign accelerator_io_start = io_start; // @[SystemTop.scala 24:24]
  assign accelerator_io_dataRead = dataMemory_io_dataRead[15:0]; // @[SystemTop.scala 27:27]
endmodule
