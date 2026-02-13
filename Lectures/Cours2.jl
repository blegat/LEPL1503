### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 90a4fe3c-02c7-46e6-b2fb-526e73508101
using PlutoUI, PlutoUI.ExperimentalLayout, PlutoTeachingTools, HypertextLiteral

# ╔═╡ 68b3f601-8cc3-45b2-93f6-8fdbc9cd3411
@htl("""
<p align=center style=\"font-size: 40px;\">LEPL1503/LSINC1503 - Cours 2</p><p align=right><i>O. Bonaventure, B. Legat, M. Baerts</i></p>
$(PlutoTeachingTools.ChooseDisplayMode())
$(PlutoUI.TableOfContents(depth=1))
""")

# ╔═╡ 5bd30ea4-3193-4fb4-9bf8-369fcfa6547b
md"""
* `int argc` : Le nombre d'arguments (incluant le nom de l'exécutable)
* `char **argv` : liste des arguments initialisée par le système d’exploitation au lancement du programme
"""

# ╔═╡ 47279972-433b-46be-b511-170698ff8753
md"""
Comment construire une matrice ?
"""

# ╔═╡ 42e6ffd9-27b6-49bc-8518-2d7d4b7ffc40
md"Une telle matrice sera stockée sur le **stack** (variable locale) ou dans la zone données (variable globale)"

# ╔═╡ 1a82ab2b-dd7c-4b48-b263-e71b13ba0fb2
md"""
Si la matrice a été créée par
```c
float **matrice = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice[0] = ligne0;
matrice[1] = ligne1;
```
"""

# ╔═╡ 87877209-958b-4635-bdbc-97548acdfb3f
md"""
Toutes les fonctions doivent vérifier leurs arguments et retourner
* -1 en cas d'erreur
* 0 en cas de succès
"""

# ╔═╡ b66c9e2f-17b3-44dc-83e4-cb3a9329039b
md"Quels arguments ?"

# ╔═╡ 406d30a9-f477-4898-9caf-770fcc25b2a9
md"Comment libérer la mémoire quand le vecteur est devenu inutile ?"

# ╔═╡ 14a56b43-789a-42f0-9228-0c6a660629c9
md"`mapreduce` donne un exemple de fonction d'ordre supérieur en C"

# ╔═╡ b8392f14-05d4-43e4-bd2a-3d4ba6ced65b
md"Laquelle de ces deux fonctions présente une façon correcte de retourner un tableau ?"

# ╔═╡ 20d23ab4-ae24-4169-92be-ed9ec77c5518
aside(md"[Source](https://learn.adafruit.com/memories-of-an-arduino/measuring-free-memory)", v_offset = -200)

# ╔═╡ e0bfde10-5b3d-48b2-aa03-a1e6b0fc97e3
html"<p align=center style=\"font-size: 20px; margin-bottom: 5cm; margin-top: 5cm;\">The End</p>"

# ╔═╡ 378c90d9-e206-4858-b362-4015ca46bbb0
section(s) = md"# $s"

# ╔═╡ 3ddd22b2-7d1b-4b3a-8737-09552b51726d
section("Variables, pointeurs et doubles pointeurs")

# ╔═╡ b588a04d-6a3f-424e-a83a-eec1dfafc9dd
section("Matrices sur le heap")

# ╔═╡ 336f53c9-5982-4694-8bd4-92c2a1d1b5cc
section("Initialisation d'une valeur")

# ╔═╡ c81abb3d-7192-499e-a47a-c0b960aa49cd
section("Libération de la mémoire")

# ╔═╡ 49f0db66-da21-42b0-91d5-db04075e559a
section("Un vecteur \"Java\" en C")

# ╔═╡ 6f257725-72c3-404c-bb35-079265058a43
section("Pointeur de fonction")

# ╔═╡ 4e5e1340-c2e6-4b4a-bfb9-e1096d179040
section("Retourner un tableau")

# ╔═╡ 319bc8b4-7139-43b0-a57b-66c6a9da7cb9
section("Structure différente du stack et heap")

# ╔═╡ 3b6a95e0-96e9-4634-9207-42ace759e738
frametitle(s) = md"## $s"

# ╔═╡ fc027d24-619e-4f6f-95ed-3dd12f61b60c
frametitle("Visualisation")

# ╔═╡ cd3cce7d-b149-4ee1-8b6e-ff213a48ce7d
frametitle("Arguments de main")

# ╔═╡ acfa3f43-215e-4c97-bf2a-0069e78f95b4
frametitle("Matrices en C")

# ╔═╡ 848723a1-4a62-47b2-957c-167ce9be19f8
frametitle("Comment mettre une matrice 2x2 sur le heap ?")

# ╔═╡ a39d8ac8-70e6-47a5-b80d-e1443c19ae15
frametitle("Première approche, un malloc par ligne")

