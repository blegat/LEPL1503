import Clang_jll

function compile_and_run(code; args = String[])
    path = mktempdir()
    main_file = joinpath(path, "main.c")
    bin_file = joinpath(path, "bin")
    write(main_file, code)
    Clang_jll.clang() do exe
    	run(`$exe $main_file -o $bin_file`)
    end
    cmd = Cmd([bin_file; args])
    # Ça serait pas mal d'aussi afficher le code C avec syntax highlighting. Est-ce que c'est possible facilement avec Clang ?
    if !isempty(args)
        println("\$ $(string(cmd)[2:end-1])") # `2:end-1` to remove the backsticks
    end
    run(cmd)
    return Markdown.parse("```c\n" * code * "```")
end
