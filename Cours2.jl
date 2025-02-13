### A Pluto.jl notebook ###
# v0.20.4

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

# ╔═╡ 791a21da-a883-45bc-a1fe-d12aef9c169b
frametitle("Projet sur Gitlab")

# ╔═╡ fd1f7fd9-f6ed-4ee0-a4eb-50254b7d07e7
TableOfContents()

# ╔═╡ Cell order:
# ╟─68b3f601-8cc3-45b2-93f6-8fdbc9cd3411
# ╟─3ddd22b2-7d1b-4b3a-8737-09552b51726d
# ╟─a8783da7-4e44-4012-be6e-88705697b0c5
# ╟─791a21da-a883-45bc-a1fe-d12aef9c169b
# ╟─fd1f7fd9-f6ed-4ee0-a4eb-50254b7d07e7
# ╟─d2952bc0-5506-49c4-b7e5-95e319700cf2
# ╟─678cc353-0b54-4b92-9f08-71556177a038
# ╟─90a4fe3c-02c7-46e6-b2fb-526e73508101
