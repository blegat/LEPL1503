import Luxor

function CenteredBoundedBox(str)
    xbearing, ybearing, width, height, xadvance, yadvance =
        Luxor.textextents(str)
    lcorner = Luxor.Point(xbearing - width/2, ybearing)
    ocorner = Luxor.Point(lcorner.x + width, lcorner.y + height)
    return Luxor.BoundingBox(lcorner, ocorner)
end

function boxed(str::AbstractString, p)
    Luxor.translate(p)
    Luxor.sethue("lightgrey")
    Luxor.poly(CenteredBoundedBox(str) + 5, action = :stroke, close=true)
    Luxor.sethue("black")
    Luxor.text(str, Luxor.Point(0, 0), halign=:center)
    #settext("<span font='26'>$str</span>", halign="center", markup=true)
    Luxor.origin()
end