# ╔═╡ 3b5e218f-c134-40a9-9bc3-1fbab8d64d62
frametitle("Deuxième approche, un malloc pour toutes les valeurs")

# ╔═╡ 37f6e305-fb5c-4215-b8a1-564a7632a377
frametitle("Comment initialiser la première valeur ?")

# ╔═╡ c73a9ebe-9597-4c49-8493-aec1d71a281a
frametitle("Comment faire matrice[0][1] = 0 ?")

# ╔═╡ 67cf8ac0-5b91-4d19-aca4-4309f3109a0c
frametitle("Comment faire matrice[1][0] = 2 ?")

# ╔═╡ 92428490-6d76-44a7-9d5b-a9e988f5ff25
frametitle("L'importance de l'ordre de désallocation")

# ╔═╡ 90532252-a756-40a1-8867-76041f5545a0
frametitle("Toujours free dans le sens inverse de malloc")

# ╔═╡ 7838b43b-428d-4045-8cfe-17c9a824ac65
frametitle("Première implémentation")

# ╔═╡ f386a8d4-35be-4612-91c7-31ff0f004e2d
frametitle("Une autre implémentation …")

# ╔═╡ 6cc7a1d4-df02-494f-bf18-0652d49280e5
frametitle("Initialisation")

# ╔═╡ 0e0ddf7c-a34b-447a-8142-334d14f96ae1
frametitle("Allocation de la mémoire")

# ╔═╡ 2e1fc3ec-c1ca-43b8-893c-bda691635475
frametitle("Visualization de init")

# ╔═╡ 4b009812-191d-4969-bf32-5941ca707f37
frametitle("Récupération d'un élément")

# ╔═╡ 44c8617f-ba56-40fe-80b4-963cf6e6f4b5
frametitle("Modification d'un élément")

# ╔═╡ 03847d85-c675-4b4a-9331-fd7a32b26938
frametitle("Libération de la mémoire")

# ╔═╡ 8283cc88-a3c8-4bb2-af31-0b72f2eb2c4a
frametitle("Heap ou stack ?")

# ╔═╡ 4643cd02-67f4-40cd-aa7d-cfdb83fc62be
frametitle("Retourner un tableau : visualization")

# ╔═╡ ecc856dc-e6f2-4a91-8c37-0bb920531297
import HTTP, Clang_jll, MultilineStrings

# ╔═╡ c132bea8-1ffe-4015-aaa7-66a67a806f48
begin
abstract type Code end

struct CCode <: Code
    code::String
end

macro c_str(s)
    return :($CCode($(esc(s))))
end

struct CppCode <: Code
    code::String
end

macro cpp_str(s)
    return :($CppCode($(esc(s))))
end

struct CLCode <: Code
    code::String
end

macro cl_str(s)
    return :($CLCode($(esc(s))))
end

struct JavaCode <: Code
    code::String
end

macro java_str(s)
    return :($JavaCode($(esc(s))))
end

source_extension(::CCode) = "c"
source_extension(::CppCode) = "cpp"
source_extension(::CLCode) = "cl"
source_extension(::JavaCode) = "java"

compiler(::CCode, mpi::Bool) = mpi ? "mpicc" : "clang"
function compiler(::CppCode, mpi::Bool)
    @assert !mpi
    return "clang++"
end

inline_code(code::AbstractString, ext::String) = HTML("""<code class="language-$ext">$code</code>""")
inline_code(code::Code) = inline_code(code.code, source_extension(code))

function md_code(code::AbstractString, ext::String)
    code = "```" * ext * '\n' * code
    if code[end] != '\n'
        code *= '\n'
    end
    return Markdown.parse(code * "```")
end
md_code(code::Code) = md_code(code.code, source_extension(code))
function Base.show(io::IO, m::MIME"text/html", code::Code)
    return show(io, m, md_code(code))
end

function compile(
    code::Code;
    lib,
    emit_llvm = false,
    cflags = ["-O3"],
    mpi::Bool = false,
    use_system::Bool = mpi || "-fopenmp" in cflags, # `-fopenmp` will not work with pure Clang_jll, it needs openmp installed as well
    verbose = 0,
)
    path = mktempdir()
    main_file = joinpath(path, "main." * source_extension(code))
    bin_file = joinpath(path, ifelse(emit_llvm, "main.llvm", ifelse(lib, "lib.so", "bin")))
    write(main_file, code.code)
    args = String[]
    if !use_system && code isa CppCode
        # `clang++` is not part of `Clang_jll`
        push!(args, "-x")
        push!(args, "c++")
    end
    append!(args, cflags)
    if lib
        push!(args, "-fPIC")
        push!(args, "-shared")
    end
    if emit_llvm
        push!(args, "-S")
        push!(args, "-emit-llvm")
    end
    push!(args, main_file)
    push!(args, "-o")
    push!(args, bin_file)
    try
        if use_system
            cmd = Cmd([compiler(code, mpi); args])
            if verbose >= 1
                @info("Compiling : $cmd")
            end
            run(cmd)
        else
            Clang_jll.clang() do exe
                cmd = Cmd([exe; args])
                if verbose >= 1
                    @info("Compiling : $cmd")
                end
                run(cmd)
            end
        end
    catch err
        if err isa ProcessFailedException
            return
        else
            rethrow(err)
        end
    end
    return bin_file
