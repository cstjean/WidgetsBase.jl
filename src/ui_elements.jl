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

struct NumberInput{T <: Real} <: AbstractWidget{T}
    value::Observable{T}
    attributes::Dict{Symbol, Any}
end

function numberinput_type(value::Real, attrs)
    T = typeof(value)
    for key in (:step, :min, :max)
        attr = get(attrs, key, nothing)
        attr isa Real && (T = promote_type(T, typeof(attr)))
    end
    return T
end

function NumberInput(value::Real; kw...)
    attrs = Dict{Symbol, Any}(kw)
    T = numberinput_type(value, attrs)
    return NumberInput(Observable(convert(T, value)), attrs)
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
