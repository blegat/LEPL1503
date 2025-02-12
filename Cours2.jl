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
header("LEPL1503 - Cours 1", "B. Legat, O. Bonaventure")

# ╔═╡ 885e5b5c-fc1d-49af-9851-54b028cb3c9a
section("Pointeurs")

# ╔═╡ 3ddd22b2-7d1b-4b3a-8737-09552b51726d
frametitle("Comment échanger deux variables ?")

# ╔═╡ a8783da7-4e44-4012-be6e-88705697b0c5
tutor("""
#include <stdio.h>

void swap (int a, int b){
  int c = a;
  a = b;
  b = c;
}

int main() {
  int x = 1;
  int y = 2;
  swap(x, y);
  printf("%d %d\\n", x, y);
}
""")

# ╔═╡ f17f808f-705c-469a-a6c8-cbdb57f5b8ea
frametitle("Pointeurs en C")

# ╔═╡ 8b35ab88-45d3-48e4-a4d4-1622a999ddd0
tutor("""
int main() {
  int x=123;
  int *ptr;
  ptr=&x;
}
""")

# ╔═╡ 82dbb69f-6b3e-4f05-90df-a9d364ca8684
frametitle("Echange du contenu de variables")

# ╔═╡ 006c5d72-29b4-41fe-9d1d-aff8c89d3b83
tutor("""
#include <stdio.h>

void swap (int *a, int *b){
  int c = *a;
  *a = *b;
  *b = c;
}

int main() {
  int x = 1;
  int y = 2;
  swap(&x, &y);
  printf("%d %d\\n", x, y);
}
""")

# ╔═╡ 2c6dccc9-2a8f-4830-b626-c4243890e61c
frametitle("Arithmétique des pointeurs")

# ╔═╡ 5a03027c-37ef-45f5-b89c-36d2d8bbf2dd
tutor("""
int main() {
  int x[] = {10, 20, 30, 40, 50, 60, 70, 80};
  int y[] = {2, 4, 6, 8};
  int *x_ptr = x;
  int *y_ptr = &(y[0]);
}
""")

# ╔═╡ fd1f7fd9-f6ed-4ee0-a4eb-50254b7d07e7
TableOfContents()

# ╔═╡ Cell order:
# ╟─68b3f601-8cc3-45b2-93f6-8fdbc9cd3411
# ╟─885e5b5c-fc1d-49af-9851-54b028cb3c9a
# ╟─3ddd22b2-7d1b-4b3a-8737-09552b51726d
# ╟─a8783da7-4e44-4012-be6e-88705697b0c5
# ╟─f17f808f-705c-469a-a6c8-cbdb57f5b8ea
# ╟─8b35ab88-45d3-48e4-a4d4-1622a999ddd0
# ╟─82dbb69f-6b3e-4f05-90df-a9d364ca8684
# ╟─006c5d72-29b4-41fe-9d1d-aff8c89d3b83
# ╟─2c6dccc9-2a8f-4830-b626-c4243890e61c
# ╟─5a03027c-37ef-45f5-b89c-36d2d8bbf2dd
# ╟─fd1f7fd9-f6ed-4ee0-a4eb-50254b7d07e7
# ╟─d2952bc0-5506-49c4-b7e5-95e319700cf2
# ╟─678cc353-0b54-4b92-9f08-71556177a038
# ╟─90a4fe3c-02c7-46e6-b2fb-526e73508101