end

function emit_llvm(code; kws...)
    llvm = compile(code; lib = false, emit_llvm = true, kws...)
    InteractiveUtils.print_llvm(stdout, read(llvm, String))
    return code
end

function compile_lib(code::Code; kws...)
    return codesnippet(code), compile(code; lib = true, kws...)
end

function compile_and_run(code::Code; verbose = 0, args = String[], valgrind::Bool = false, mpi::Bool = false, num_processes = nothing, show_run_command = !isempty(args) || verbose >= 1, kws...)
    bin_file = compile(code; lib = false, mpi, verbose, kws...)
    if !isnothing(bin_file)
        cmd_vec = [bin_file; args]
        if valgrind
            cmd_vec = ["valgrind"; cmd_vec]
        end
        if mpi
            if !isnothing(num_processes)
                cmd_vec = [["-n", string(num_processes)]; cmd_vec]
            end
            cmd_vec = ["mpiexec"; cmd_vec]
        end
        cmd = Cmd(cmd_vec)
        if show_run_command
            @info("Running : $cmd") # `2:end-1` to remove the backsticks
        end
        try
            run(cmd)
        catch err
            @warn(string(typeof(err)))
        end
    end
    return codesnippet(code)
end

function wrap_in_main(content)
    code = content.code
    if code[end] == '\n'
        code = code[1:end-1]
    end
    return typeof(content)("""
#include <stdlib.h>

int main(int argc, char **argv) {
$(MultilineStrings.indent(code, 2))
}
""")
end

function wrap_compile_and_run(code; kws...)
    compile_and_run(wrap_in_main(code); kws...)
    return code
end

# TODO It would be nice if the user could select a dropdown or hover with the mouse and see the full code
function codesnippet(code::Code)
    lines = readlines(IOBuffer(code.code))
    i = findfirst(line -> contains(line, "codesnippet"), lines)
    if isnothing(i)
        return code
    end
    j = findlast(line -> contains(line, "codesnippet"), lines)
    return typeof(code)(join(lines[i+1:j-1], '\n'))
end

struct Example
    name::String
end

function code(example::Example)
    code = read(joinpath(dirname(dirname(dirname(@__DIR__))), "examples", example.name), String)
    ext = split(example.name, '.')[end]
    if ext == "c"
        return CCode(code)
    elseif ext == "cpp" || ext == "cc"
        return CppCode(code)
    elseif ext == "cl"
        return CLCode(code)
    else
        error("Unrecognized extension `$ext`.")
    end
end

function compile_and_run(example::Example; kws...)
    return compile_and_run(code(example); kws...)
end

function compile_lib(example::Example; kws...)
    return compile_lib(code(example); kws...)
end
end

# ╔═╡ 6d3d7f63-766b-4a1f-91c3-46b401c4c280
compile_and_run(c"""
#include <stdio.h>
int main(int argc, char **argv) {
  for(int i=0; i<argc; i++) {
    printf("arg[%d]: %s\n", i, argv[i]);
  }
}
""", args = ["ab", "cd", "ef"])

# ╔═╡ 1f190c17-4feb-41b2-a10a-60fb191d250e
wrap_compile_and_run(c"""
float A[2][2]={ {1,0}, {2,3} };
A[1][1] = 4;
""")

# ╔═╡ 8f156e1d-5816-4c56-9aec-ad665d2bc782
wrap_compile_and_run(c"""
float *matrice1=(float *) malloc(4 * sizeof(float));
matrice1[1][1] = 4;
""")

# ╔═╡ 0b41747b-fe00-49a0-9ed9-99f0b2046b2e
c"""
float **matrice = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice[0] = ligne0;
matrice[1] = ligne1;
matrice[0][0] = 1; // 1
*(matrice[0]) = 1; // 2
*(matrice) = 1;    // 3
"""

# ╔═╡ b5388c3e-bcaf-43b6-b9d9-c9979f2afce2
c"""
float **matrice = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice[0] = ligne0;
matrice[1] = ligne1;
*(*matrice+1)=0;   // 1
*(matrice++)=0;    // 2
*(matrice[0]+1)=0; // 3
"""

# ╔═╡ 9160427d-4db7-4a97-9dde-14d19d59b1ef
c"""
float **matrice = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice[0] = ligne0;
matrice[1] = ligne1;
*(*(++matrice))=2; // 1
*(*(matrice+1))=2; // 2
*(*matrice+1)=2;   // 3
"""

