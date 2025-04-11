### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 47f92d66-0834-4f8d-9bdf-172c55e93cce
import Pkg

# ╔═╡ 35ad233c-a500-461a-af82-855d56792841
Pkg.activate(".")

# ╔═╡ 10e3b9fb-fe77-4106-a512-74f4d7d0cfbb
using Luxor, PlutoUI, PlutoUI.ExperimentalLayout, MyUtils, PlutoTeachingTools

# ╔═╡ 7a9a1afc-16a3-11f0-2474-67fc85a76676
header("LEPL1503/LSINC1503 - Cours 5", "O. Bonaventure, B. Legat, L. Metongnon")

# ╔═╡ 6764ba72-95ec-4f3b-ac10-4e7e1b2bcf3b
frametitle("Clarifications projet")

# ╔═╡ 810cdd19-7e3f-4cf4-a337-d9c1244e96ce
md"""
* Il est important de lire [la partie multithread du syllabus](https://lepl1503.info.ucl.ac.be/syllabus/theorie/index.html#systemes-multiprocesseurs) pour savoir faire la deuxième partie
* Amenez le Raspberry aux séances de TP pour que votre tuteur puissent vérifier que vous savez l'utiliser et que votre code fonctionne dessus. Les mesures devront être faites sur le Raspeberry pour être valable. On ne considère pas les mesures sur une autre plateforme.
* "obligatoire" ne veut pas dire que vous aurez tous les points si vous n'implémentez pas le reste!

> Cette partie est obligatoire ! Vous trouverez dans l’annexe A des schémas expliquant ces neuf opérations ;
"""

# ╔═╡ d87d73d9-d9d8-46e9-9599-0daa7fa95e9c
frametitle("Chacun doit contribuer sur le Git")

# ╔═╡ ee9648f2-bd69-4bf4-b95b-cc3fc2bf5b60
md"""
* Pour valider votre contribution au projet, il est nécessaire que vous ayez des merge requests en votre nom qui sont mergées avec des commits également en votre nom
* Ces merge requests doivent avoir été finies (donc passer les tests) puis mergées
* Elles doivent apporter une contribution significatives au code, par exemple pas juste modifier le README ou reformatter
* L'excuse du peer coding (vous programmez à deux sur un ordinateur) n'est pas valide
* Ne pas savoir exécuter le code chez soi n'est pas une excuse. Git est facile à installer sous n'importe quelle platforme et les tests s'exécute sur le runner GitLab.
"""

# ╔═╡ d1c8fa7e-8874-45e3-a398-e1fa2322af32
frametitle("Vérifiez qu'il n'y a pas de fuites de mémoires")

# ╔═╡ 52ddb3b6-0f88-4596-a480-d4d17489292c
md"""
Lors de la correction, nous vérifierons qu'il n'y a pas de fuites de mémoire avec [Valgrind $(img("https://valgrind.org/images/st-george-dragon.png", :height => "60"))](https://valgrind.org/)
"""

# ╔═╡ b0efbf09-53d7-40b2-af63-49f794336e9f
aside(
	Foldable(
		md"Pourquoi `valgrind` ne donne-t-il pas le numéro de ligne ?",
		md"On a pas compilé avec `-g` !
		On essaie avec `-g` ? $(@bind valgrind_debug CheckBox())",
	),
	v_offset = -300,
)

# ╔═╡ 4790109e-06b0-4518-a95f-ed9ca8b5f595
valgrind = Example("valgrind.c");

# ╔═╡ d16d02fb-ad22-4886-aecc-42fc3a9bc2d8
compile_and_run(valgrind, valgrind = true, verbose = true, cflags = valgrind_debug ? ["-g"] : String[])

# ╔═╡ dfb72971-ccf6-46ec-b686-37e071bd9598
frametitle("Interface par fichiers")

# ╔═╡ 5892921c-b019-418c-ba01-3d7a4e4697b3
md"""
On ne partage normalement pas de `.o` par `git` car ce n'est pas portable (e.g., ce `.o` ne marche pas sur Mac OS ni sur le Raspberry). Lorsque vous avez implémenté ces fonctions, supprimez ce fichier du git et ajoutez `objects/file.o` dans le `.gitignore`

> Comme vous n'aurez pas vu les fichiers au moment de commencer le projet, nous vous fournissons un fichier objet `file.o` dans le dossier objects. ... Cependant, vous devrez coder ces fonctions plus tard et ceci sera vérifié !

C'est une bonne chose d'écrire des unit tests mais comme les signatures des fonctions sont libres, nous utiliseront l'interface uniformisée par fichier pour testez votre code.

> Le Makefile génère un exécutable main. Vous pouvez l’utiliser de la façon suivante :
>
> `./main name_op input_file_A [-v] [-n n_threads] [-f output_stream] [-d degree] [input_file_B]`
"""

# ╔═╡ 9e9a0b57-30ce-4c9c-b0f5-a111f692d13f
frametitle("Debugging")

