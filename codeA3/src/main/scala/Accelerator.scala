import chisel3._
import chisel3.util._

class Accelerator extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool())
    val done = Output(Bool())

    val address = Output(UInt (16.W))
    val dataRead = Input(UInt (32.W))
    val writeEnable = Output(Bool ())
    val dataWrite = Output(UInt (32.W))

    //The following signals are used by the tester to load and dump the memory contents. Do not touch.
    /*val testerDataMemEnable = Input(Bool ())
    val testerDataMemAddress = Input(UInt (16.W))
    val testerDataMemDataRead = Output(UInt (32.W))
    val testerDataMemWriteEnable = Input(Bool ())
    val testerDataMemDataWrite = Input(UInt (32.W))*/

  })







  //State enum and register
  val idle :: borderCheck :: check1 :: check2 :: check3 :: check4 :: check5 :: setWhite :: incrementY :: setBlack1 :: setBlack2 :: setNeighbour1 :: setNeighbour2 :: setNeighbour3 :: setNeighbour4 :: done :: Nil = Enum (16)


  val stateReg = RegInit(idle)

  //Support registers
  val addressReg = RegInit(0.U(16.W))
  val dataReg = RegInit(0.U(32.W))
  val xReg = Reg(UInt(32.W))
  val yReg = Reg(UInt(32.W))
  val pixelReg = Reg(UInt(32.W))
  //val registerFile = Reg(Vec(32, UInt(32.W)))

  // sbt "test:runMain SystemTopTester"
  // sbt "test:runMain HelloTester"

  //Default values
  io.writeEnable := false.B
  io.address := 0.U(32.W)
  io.dataWrite := 0.U(32.W)
  io.done := false.B

  //FSMD switch

  switch(stateReg) {
    is(idle) {
      when(io.start) {
        xReg := 0.U(32.W)
        yReg := 0.U(32.W)
        stateReg := borderCheck
      }
    }

    is(borderCheck) {
      when(xReg === 0.U(32.W) || xReg === 19.U(32.W) || yReg === 0.U(32.W) || yReg === 19.U(32.W)) {
        xReg := 0.U(32.W)
        yReg := 0.U(32.W)
        io.address := xReg * 20.U(32.W) + yReg + 400.U(32.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(32.W)
        stateReg := setBlack1
      } .otherwise {
        io.address := xReg * 20.U(32.W) + yReg
        pixelReg := io.dataRead
        stateReg := check1

      }
    }


    is(setBlack1) {
      stateReg := incrementY
      yReg := yReg + 1.U(32.W)
    }






  }













  //This signals are used by the tester for loading and dumping the data memory content, do not touch
  /*dataMemory.io.testerAddress := io.testerDataMemAddress
  io.testerDataMemDataRead := dataMemory.io.testerDataRead
  dataMemory.io.testerDataWrite := io.testerDataMemDataWrite
  dataMemory.io.testerEnable := io.testerDataMemEnable
  dataMemory.io.testerWriteEnable := io.testerDataMemWriteEnable*/

}