# ╔═╡ b66272c8-02b0-4d22-84d6-7274efe11e2a
c"""
struct vector_t {
  int size;
  float *v;
};
"""

# ╔═╡ f3dd8bf7-03c4-4069-8d1c-ece484de5ef1
c"""struct vector_t {
  int length; // nombre d'élements
  float *tab; // tableau avec les réels
};"""

# ╔═╡ facc8d63-d620-40ff-939a-78ff58fff04f
c"""struct vector_t {
  int length; // nombre d'élements
  float *tab; // tableau avec les réels
};"""

# ╔═╡ c2928a50-8f63-477e-ada3-1352d5c72712
c"""
/*
 * @pre
 * alloue la mémoire pour un vecteur de size éléments
 * initialisés à la valeur val
 * @return -1 si erreur, 0 sinon
 */

int init(int size, float val,
  struct vector_t  v,     // 1
  struct vector_t ** v,   // 2
  struct vector_t * v,    // 3
)
"""

# ╔═╡ 1ca8b74a-ce74-44a3-9e74-1447eb5141a7
c"""struct vector_t {
  int length; // nombre d'élements
  float *tab; // tableau avec les réels
};"""

# ╔═╡ dd7f51b5-ca6a-4eb4-802d-9514861ae6a4
c"""
int init(int size, float val, struct vector_t ** v) {
  if ((size<0) || v==NULL)
    return -1;
  *v=(struct vector_t *)
     malloc(sizeof(struct vector_t));
  if (*v == NULL) {
    return -1;
  }
  (*v)->tab=(float *)malloc(size*sizeof(float));
  if ((*v)->tab == NULL) {
     return -1;
  }
  (*v)->length = size;
  for (int i = 0; i<size; i++) {
"""

# ╔═╡ b58ba8eb-0661-4eac-8ead-2daff4126d57
c"""
  }
  return 0;
}
"""

# ╔═╡ 4072072d-c543-43bf-87ad-1f201bd21c59
c"""struct vector_t {
  int length; // nombre d'élements
  float *tab; // tableau avec les réels
};"""

# ╔═╡ 5b8e5130-bf78-4529-b3be-02a0ba093f12
c"""
/*
 * @pre
 * @post retourne le ième élément du tableau dans val
 *       -1 en cas d'erreur, 0 sinon
 */

int get(struct vector_t *v, int i,
  float val   // 1
  float **val // 2
  float *val  // 3
) {
"""

# ╔═╡ c306afc9-f86e-4407-8757-272561980a72
c"""/*
 * @pre
 * @post place val comme ième élément
 *             du tableau
 *       -1 en cas d'erreur, 0 sinon
 */

int set(struct vector_t *v, int i,
struct vector_t  v     // 1
struct vector_t ** v   // 2
struct vector_t * v    // 3
) {"""

# ╔═╡ cb9c27b9-ce7d-4bdf-af7d-c88883a210bc
c"""
/*
 * libère la mémoire utilisée pour le vecteur
 * -1 en cas d'erreur, 0 sinon
 */
"""

# ╔═╡ 27b6779a-5624-4e8e-ae32-8a8971923d01
c"""
int *stack() {
  int v[] = {1, 2, 3};
  return v;
}

int *heap() {
  int *v = (int *) malloc(3 * sizeof(int));
  v[0] = 1; v[1] = 2; v[2] = 3;
  return v;
}"""

# ╔═╡ d107cd6f-c45c-4289-bd0f-5f329633fdda
# No need to go beyond `620` because pythontutor will just add an internal slider an not show full code
function tutor(code::Code; width = 800, height = min(620, 260 + 20 * countlines(IOBuffer(code.code))), frameborder = 0, curInstr = 0)
	esc_code = HTTP.escapeuri(code.code)
    src = "https://pythontutor.com/iframe-embed.html#code=$esc_code&cumulative=false&py=$(source_extension(code))&curInstr=$curInstr"
	return HTML("""<iframe width="$width" height="$height" frameborder="$frameborder" src="$src"></iframe>""")
end

# ╔═╡ a8783da7-4e44-4012-be6e-88705697b0c5
tutor(wrap_in_main(c"""
int x;
int *px;
int **ppx;
x=1;
px=(int *) malloc(sizeof(int));
*px=2;
ppx=(int **) malloc(sizeof(int*));
*ppx=(int *) malloc(sizeof(int));
**ppx=3;
"""))

# ╔═╡ 324b41a3-4b01-4589-8ca5-28ec148cdeb1
tutor(wrap_in_main(c"""
float **matrice2 = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice2[0] = ligne0;
matrice2[1] = ligne1;
matrice2[1][1] = 4;
"""))

