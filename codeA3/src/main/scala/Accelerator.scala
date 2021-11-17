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

  })







  //State enum and register
  val idle :: borderCheck :: check1 :: check2 :: check3 :: check4 :: check5 :: increment :: setBlack2 :: done :: Nil = Enum (10)


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
        io.address := xReg * 20.U(32.W) + yReg + 400.U(32.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(32.W)
        stateReg := increment
        yReg := yReg + 1.U(32.W)
      } .otherwise {
        io.address := xReg * 20.U(32.W) + yReg
        pixelReg := io.dataRead
        stateReg := check1
      }
    }

    is(increment) {
      when (xReg === 19.U(32.W) && yReg === 20.U(32.W)){
        stateReg := done
      } .elsewhen(yReg < 20.U(32.W)){
        stateReg := borderCheck
      } .elsewhen(yReg >= 20.U(32.W)) {
        xReg := xReg + 1.U(32.W)
        yReg := 0.U(32.W)
        stateReg := borderCheck
      }
    }
    is(check1) {
      when(pixelReg === 0.U(32.W)) {
        io.address := xReg * 20.U(32.W) + yReg + 400.U(32.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(32.W)
        stateReg := setBlack2
      } .otherwise {
        pixelReg := io.dataRead
        io.address := xReg * 20.U(32.W) + yReg - 1.U(32.W)
        stateReg := check2
      }
    }

    is(check2){
      when(pixelReg === 0.U(32.W)){
        stateReg := increment
        io.address := xReg * 20.U(32.W) + yReg + 400.U(32.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(32.W)
        yReg := yReg + 1.U(32.W)
      } .otherwise {
        pixelReg := io.dataRead
        io.address := xReg * 20.U(32.W) + yReg + 1.U(32.W)
        stateReg := check3
      }
    }
    is(check3){
      when(pixelReg === 0.U(32.W)){
        stateReg := increment
        io.address := xReg * 20.U(32.W) + yReg + 400.U(32.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(32.W)
        yReg := yReg + 1.U(32.W)
      } .otherwise {
        pixelReg := io.dataRead
        io.address := (xReg - 1.U(32.W)) * 20.U(32.W) + yReg
        stateReg := check4
      }
    }
    is(check4){
      when(pixelReg === 0.U(32.W)){
        stateReg := increment
        io.address := xReg * 20.U(32.W) + yReg + 400.U(32.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(32.W)
        yReg := yReg + 1.U(32.W)
      } .otherwise {
        pixelReg := io.dataRead
        io.address := (xReg + 1.U(32.W)) * 20.U(32.W) + yReg
        stateReg := check5
      }
    }
    is(check5){
      when(pixelReg === 0.U(32.W)){
        stateReg := increment
        io.address := xReg * 20.U(32.W) + yReg + 400.U(32.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(32.W)
        yReg := yReg + 1.U(32.W)
      } .otherwise {
        stateReg := increment
        io.address := xReg * 20.U(32.W) + yReg + 400.U(32.W)
        io.writeEnable := true.B
        io.dataWrite := 255.U(32.W)
        yReg := yReg + 1.U(32.W)
      }
    }

    is(setBlack2){
      stateReg := increment
      io.address := xReg * 20.U(32.W) + yReg + 400.U(32.W)
      io.writeEnable := true.B
      io.dataWrite := 0.U(32.W)
      yReg := yReg + 2.U(32.W)
    }

    is(done){
      io.done := true.B
    }
  }
}
