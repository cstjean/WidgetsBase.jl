struct Button{T} <: AbstractWidget{Bool}
    content::Observable{T}
    value::Observable{Bool}
    attributes::Dict{Symbol, Any}
end

function Button(content; kw...)
    return Button(
        Observable(content), Observable(false), Dict{Symbol, Any}(kw)
    )
end

struct TextField <: AbstractWidget{String}
    value::Observable{String}
    attributes::Dict{Symbol, Any}
end

function TextField(value::String; kw...)
    TextField(Observable(value), Dict{Symbol, Any}(kw))
end

struct NumberInput <: AbstractWidget{Float64}
    value::Observable{Float64}
    attributes::Dict{Symbol, Any}
end

const NUMBERINPUT_INTEGER_DISPLAY_KEY = :bonito_integer_display

numberinput_float_attribute(value::AbstractFloat) = true
numberinput_float_attribute(value::Observable) = numberinput_float_attribute(value[])
numberinput_float_attribute(value) = false

function numberinput_prefers_float_display(value, attrs)
    isinteger(value) || return true
    haskey(attrs, :step) && numberinput_float_attribute(attrs[:step]) && return true
    haskey(attrs, :min) && numberinput_float_attribute(attrs[:min]) && return true
    haskey(attrs, :max) && numberinput_float_attribute(attrs[:max]) && return true
    return false
end

function NumberInput(value::Float64; kw...)
    attrs = Dict{Symbol, Any}(kw)
    attrs[NUMBERINPUT_INTEGER_DISPLAY_KEY] = !numberinput_prefers_float_display(value, attrs)
    return NumberInput(Observable(value), attrs)
end

struct Slider{T <: AbstractRange, ET} <: AbstractWidget{T}
    range::Observable{T}
    value::Observable{ET}
    attributes::Dict{Symbol, Any}
end

function Slider(range::T, value = first(range); kw...) where T <: AbstractRange
    Slider{T, eltype(range)}(
        to_node(range),
        to_node(value),
        Dict{Symbol, Any}(kw)
    )
end

@enum Orientation vertical horizontal

struct RangeSlider{T <: AbstractRange, ET <: AbstractArray} <: AbstractWidget{T}
    attributes::Dict{Symbol, Any}
    range::Observable{T}
    value::Observable{ET}
    connect::Observable{Bool}
    orientation::Observable{Orientation}
    tooltips::Observable{Bool}
    ticks::Observable{Dict{String, Any}}
end

function RangeSlider(range::T; value = [first(range)], kw...) where T <: AbstractRange
    RangeSlider{T, typeof(value)}(
        Dict{Symbol, Any}(kw),
        Observable(range),
        Observable(value),
        Observable(true),
        Observable(horizontal),
        Observable(false),
        Observable(Dict{String, Any}()),
    )
end

struct Checkbox <: AbstractWidget{Bool}
    value::Observable{Bool}
    attributes::Dict{Symbol, Any}
end

function Checkbox(value::Bool; kw...)
    return Checkbox(Observable(value), Dict{Symbol, Any}(kw))
end