# ╔═╡ 654184b1-4b5e-4c90-800e-b413a04eeea1
tutor(wrap_in_main(c"""
float **matrice3 = (float **) malloc(2 * sizeof(float *));
float *valeurs = (float *) malloc(4 * sizeof(float));
matrice3[0] = valeurs;
matrice3[1] = valeurs + 2;
matrice3[1][1] = 4;
"""), width = 800)

# ╔═╡ 2d35189b-46aa-4922-ad4f-432533da2a80
tutor(wrap_in_main(c"""
float **matrice = (float **) malloc(2 * sizeof(float *));
matrice[0] = (float *) malloc(2 * sizeof(float));
matrice[1] = (float *) malloc(2 * sizeof(float));
free(matrice);
free(matrice[0]);
free(matrice[1]);
"""))

# ╔═╡ 85e1517c-f7d9-4df5-acde-00657cdf3dbe
tutor(c"""
#include <stdlib.h>

struct vector_t {
  int length; // nombre d'élements
  float *tab; // tableau avec les réels
};

int init(int size, float val, struct vector_t ** v) {
  if( (size<0)|| v==NULL)
    return -1;
  *v=(struct vector_t *)
     malloc(sizeof(struct vector_t));
  if(*v==NULL) {
    return -1;
  }
  (*v)->tab=(float *)malloc(size*sizeof(float));
  if((*v)->tab==NULL) {
     return -1;
  }
  (*v)->length = size;
  for (int i = 0;i<size;i++) {
    float *t = (*v)->tab;
    t[i] = val;
    // ou *((*v)->tab+i)=val;
  }
  return 0;
}
int main () {
  struct vector_t *ptr = NULL;
  int err = init(4, 1.23, &ptr);
}
""")

# ╔═╡ 3cc18d67-b0d7-4b4b-afb6-5b48eddd89d2
tutor(c"""
#include <stdlib.h>
#include <stdio.h>

int square(int a) {
  return a * a;
}
int plus(int a, int b) {
  return a + b;
}

int mapreduce(int (*f)(int), int (*op)(int, int), int *vec, int len, int init) {
  for (int i = 0; i < len; i++) {
    init = op(init, f(vec[i]));
  }
  return init;
}

int main () {
  int vec[] = {1, 2, 3, 4};
  printf("%d\\n", mapreduce(square, plus, vec, 4, 0));
}
""")

# ╔═╡ accfaade-96ce-4869-83ce-9dd5489b65a2
tutor(c"""
#include <stdlib.h>

int *stack() {
  int v[] = {1, 2, 3};
  return v;
}

int *heap() {
  int *v = (int *) malloc(3 * sizeof(int));
  v[0] = 1; v[1] = 2; v[2] = 3;
  return v;
}

int main () {
  int *v1 = heap();
  printf("%d %d %d\\n", v1[0], v1[1], v1[2]);
  free(v1); // don't forget!
  int *v2 = stack();
  printf("%d %d %d\\n", v2[0], v2[1], v2[2]);
  return 0;
}
""")

# ╔═╡ 65ae6528-ef2c-48fd-94e9-56224e19863e
begin
struct Path
    path::String
end

function imgpath(path::Path)
    file = path.path
    if !('.' in file)
        file = file * ".png"
    end
    return joinpath(joinpath(@__DIR__, "images", file))
end

function img(path::Path, args...; kws...)
    return PlutoUI.LocalResource(imgpath(path), args...)
end

struct URL
    url::String
end

function save_image(url::URL, html_attributes...; name = split(url.url, '/')[end], kws...)
    path = joinpath("cache", name)
    return PlutoTeachingTools.RobustLocalResource(url.url, path, html_attributes...), path
end

function img(url::URL, args...; kws...)
    r, _ = save_image(url, args...; kws...)
    return @htl("<a href=$(url.url)>$r</a>")
end

function img(file::String, args...; kws...)
    if startswith(file, "http")
        img(URL(file), args...; kws...)
    else
        img(Path(file), args...; kws...)
    end
end
end

# ╔═╡ 132663c2-dfdd-4426-991a-bc9c95bbdad1
hbox([
	md"""
* Stack : Pile de mémoire locale des functions, structure connue à la **compilation**
* Heap : Alloué et désalloué avec des tailles connues à l'**exécution**. L'OS fait de son mieux pour organiser cette mémoire et réassigner les fragments formés suite aux désallocations


""",
	img("heapstack", :width => "350px"),
])

# ╔═╡ 8c115304-6a8e-4c2e-aeb2-9199c9d3b704
three_columns(left, center, right) = hbox([
	left,
	Div(html" ", style = Dict("flex-grow" => "1")),
	center,
	Div(html" ", style = Dict("flex-grow" => "1")),
	right,
])

# ╔═╡ ad6a791b-14f0-4a20-ad5b-ec1690253bd9
function wooclap(link)
	logo = HTML("""<img alt="Wooclap Logo" src="https://www.wooclap.com/images/wooclap-logo.svg">""")
	url = "https://app.wooclap.com/$link"
	a = HTML("""<a style="margin-left: 80px;" href="https://app.wooclap.com/$link"><tt>$url</tt></a>""")
	qr = img("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$url", :height => 50, name = "$link.png")
	return three_columns(logo, a, qr)