# ╔═╡ 9afe0855-162f-4234-8001-610e08e39bb0
md"""
* Ne pas oublier d'utiliser `-g` lors de la compilation
* `lldb` : développé par LLVM comme `clang` mais marche aussi avec des binaires compilés avec `gcc`, plus facile à installer sur Mac OS
* `gdb` : développé par GNU comme `gcc` mais marche auss avec des binaires compilés avec `clang`
* Utilisez `-fsanitize=address` à la compilation pour que les bornes soient vérifiées.
  - Le code est peut-être un peu moins rapide donc c'est à désactiver pour les mesures
  - mais il n'y a pas de bonne raison de ne pas l'utiliser dans la phase de développement!
"""

# ╔═╡ 3b928e29-a281-4dc2-9429-41e7d98dad54
frametitle("Exemple avec sanitize")

# ╔═╡ d50aa7f3-9c15-412e-82c2-f870aab8ffb0
out_of_bounds = Example("out_of_bounds.c");

# ╔═╡ ff911f08-d9a3-41f3-8e8d-c8e94fecacf0
compile_and_run(out_of_bounds, valgrind = false, verbose = true, cflags = ["-Wno-array-bounds", "-g"])

# ╔═╡ e3053cb5-186d-4c98-86c7-609be4a7c8dc
compile_and_run(out_of_bounds, valgrind = false, verbose = true, cflags = ["-Wno-array-bounds", "-fsanitize=address", "-g"])

# ╔═╡ 0221a56e-c279-4ca4-b211-dd61b95a23bd
frametitle("Matrices creuses")

# ╔═╡ ee19532c-e2fd-466f-9830-62ba94870a51
md"""
Deux format efficaces en taille mémoire, calcul et localité de la mémoire:
* Compressed Sparse Row (CSR)
* Compressed Sparse Column (CSC)
"""

# ╔═╡ eef6b843-6f92-4ce1-bf33-154bd814e915
hbox([
md"""
```math
\begin{pmatrix}
5 & 0 & 0 & 0 \\
0 & 8 & 0 & 0 \\
0 & 7 & 3 & 0 \\
0 & 6 & 0 & 0 \\
\end{pmatrix}
```
""",
Div(html" "; style = Dict("flex-grow" => "1")),
md"""
CSR (0-indexed)
```math
\begin{align}
 \texttt{nzval} &= \begin{bmatrix} 5 & 8 & 7 & 3 & 6 \end{bmatrix}\\
 \texttt{colval} &= \begin{bmatrix} 0 & 1 & 1 & 2 & 1 \end{bmatrix}\\
 \texttt{rowptr} &= \begin{bmatrix} 0 & 1 & 2 & 4 & 5 \end{bmatrix}
\end{align}
```
""",
Div(html" "; style = Dict("margin-left" => "50px")),
md"""
CSC (0-indexed)
```math
\begin{align}
 \texttt{nzval} &= \begin{bmatrix} 5 & 8 & 7 & 6 & 3 \end{bmatrix}\\
 \texttt{colptr} &= \begin{bmatrix} 0 & 1 & 4 & 5 & 5 \end{bmatrix}\\
 \texttt{rowval} &= \begin{bmatrix} 0 & 1 & 2 & 3 & 2 \end{bmatrix}
\end{align}
```
"""])

# ╔═╡ a843fc18-5290-414a-a5db-dacd4ac88f1d
Pkg.instantiate()

# ╔═╡ Cell order:
# ╟─7a9a1afc-16a3-11f0-2474-67fc85a76676
# ╟─6764ba72-95ec-4f3b-ac10-4e7e1b2bcf3b
# ╟─810cdd19-7e3f-4cf4-a337-d9c1244e96ce
# ╟─d87d73d9-d9d8-46e9-9599-0daa7fa95e9c
# ╟─ee9648f2-bd69-4bf4-b95b-cc3fc2bf5b60
# ╟─d1c8fa7e-8874-45e3-a398-e1fa2322af32
# ╟─52ddb3b6-0f88-4596-a480-d4d17489292c
# ╟─d16d02fb-ad22-4886-aecc-42fc3a9bc2d8
# ╟─b0efbf09-53d7-40b2-af63-49f794336e9f
# ╟─4790109e-06b0-4518-a95f-ed9ca8b5f595
# ╟─dfb72971-ccf6-46ec-b686-37e071bd9598
# ╟─5892921c-b019-418c-ba01-3d7a4e4697b3
# ╟─9e9a0b57-30ce-4c9c-b0f5-a111f692d13f
# ╟─9afe0855-162f-4234-8001-610e08e39bb0
# ╟─3b928e29-a281-4dc2-9429-41e7d98dad54
# ╟─ff911f08-d9a3-41f3-8e8d-c8e94fecacf0
# ╟─e3053cb5-186d-4c98-86c7-609be4a7c8dc
# ╟─d50aa7f3-9c15-412e-82c2-f870aab8ffb0
# ╟─0221a56e-c279-4ca4-b211-dd61b95a23bd
# ╟─ee19532c-e2fd-466f-9830-62ba94870a51
# ╟─eef6b843-6f92-4ce1-bf33-154bd814e915
# ╟─47f92d66-0834-4f8d-9bdf-172c55e93cce
# ╟─35ad233c-a500-461a-af82-855d56792841
# ╟─a843fc18-5290-414a-a5db-dacd4ac88f1d
# ╟─10e3b9fb-fe77-4106-a512-74f4d7d0cfbb
