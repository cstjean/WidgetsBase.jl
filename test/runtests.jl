using WidgetsBase
using Test

@testset "Widgets.jl" begin
    s1 = Slider(1:100)
    @test s1[] == 1
    b = Button("hi")
    @test b[] == false
    t = TextField("Write!")
    @test t[] == "Write!"
    number_input = NumberInput(66.0)
    @test number_input[] == 66
    @test number_input.attributes[WidgetsBase.NUMBERINPUT_INTEGER_DISPLAY_KEY]
    @test NumberInput(66.0; step=1).attributes[WidgetsBase.NUMBERINPUT_INTEGER_DISPLAY_KEY]
    @test !NumberInput(66.5; step=1).attributes[WidgetsBase.NUMBERINPUT_INTEGER_DISPLAY_KEY]
    @test !NumberInput(66.0; step=1.0).attributes[WidgetsBase.NUMBERINPUT_INTEGER_DISPLAY_KEY]
    @test !NumberInput(66.0; min=0.0).attributes[WidgetsBase.NUMBERINPUT_INTEGER_DISPLAY_KEY]
    @test !NumberInput(66.0; max=100.0).attributes[WidgetsBase.NUMBERINPUT_INTEGER_DISPLAY_KEY]

    number_input = NumberInput(66.5; step=1)
    number_input[] = 67.0
    @test !number_input.attributes[WidgetsBase.NUMBERINPUT_INTEGER_DISPLAY_KEY]
    rslider = RangeSlider(1:100; value=[10, 80])
    @test rslider[] == [10, 80]

    checbkox = Checkbox(true)
    @test checbkox[] == true
end
