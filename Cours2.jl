### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ d2952bc0-5506-49c4-b7e5-95e319700cf2
import Pkg

# ╔═╡ 678cc353-0b54-4b92-9f08-71556177a038
# ╠═╡ show_logs = false
Pkg.activate(".")

# ╔═╡ 90a4fe3c-02c7-46e6-b2fb-526e73508101
using PlutoUI, MyUtils

# ╔═╡ 68b3f601-8cc3-45b2-93f6-8fdbc9cd3411
header("LEPL1503 - Cours 2", "B. Legat, O. Bonaventure")

# ╔═╡ 3ddd22b2-7d1b-4b3a-8737-09552b51726d
frametitle("Variables, pointeurs et doubles pointeurs")

# ╔═╡ a8783da7-4e44-4012-be6e-88705697b0c5
tutor("""
#include <stdlib.h>

int main(int argc, char **argv) {
  int x;
  int *px;
  int **ppx;
  x=1;
  px=(int *) malloc(sizeof(int));
  *px=2;
  ppx=(int **) malloc(sizeof(int*));
  *ppx=(int *) malloc(sizeof(int));
  **ppx=3;
  return 0;
}
""")

# ╔═╡ cd3cce7d-b149-4ee1-8b6e-ff213a48ce7d
frametitle("Arguments de main")

# ╔═╡ 5bd30ea4-3193-4fb4-9bf8-369fcfa6547b
md"""
* `int argc` : Le nombre d'arguments (incluant le nom de l'exécutable)
* `char **argv` : liste des arguments initialisée par le système d’exploitation au lancement du programme
"""

# ╔═╡ 6d3d7f63-766b-4a1f-91c3-46b401c4c280
compile_and_run("""
#include <stdio.h>
int main(int argc, char **argv) {
  for(int i=0; i<argc; i++) {
    printf("arg[%d]: %s\\n", i, argv[i]);
  }
}
""", args = ["ab", "cd", "ef"])

# ╔═╡ acfa3f43-215e-4c97-bf2a-0069e78f95b4
frametitle("Matrices en C")

# ╔═╡ 47279972-433b-46be-b511-170698ff8753
md"""
* Comment construire une matrice ?
```c
float A[2][2]={ {1,0}, {2,3} };
```
* Une telle matrice sera stockée sur le stack (variable locale) ou dans la zone données (variable globale)
"""

# ╔═╡ 14a56b43-789a-42f0-9228-0c6a660629c9
frametitle("Pointeur de fonction")

# ╔═╡ 791a21da-a883-45bc-a1fe-d12aef9c169b
frametitle("Projet sur Gitlab")

# ╔═╡ fd1f7fd9-f6ed-4ee0-a4eb-50254b7d07e7
TableOfContents()

# ╔═╡ Cell order:
# ╟─68b3f601-8cc3-45b2-93f6-8fdbc9cd3411
# ╟─3ddd22b2-7d1b-4b3a-8737-09552b51726d
# ╟─a8783da7-4e44-4012-be6e-88705697b0c5
# ╟─cd3cce7d-b149-4ee1-8b6e-ff213a48ce7d
# ╟─5bd30ea4-3193-4fb4-9bf8-369fcfa6547b
# ╟─6d3d7f63-766b-4a1f-91c3-46b401c4c280
# ╟─acfa3f43-215e-4c97-bf2a-0069e78f95b4
# ╟─47279972-433b-46be-b511-170698ff8753
# ╟─14a56b43-789a-42f0-9228-0c6a660629c9
# ╟─791a21da-a883-45bc-a1fe-d12aef9c169b
# ╟─fd1f7fd9-f6ed-4ee0-a4eb-50254b7d07e7
# ╟─d2952bc0-5506-49c4-b7e5-95e319700cf2
# ╟─678cc353-0b54-4b92-9f08-71556177a038
# ╟─90a4fe3c-02c7-46e6-b2fb-526e73508101
