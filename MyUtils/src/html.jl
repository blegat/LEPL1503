function reset_width(width)
    return HTML("""
<style>
    main {
        margin: 0 auto;
        max-width: $(width)px;
        padding-left: max(160px, 10%);
        padding-right: max(160px, 10%);
    }
</style>
""")
end

# `Cols` conflict with `DataFrames`
struct HAlign{T<:Tuple}
    cols::T
    dims::Vector{Int}
end
function HAlign(a::Tuple)
    n = length(a)
    return HAlign(a, div(100, n) * ones(Int, n))
end
HAlign(a, b, args...) = HAlign(tuple(a, b, args...))

function Base.show(io, mime::MIME"text/html", c::HAlign)
    x = div(100, length(c.cols))
    write(io, """<div style="display: flex; justify-content: center; align-items: center;">""")
    for (col, p) in zip(c.cols, c.dims)
        write(io, """<div style="flex: $p%;">""")
        show(io, mime, col)
        write(io, """</div>""")
    end
    write(io, """</div>""")
end
function imgpath(file)
    if !('.' in file)
        file = file * ".png"
    end
    return joinpath(joinpath(@__DIR__, "images", file))
end
function img(file, args...)
    LocalResource(imgpath(file), args...)
end
function header(title, authors)
    return HTML("<p align=center style=\"font-size: 40px;\">$title</p><p align=right><i>$authors<i></p>")
end
section(t) = md"# $t"
# with `##`, it's not centered but it works better with TableOfContents
frametitle(t) = md"## $t"

endofslides() = html"<p align=center style=\"font-size: 20px; margin-bottom: 5cm; margin-top: 5cm;\">The End</p>"

struct Join
    list
    Join(a) = new(a)
    Join(a, b, args...) = Join(tuple(a, b, args...))
end
function Base.show(io::IO, mime::MIME"text/html", d::Join)
    for el in d.list
        show(io, mime, el)
    end
end

struct HTMLTag
    tag::String
    parent
end
function Base.show(io::IO, mime::MIME"text/html", d::HTMLTag)
    write(io, "<", d.tag, ">")
    show(io, mime, d.parent)
    write(io, "</", d.tag, ">")
end

function qa(question, answer)
    return HTMLTag("details", Join(HTMLTag("summary", question), answer))
end

function _inline_html(m::Markdown.Paragraph)
    return HTML(sprint(Markdown.htmlinline, m.content))
end

_inline_html(m) = html(m)

function qa(question::Markdown.MD, answer)
    # `html(question)` will create `<p>` if `question.content[]` is `Markdown.Paragraph`
    # This will print the question on a new line and we don't want that:
    @show typeof(question)
    @show typeof(question.content[])
    h = _inline_html(question.content[])
    return qa(h, answer)
end