end

# ╔═╡ a07e8aea-790b-4307-9de1-e45c6a3f7cf4
wooclap("JAPRXX")

# ╔═╡ 38e67b29-707f-4718-b9cc-2a1a62f32143
wooclap("JAPRXX")

# ╔═╡ 6531f0d6-cf62-46ca-8dd2-befda43806d7
wooclap("JAPRXX")

# ╔═╡ ec120913-bafb-4abb-8ebd-a0e3b72578f6
wooclap("JAPRXX")

# ╔═╡ 9cb862ff-275e-4f1d-8104-c1b8350725da
wooclap("JAPRXX")

# ╔═╡ a6ca2092-6435-4081-a407-c3d0286efb62
wooclap("JAPRXX")

# ╔═╡ dd918d12-bde4-4a1d-88c2-a9a643f39b2e
wooclap("JAPRXX")

# ╔═╡ 7808e8d0-597c-422a-95eb-cc581fb65d87
wooclap("JAPRXX")

# ╔═╡ 594773b5-7e89-41a1-a873-387a096ee3b5
wooclap("JAPRXX")

# ╔═╡ 986cdd2f-c22a-497b-8ce4-d6755a871c15
wooclap("JAPRXX")

# ╔═╡ a13bf677-9c63-4f8e-b3dd-27b3aad7f956
wooclap("JAPRXX")

# ╔═╡ 2140d0e6-cd51-465b-bfc5-bdbfe077bc58
begin
function qa(question, answer)
    return @htl("<details><summary>$question</summary>$answer</details>")
end
function _inline_html(m::Markdown.Paragraph)
    return sprint(Markdown.htmlinline, m.content)
end
function qa(question::Markdown.MD, answer)
    # `html(question)` will create `<p>` if `question.content[]` is `Markdown.Paragraph`
    # This will print the question on a new line and we don't want that:
    h = HTML(_inline_html(question.content[]))
    return qa(h, answer)
end
end

# ╔═╡ 62198fa2-4e96-4950-a99e-a3808bbf811a
qa(md"Comment libérer la mémoire avec `free` ?",
c"""
free(ligne0);
free(ligne1);
free(matrice);
""")

# ╔═╡ 488d8bed-855f-470a-a2fa-68c13fd08739
qa(c"struct vector_t * init(int size, float val) {", c"""
  // manque tests erreur malloc
  struct vector_t *t=(struct vector_t *)
          malloc(sizeof(struct vector_t));
  t->v=(float *)malloc(size*sizeof(float));
  t->size=size;
  for(int i=0;i<size;i++) {
    *(t->v+i)=val;
  }
  return t;
}
""")

# ╔═╡ 419f48c0-8377-4a67-a801-e87d2a61c17a
qa(c"float get(struct vector_t *t, int i) {", c"""
  return *(t->v+i);
}""")

# ╔═╡ cfc54158-a170-4f1d-b1dd-ab8e0f1a172e
qa(c"void set(struct vector_t *t, int i, float val) {", c"""
  if((i<t->size)&&(i>0))
    *(t->v+i)=val;
}""")

# ╔═╡ 4dad1e1b-2288-49b9-8190-f2f374ca353c
qa(c"void destroy(struct vector_t *vect) {", c"""
  free(vect->v);
  free(vect);
}""")

# ╔═╡ e5e45ef0-32ac-403c-a05e-de267209fb8b
qa(md"Comment assigner la valeur `val` au `i`ième élément ?", md"""
```c
float *t = (*v)->tab;
t[i] = val;
```
ou
```c
*((*v)->tab+i)=val;
```
""")

# ╔═╡ 7f150e04-b56b-499f-ad50-4f586e76a0ab
qa(md"Comment implémenter `get` ?", c"""
  if (i < 0 || i >= v->length)
    return -1;
  *val = *(v->tab+i);
  return 0;
}
""")

# ╔═╡ d85db8cc-56b6-42e5-8175-3c53d345282e
qa(md"Comment implémenter `set` ?", c"""
  if (i < 0 || i >= v->length)
    return -1;
  *(v->tab+i) = val;
  return 0;
}
""")

