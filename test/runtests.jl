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
    @test number_input.value isa WidgetsBase.Observable{Float64}
    number_input = NumberInput(66)
    @test number_input[] == 66
    @test number_input.value isa WidgetsBase.Observable{Int}
    @test NumberInput(66; step=1).value isa WidgetsBase.Observable{Int}
    @test NumberInput(66; step=1.0).value isa WidgetsBase.Observable{Float64}
    @test NumberInput(66; min=0.0).value isa WidgetsBase.Observable{Float64}
    @test NumberInput(66; max=100.0).value isa WidgetsBase.Observable{Float64}
    @test NumberInput(66; step="1", min="0", max="100").value isa WidgetsBase.Observable{Int}
    rslider = RangeSlider(1:100; value=[10, 80])
    @test rslider[] == [10, 80]

    checbkox = Checkbox(true)
    @test checbkox[] == true
end
