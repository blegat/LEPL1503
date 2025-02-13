import Clang_jll
import MultilineStrings

markdown_c(code) = Markdown.parse("```c\n" * code * "```")

function compile_and_run(code; args = String[])
    path = mktempdir()
    main_file = joinpath(path, "main.c")
    bin_file = joinpath(path, "bin")
    write(main_file, code)
    try
        Clang_jll.clang() do exe
            run(`$exe $main_file -o $bin_file`)
        end
    catch err
        if err isa ProcessFailedException
            return markdown_c(code)
        else
            rethrow(err)
        end
    end
    cmd = Cmd([bin_file; args])
    # Ça serait pas mal d'aussi afficher le code C avec syntax highlighting. Est-ce que c'est possible facilement avec Clang ?
    if !isempty(args)
        println("\$ $(string(cmd)[2:end-1])") # `2:end-1` to remove the backsticks
    end
    run(cmd)
    return markdown_c(code)
end

function wrap_in_main(code)
    if code[end] == '\n'
        code = code[1:end-1]
    end
    return """
#include <stdlib.h>

int main(int argc, char **argv) {
$(MultilineStrings.indent(code, 2))
}
"""
end

function wrap_compile_and_run(code; kws...)
    compile_and_run(wrap_in_main(code); kws...)
    return markdown_c(code)
end
