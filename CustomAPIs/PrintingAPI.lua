function slowPrint(Text)
    textutils.slowPrint(Text,20)
end

function customPrint(Text,Speed) -- Speed example 20 is slow, 50 is fast.
    textutils.slowPrint(Text,Speed)
end

function fastPrint(Text)
    textutils.slowPrint(Text,50)
end


function section()
    local width, _ = term.getSize()
    local line = string.rep("-",width)
    print(line)
end