# ╔═╡ e1b6f1d3-9d06-4ee4-854d-8ede288f369c
qa(c"int destroy(struct vector_t *v) {", c"""
  free(v->tab);
  free(v);
  return 0;
}""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Clang_jll = "0ee61d77-7f21-5576-8119-9fcc46b10100"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
MultilineStrings = "1e8d2bf6-9821-4900-9a2f-4d87552df2bd"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Clang_jll = "~18.1.7"
HTTP = "~1.10.19"
HypertextLiteral = "~0.9.5"
MultilineStrings = "~0.1.1"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.79"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.5"
manifest_format = "2.0"
project_hash = "28f2c3d0cbef0d958001cd187689fce4f2c599a4"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Clang_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "TOML", "Zlib_jll", "libLLVM_jll"]
git-tree-sha1 = "f85df021a5fd31ac59ea7126232b2875a848544f"
uuid = "0ee61d77-7f21-5576-8119-9fcc46b10100"
version = "18.1.7+4"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5e6fe50ae7f23d171f44e311c2960294aaa0beb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.19"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "0533e564aae234aff59ab625543145446d8b6ec2"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.1"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6893345fd6658c8e475d40155789f4860ac3b21"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.4+0"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "44f93c47f9cd6c7e431f2f2091fcba8f01cd7e8f"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.10"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.15.0+0"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f00544d95982ea270145636c181ceda21c4e2575"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.2.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "ff69a2b1330bcb730b9ac1ab7dd680176f5896b8"
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.1010+0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.11.4"

[[deps.MultilineStrings]]
git-tree-sha1 = "3214216b069fb1bc329f55094681e06b64a51022"
uuid = "1e8d2bf6-9821-4900-9a2f-4d87552df2bd"
version = "0.1.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "NetworkOptions", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "1d1aaa7d449b58415f97d2839c318b70ffb525a0"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.6.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.1"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "90b41ced6bacd8c01bd05da8aed35c5458891749"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.4.7"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "3ac7038a98ef6977d44adeadc73cc6f596c08109"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.79"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "07a921781cab75691315adc645096ed5e370cb77"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.3"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "522f093a29b31a93e34eaea17ba055d850edea28"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.libLLVM_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8f36deef-c2a5-5394-99ed-8e07531fb29a"
version = "18.1.7+5"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"
"""

# ╔═╡ Cell order:
# ╟─68b3f601-8cc3-45b2-93f6-8fdbc9cd3411
# ╟─3ddd22b2-7d1b-4b3a-8737-09552b51726d
# ╟─fc027d24-619e-4f6f-95ed-3dd12f61b60c
# ╟─a8783da7-4e44-4012-be6e-88705697b0c5
# ╟─cd3cce7d-b149-4ee1-8b6e-ff213a48ce7d
# ╟─5bd30ea4-3193-4fb4-9bf8-369fcfa6547b
# ╟─6d3d7f63-766b-4a1f-91c3-46b401c4c280
# ╟─acfa3f43-215e-4c97-bf2a-0069e78f95b4
# ╟─47279972-433b-46be-b511-170698ff8753
# ╟─1f190c17-4feb-41b2-a10a-60fb191d250e
# ╟─42e6ffd9-27b6-49bc-8518-2d7d4b7ffc40
# ╟─b588a04d-6a3f-424e-a83a-eec1dfafc9dd
# ╟─848723a1-4a62-47b2-957c-167ce9be19f8
# ╟─8f156e1d-5816-4c56-9aec-ad665d2bc782
# ╟─a39d8ac8-70e6-47a5-b80d-e1443c19ae15
# ╟─324b41a3-4b01-4589-8ca5-28ec148cdeb1
# ╟─3b5e218f-c134-40a9-9bc3-1fbab8d64d62
# ╟─654184b1-4b5e-4c90-800e-b413a04eeea1
# ╟─336f53c9-5982-4694-8bd4-92c2a1d1b5cc
# ╟─37f6e305-fb5c-4215-b8a1-564a7632a377
# ╟─0b41747b-fe00-49a0-9ed9-99f0b2046b2e
# ╟─a07e8aea-790b-4307-9de1-e45c6a3f7cf4
# ╟─c73a9ebe-9597-4c49-8493-aec1d71a281a
# ╟─b5388c3e-bcaf-43b6-b9d9-c9979f2afce2
# ╟─38e67b29-707f-4718-b9cc-2a1a62f32143
# ╟─67cf8ac0-5b91-4d19-aca4-4309f3109a0c
# ╟─9160427d-4db7-4a97-9dde-14d19d59b1ef
# ╟─6531f0d6-cf62-46ca-8dd2-befda43806d7
# ╟─c81abb3d-7192-499e-a47a-c0b960aa49cd
# ╟─92428490-6d76-44a7-9d5b-a9e988f5ff25
# ╟─1a82ab2b-dd7c-4b48-b263-e71b13ba0fb2
# ╟─62198fa2-4e96-4950-a99e-a3808bbf811a
# ╟─ec120913-bafb-4abb-8ebd-a0e3b72578f6
# ╟─90532252-a756-40a1-8867-76041f5545a0
# ╟─2d35189b-46aa-4922-ad4f-432533da2a80
# ╟─49f0db66-da21-42b0-91d5-db04075e559a
# ╟─7838b43b-428d-4045-8cfe-17c9a824ac65
# ╟─b66272c8-02b0-4d22-84d6-7274efe11e2a
# ╟─488d8bed-855f-470a-a2fa-68c13fd08739
# ╟─419f48c0-8377-4a67-a801-e87d2a61c17a
# ╟─cfc54158-a170-4f1d-b1dd-ab8e0f1a172e
# ╟─4dad1e1b-2288-49b9-8190-f2f374ca353c
# ╟─9cb862ff-275e-4f1d-8104-c1b8350725da
# ╟─f386a8d4-35be-4612-91c7-31ff0f004e2d
# ╟─87877209-958b-4635-bdbc-97548acdfb3f
# ╟─f3dd8bf7-03c4-4069-8d1c-ece484de5ef1
# ╟─6cc7a1d4-df02-494f-bf18-0652d49280e5
# ╟─facc8d63-d620-40ff-939a-78ff58fff04f
# ╟─b66c9e2f-17b3-44dc-83e4-cb3a9329039b
# ╟─c2928a50-8f63-477e-ada3-1352d5c72712
# ╟─a6ca2092-6435-4081-a407-c3d0286efb62
# ╟─0e0ddf7c-a34b-447a-8142-334d14f96ae1
# ╟─1ca8b74a-ce74-44a3-9e74-1447eb5141a7
# ╟─dd7f51b5-ca6a-4eb4-802d-9514861ae6a4
# ╟─e5e45ef0-32ac-403c-a05e-de267209fb8b
# ╟─b58ba8eb-0661-4eac-8ead-2daff4126d57
# ╟─dd918d12-bde4-4a1d-88c2-a9a643f39b2e
# ╟─2e1fc3ec-c1ca-43b8-893c-bda691635475
# ╟─85e1517c-f7d9-4df5-acde-00657cdf3dbe
# ╟─4b009812-191d-4969-bf32-5941ca707f37
# ╟─4072072d-c543-43bf-87ad-1f201bd21c59
# ╟─5b8e5130-bf78-4529-b3be-02a0ba093f12
# ╟─7f150e04-b56b-499f-ad50-4f586e76a0ab
# ╟─7808e8d0-597c-422a-95eb-cc581fb65d87
# ╟─44c8617f-ba56-40fe-80b4-963cf6e6f4b5
# ╟─c306afc9-f86e-4407-8757-272561980a72
# ╟─d85db8cc-56b6-42e5-8175-3c53d345282e
# ╟─594773b5-7e89-41a1-a873-387a096ee3b5
# ╟─03847d85-c675-4b4a-9331-fd7a32b26938
# ╟─406d30a9-f477-4898-9caf-770fcc25b2a9
# ╟─cb9c27b9-ce7d-4bdf-af7d-c88883a210bc
# ╟─e1b6f1d3-9d06-4ee4-854d-8ede288f369c
# ╟─986cdd2f-c22a-497b-8ce4-d6755a871c15
# ╟─6f257725-72c3-404c-bb35-079265058a43
# ╟─14a56b43-789a-42f0-9228-0c6a660629c9
# ╟─3cc18d67-b0d7-4b4b-afb6-5b48eddd89d2
# ╟─4e5e1340-c2e6-4b4a-bfb9-e1096d179040
# ╟─8283cc88-a3c8-4bb2-af31-0b72f2eb2c4a
# ╟─b8392f14-05d4-43e4-bd2a-3d4ba6ced65b
# ╟─27b6779a-5624-4e8e-ae32-8a8971923d01
# ╟─a13bf677-9c63-4f8e-b3dd-27b3aad7f956
# ╟─4643cd02-67f4-40cd-aa7d-cfdb83fc62be
# ╟─accfaade-96ce-4869-83ce-9dd5489b65a2
# ╟─319bc8b4-7139-43b0-a57b-66c6a9da7cb9
# ╟─132663c2-dfdd-4426-991a-bc9c95bbdad1
# ╟─20d23ab4-ae24-4169-92be-ed9ec77c5518
# ╟─e0bfde10-5b3d-48b2-aa03-a1e6b0fc97e3
# ╠═378c90d9-e206-4858-b362-4015ca46bbb0
# ╠═3b6a95e0-96e9-4634-9207-42ace759e738
# ╠═90a4fe3c-02c7-46e6-b2fb-526e73508101
# ╠═ecc856dc-e6f2-4a91-8c37-0bb920531297
# ╠═c132bea8-1ffe-4015-aaa7-66a67a806f48
# ╠═d107cd6f-c45c-4289-bd0f-5f329633fdda
# ╠═ad6a791b-14f0-4a20-ad5b-ec1690253bd9
# ╠═65ae6528-ef2c-48fd-94e9-56224e19863e
# ╠═8c115304-6a8e-4c2e-aeb2-9199c9d3b704
# ╠═2140d0e6-cd51-465b-bfc5-bdbfe077bc58
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
