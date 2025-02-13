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
tutor(wrap_in_main("""
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
* Une telle matrice sera stockée sur le **stack** (variable locale) ou dans la zone données (variable globale)
"""

# ╔═╡ b588a04d-6a3f-424e-a83a-eec1dfafc9dd
section("Matrices sur le heap")

# ╔═╡ 848723a1-4a62-47b2-957c-167ce9be19f8
frametitle("Comment mettre une matrice 2x2 sur le heap ?")

# ╔═╡ 26eea9a8-71ba-4d18-8170-731906e68d05
wrap_compile_and_run("""
float *matrice0 = (float *) malloc(4 * sizeof(float *));
matrice0[1][1] = 4;
""")

# ╔═╡ 8f156e1d-5816-4c56-9aec-ad665d2bc782
wrap_compile_and_run("""
float *matrice1=(float *) malloc(4 * sizeof(float));
matrice1[1][1] = 4;
""")

# ╔═╡ a39d8ac8-70e6-47a5-b80d-e1443c19ae15
frametitle("Première approche, un malloc par ligne")

# ╔═╡ 324b41a3-4b01-4589-8ca5-28ec148cdeb1
tutor(wrap_in_main("""
float **matrice2 = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice2[0] = ligne0;
matrice2[1] = ligne1;
matrice2[1][1] = 4;
"""))

# ╔═╡ 3b5e218f-c134-40a9-9bc3-1fbab8d64d62
frametitle("Deuxième approche, un malloc pour toutes les valeurs")

# ╔═╡ 654184b1-4b5e-4c90-800e-b413a04eeea1
tutor(wrap_in_main("""
float **matrice3 = (float **) malloc(2 * sizeof(float *));
float *valeurs = (float *) malloc(4 * sizeof(float));
matrice3[0] = valeurs;
matrice3[1] = valeurs + 2;
matrice3[1][1] = 4;
"""), width = 800)

# ╔═╡ 336f53c9-5982-4694-8bd4-92c2a1d1b5cc
section("Initialisation d'une valeur")

# ╔═╡ 37f6e305-fb5c-4215-b8a1-564a7632a377
frametitle("Comment initialiser la première valeur ?")

# ╔═╡ 0b41747b-fe00-49a0-9ed9-99f0b2046b2e
markdown_c("""
float **matrice = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice[0] = ligne0;
matrice[1] = ligne1;
matrice[0][0] = 1; // 1
*(matrice[0]) = 1; // 2
*(matrice) = 1;    // 3
""")

# ╔═╡ c73a9ebe-9597-4c49-8493-aec1d71a281a
frametitle("Comment faire matrice[0][1] = 2 ?")

# ╔═╡ b5388c3e-bcaf-43b6-b9d9-c9979f2afce2
markdown_c("""
float **matrice = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice[0] = ligne0;
matrice[1] = ligne1;
*(*matrice+1)=0;   // 1
*(matrice++)=0;    // 2
*(matrice[0]+1)=0; // 3
""")

# ╔═╡ 67cf8ac0-5b91-4d19-aca4-4309f3109a0c
frametitle("Comment faire matrice[1][0] = 2 ?")

# ╔═╡ 9160427d-4db7-4a97-9dde-14d19d59b1ef
markdown_c("""
float **matrice = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice[0] = ligne0;
matrice[1] = ligne1;
*(*(++matrice))=2; // 1
*(*(matrice+1))=2; // 2
*(*matrice+1)=2;   // 3
""")

# ╔═╡ 92428490-6d76-44a7-9d5b-a9e988f5ff25
frametitle("Libération de la mémoire")

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

# ╔═╡ 62198fa2-4e96-4950-a99e-a3808bbf811a
qa(md"Comment libérer la mémoire avec `free` ?",
markdown_c("""
free(ligne0);
free(ligne1);
free(matrice);
"""))

# ╔═╡ 90532252-a756-40a1-8867-76041f5545a0
frametitle("Toujours free dans le sens inverse de malloc")

# ╔═╡ 2d35189b-46aa-4922-ad4f-432533da2a80
tutor(wrap_in_main("""
float **matrice = (float **) malloc(2 * sizeof(float *));
matrice[0] = (float *) malloc(2 * sizeof(float));
matrice[1] = (float *) malloc(2 * sizeof(float));
free(matrice);
free(matrice[0]);
free(matrice[1]);
"""))

# ╔═╡ 49f0db66-da21-42b0-91d5-db04075e559a
section("Un vecteur \"Java\" en C")

# ╔═╡ b66272c8-02b0-4d22-84d6-7274efe11e2a
markdown_c("""
struct vector_t {
  int size;
  float *v;
};
""")

# ╔═╡ 488d8bed-855f-470a-a2fa-68c13fd08739
qa(md"""
```c
struct vector_t * init(int size, float val) {
```
""", markdown_c("""
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
"""))

# ╔═╡ d1a1a920-a23a-43e6-a254-6c2fe3affb10
qa(md"""
```c
a
```
""", md"a")

# ╔═╡ a094b96f-6a42-48be-b313-0453b1d24df1
frametitle("Fonction init")

# ╔═╡ 419f48c0-8377-4a67-a801-e87d2a61c17a


# ╔═╡ cfc54158-a170-4f1d-b1dd-ab8e0f1a172e


# ╔═╡ 4dad1e1b-2288-49b9-8190-f2f374ca353c


# ╔═╡ 14a56b43-789a-42f0-9228-0c6a660629c9
frametitle("Pointeur de fonction")

# ╔═╡ 791a21da-a883-45bc-a1fe-d12aef9c169b
frametitle("Projet sur Gitlab")

# ╔═╡ fd1f7fd9-f6ed-4ee0-a4eb-50254b7d07e7
TableOfContents()

# ╔═╡ b99d3c28-3433-420d-a343-db26a12022d5
reset_width(1500)

# ╔═╡ Cell order:
# ╟─68b3f601-8cc3-45b2-93f6-8fdbc9cd3411
# ╟─3ddd22b2-7d1b-4b3a-8737-09552b51726d
# ╟─a8783da7-4e44-4012-be6e-88705697b0c5
# ╟─cd3cce7d-b149-4ee1-8b6e-ff213a48ce7d
# ╟─5bd30ea4-3193-4fb4-9bf8-369fcfa6547b
# ╟─6d3d7f63-766b-4a1f-91c3-46b401c4c280
# ╟─acfa3f43-215e-4c97-bf2a-0069e78f95b4
# ╟─47279972-433b-46be-b511-170698ff8753
# ╟─b588a04d-6a3f-424e-a83a-eec1dfafc9dd
# ╟─848723a1-4a62-47b2-957c-167ce9be19f8
# ╟─26eea9a8-71ba-4d18-8170-731906e68d05
# ╟─8f156e1d-5816-4c56-9aec-ad665d2bc782
# ╟─a39d8ac8-70e6-47a5-b80d-e1443c19ae15
# ╟─324b41a3-4b01-4589-8ca5-28ec148cdeb1
# ╟─3b5e218f-c134-40a9-9bc3-1fbab8d64d62
# ╟─654184b1-4b5e-4c90-800e-b413a04eeea1
# ╟─336f53c9-5982-4694-8bd4-92c2a1d1b5cc
# ╟─37f6e305-fb5c-4215-b8a1-564a7632a377
# ╟─0b41747b-fe00-49a0-9ed9-99f0b2046b2e
# ╟─c73a9ebe-9597-4c49-8493-aec1d71a281a
# ╟─b5388c3e-bcaf-43b6-b9d9-c9979f2afce2
# ╟─67cf8ac0-5b91-4d19-aca4-4309f3109a0c
# ╟─9160427d-4db7-4a97-9dde-14d19d59b1ef
# ╟─92428490-6d76-44a7-9d5b-a9e988f5ff25
# ╟─1a82ab2b-dd7c-4b48-b263-e71b13ba0fb2
# ╟─62198fa2-4e96-4950-a99e-a3808bbf811a
# ╟─90532252-a756-40a1-8867-76041f5545a0
# ╟─2d35189b-46aa-4922-ad4f-432533da2a80
# ╟─49f0db66-da21-42b0-91d5-db04075e559a
# ╟─b66272c8-02b0-4d22-84d6-7274efe11e2a
# ╠═488d8bed-855f-470a-a2fa-68c13fd08739
# ╠═d1a1a920-a23a-43e6-a254-6c2fe3affb10
# ╟─a094b96f-6a42-48be-b313-0453b1d24df1
# ╠═419f48c0-8377-4a67-a801-e87d2a61c17a
# ╠═cfc54158-a170-4f1d-b1dd-ab8e0f1a172e
# ╠═4dad1e1b-2288-49b9-8190-f2f374ca353c
# ╟─14a56b43-789a-42f0-9228-0c6a660629c9
# ╟─791a21da-a883-45bc-a1fe-d12aef9c169b
# ╟─fd1f7fd9-f6ed-4ee0-a4eb-50254b7d07e7
# ╟─d2952bc0-5506-49c4-b7e5-95e319700cf2
# ╟─678cc353-0b54-4b92-9f08-71556177a038
# ╟─90a4fe3c-02c7-46e6-b2fb-526e73508101
# ╠═b99d3c28-3433-420d-a343-db26a12022d5
