import chisel3._
import chisel3.util._

class
Accelerator extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool())
    val done = Output(Bool())

    val address = Output(UInt (16.W))
    val dataRead = Input(UInt (16.W))
    val writeEnable = Output(Bool ())
    val dataWrite = Output(UInt (16.W))

  })







  //State enum and register
  val idle :: borderCheck :: check1 :: check2 :: check3 :: check4 :: check5 :: setBlack :: done :: Nil = Enum (9)


  val stateReg = RegInit(idle)

  //Support registers
  val xReg = Reg(UInt(16.W))
  val yReg = Reg(UInt(16.W))
  val pixelReg = Reg(UInt(16.W))
  //val registerFile = Reg(Vec(16, UInt(16.W)))

  // sbt "test:runMain SystemTopTester"
  // sbt "test:runMain HelloTester"

  //Default values
  io.writeEnable := false.B
  io.address := 0.U(16.W)
  io.dataWrite := 0.U(16.W)
  io.done := false.B

  //FSMD switch
  switch(stateReg) {
    is(idle) {
      when(io.start) {
        xReg := 0.U(16.W)
        yReg := 0.U(16.W)
        stateReg := borderCheck
      }
    }

    is (borderCheck) {
      when(yReg === 19.U(16.W) && xReg != 19.U(16.W)) {
        io.address := xReg * 20.U(16.W) + yReg + 400.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(16.W)

        yReg := 0.U(16.W)
        xReg := xReg + 1.U(16.W)
      } .elsewhen (xReg === 0.U(16.W) || yReg === 0.U(16.W) || xReg === 19.U(16.W) && yReg != 19.U(16.W)) {
        io.address := xReg * 20.U(16.W) + yReg + 400.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(16.W)
        yReg := yReg + 1.U(16.W)
      } .elsewhen (xReg === 19.U(16.W) && yReg === 19.U(16.W)) {
        io.address := xReg * 20.U(16.W) + yReg + 400.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(16.W)
        stateReg := done
      } .otherwise {
        io.address := xReg * 20.U(16.W) + yReg
        pixelReg := io.dataRead
        stateReg := check1
      }
    }
    is (check1) {
      when (pixelReg === 0.U(16.W)){
        io.address := xReg * 20.U(16.W) + yReg + 400.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(16.W)
        stateReg := setBlack
      } .otherwise {
        pixelReg := io.dataRead
        io.address := xReg * 20.U(16.W) + yReg - 1.U(16.W)
        stateReg := check2
      }
    }
    is (check2) {
      when (pixelReg === 0.U(16.W)){
        io.address := xReg * 20.U(16.W) + yReg + 400.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(16.W)
        yReg := yReg + 1.U(16.W)
        stateReg := borderCheck
      } .otherwise {
        pixelReg := io.dataRead
        io.address := xReg * 20.U(16.W) + yReg + 1.U(16.W)
        stateReg := check3
      }
    }
    is (check3) {
      when (pixelReg === 0.U(16.W)){
        io.address := xReg * 20.U(16.W) + yReg + 400.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(16.W)
        yReg := yReg + 1.U(16.W)
        stateReg := borderCheck
      } .otherwise {
        pixelReg := io.dataRead
        io.address := (xReg - 1.U(16.W)) * 20.U(16.W) + yReg
        stateReg := check4
      }
    }
    is (check4) {
      when (pixelReg === 0.U(16.W)){
        io.address := xReg * 20.U(16.W) + yReg + 400.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(16.W)
        yReg := yReg + 1.U(16.W)
        stateReg := borderCheck
      } .otherwise {
        pixelReg := io.dataRead
        io.address := (xReg + 1.U(16.W)) * 20.U(16.W) + yReg
        stateReg := check5
      }
    }
    is (check5) {
      when (pixelReg === 0.U(16.W)){
        io.address := xReg * 20.U(16.W) + yReg + 400.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(16.W)
        yReg := yReg + 1.U(16.W)
        stateReg := borderCheck
      } .otherwise {
        io.address := xReg * 20.U(16.W) + yReg + 400.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 255.U(16.W)
        stateReg := borderCheck
        yReg := yReg + 1.U(16.W)
      }
    }
    is(setBlack){
      when (yReg < 18.U(16.W)){
        io.address := xReg * 20.U(16.W) + yReg + 401.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(16.W)
        stateReg := borderCheck
        yReg := yReg + 2.U(16.W)
      } .otherwise {
        io.address := xReg * 20.U(16.W) + yReg + 401.U(16.W)
        io.writeEnable := true.B
        io.dataWrite := 0.U(16.W)
        stateReg := borderCheck
        yReg := 0.U(16.W)
        xReg := xReg + 1.U(16.W)
      }
    }
    is(done){
      io.done := true.B
    }
  }

}
