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
using PlutoUI, PlutoUI.ExperimentalLayout, MyUtils, PlutoTeachingTools

# ╔═╡ 68b3f601-8cc3-45b2-93f6-8fdbc9cd3411
header("LEPL1503/LSINC1503 - Cours 2", "O. Bonaventure, B. Legat, L. Metongnon")

# ╔═╡ 3ddd22b2-7d1b-4b3a-8737-09552b51726d
section("Variables, pointeurs et doubles pointeurs")

# ╔═╡ fc027d24-619e-4f6f-95ed-3dd12f61b60c
frametitle("Visualisation")

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
md_c("""
float **matrice = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice[0] = ligne0;
matrice[1] = ligne1;
matrice[0][0] = 1; // 1
*(matrice[0]) = 1; // 2
*(matrice) = 1;    // 3
""")

# ╔═╡ a07e8aea-790b-4307-9de1-e45c6a3f7cf4
wooclap("JAPRXX")

# ╔═╡ c73a9ebe-9597-4c49-8493-aec1d71a281a
frametitle("Comment faire matrice[0][1] = 0 ?")

# ╔═╡ b5388c3e-bcaf-43b6-b9d9-c9979f2afce2
md_c("""
float **matrice = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice[0] = ligne0;
matrice[1] = ligne1;
*(*matrice+1)=0;   // 1
*(matrice++)=0;    // 2
*(matrice[0]+1)=0; // 3
""")

# ╔═╡ 38e67b29-707f-4718-b9cc-2a1a62f32143
wooclap("JAPRXX")

# ╔═╡ 67cf8ac0-5b91-4d19-aca4-4309f3109a0c
frametitle("Comment faire matrice[1][0] = 2 ?")

# ╔═╡ 9160427d-4db7-4a97-9dde-14d19d59b1ef
md_c("""
float **matrice = (float **) malloc(2 * sizeof(float *));
float *ligne0 = (float *) malloc(2 * sizeof(float));
float *ligne1 = (float *) malloc(2 * sizeof(float));
matrice[0] = ligne0;
matrice[1] = ligne1;
*(*(++matrice))=2; // 1
*(*(matrice+1))=2; // 2
*(*matrice+1)=2;   // 3
""")

# ╔═╡ 6531f0d6-cf62-46ca-8dd2-befda43806d7
wooclap("JAPRXX")

# ╔═╡ c81abb3d-7192-499e-a47a-c0b960aa49cd
section("Libération de la mémoire")

# ╔═╡ 92428490-6d76-44a7-9d5b-a9e988f5ff25
frametitle("L'importance de l'ordre de désallocation")

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
md_c("""
free(ligne0);
free(ligne1);
free(matrice);
"""))

# ╔═╡ ec120913-bafb-4abb-8ebd-a0e3b72578f6
wooclap("JAPRXX")

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

# ╔═╡ 7838b43b-428d-4045-8cfe-17c9a824ac65
frametitle("Première implémentation")

# ╔═╡ b66272c8-02b0-4d22-84d6-7274efe11e2a
md_c("""
struct vector_t {
  int size;
  float *v;
};
""")

# ╔═╡ 488d8bed-855f-470a-a2fa-68c13fd08739
qa(md_c("struct vector_t * init(int size, float val) {"), md_c("""
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

# ╔═╡ 419f48c0-8377-4a67-a801-e87d2a61c17a
qa(md_c("float get(struct vector_t *t, int i) {"), md_c("""
  return *(t->v+i);
}"""))

# ╔═╡ cfc54158-a170-4f1d-b1dd-ab8e0f1a172e
qa(md_c("void set(struct vector_t *t, int i, float val) {"), md_c("""
  if((i<t->size)&&(i>0))
    *(t->v+i)=val;
}"""))

# ╔═╡ 4dad1e1b-2288-49b9-8190-f2f374ca353c
qa(md_c("void destroy(struct vector_t *vect) {"), md_c("""
  free(vect->v);
  free(vect);
}"""))

# ╔═╡ 9cb862ff-275e-4f1d-8104-c1b8350725da
wooclap("JAPRXX")

# ╔═╡ f386a8d4-35be-4612-91c7-31ff0f004e2d
frametitle("Une autre implémentation …")

# ╔═╡ 87877209-958b-4635-bdbc-97548acdfb3f
md"""
Toutes les fonctions doivent vérifier leurs arguments et retourner
* -1 en cas d'erreur
* 0 en cas de succès
"""

# ╔═╡ f3dd8bf7-03c4-4069-8d1c-ece484de5ef1
md_c("""struct vector_t {
  int length; // nombre d'élements
  float *tab; // tableau avec les réels
};""")

# ╔═╡ 6cc7a1d4-df02-494f-bf18-0652d49280e5
frametitle("Initialisation")

# ╔═╡ facc8d63-d620-40ff-939a-78ff58fff04f
md_c("""struct vector_t {
  int length; // nombre d'élements
  float *tab; // tableau avec les réels
};""")

# ╔═╡ b66c9e2f-17b3-44dc-83e4-cb3a9329039b
md"Quels arguments ?"

# ╔═╡ c2928a50-8f63-477e-ada3-1352d5c72712
md_c("""
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
""")

# ╔═╡ a6ca2092-6435-4081-a407-c3d0286efb62
wooclap("JAPRXX")

# ╔═╡ 0e0ddf7c-a34b-447a-8142-334d14f96ae1
frametitle("Allocation de la mémoire")

# ╔═╡ 1ca8b74a-ce74-44a3-9e74-1447eb5141a7
md_c("""struct vector_t {
  int length; // nombre d'élements
  float *tab; // tableau avec les réels
};""")

# ╔═╡ dd7f51b5-ca6a-4eb4-802d-9514861ae6a4
md_c("""
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
""")

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

# ╔═╡ b58ba8eb-0661-4eac-8ead-2daff4126d57
md_c("""
  }
  return 0;
}
""")

# ╔═╡ dd918d12-bde4-4a1d-88c2-a9a643f39b2e
wooclap("JAPRXX")

# ╔═╡ 2e1fc3ec-c1ca-43b8-893c-bda691635475
frametitle("Visualization de init")

# ╔═╡ 85e1517c-f7d9-4df5-acde-00657cdf3dbe
tutor("""
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

# ╔═╡ 4b009812-191d-4969-bf32-5941ca707f37
frametitle("Récupération d'un élément")

# ╔═╡ 4072072d-c543-43bf-87ad-1f201bd21c59
md_c("""struct vector_t {
  int length; // nombre d'élements
  float *tab; // tableau avec les réels
};""")

# ╔═╡ 5b8e5130-bf78-4529-b3be-02a0ba093f12
md_c("""
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
""")

# ╔═╡ 7f150e04-b56b-499f-ad50-4f586e76a0ab
qa(md"Comment implémenter `get` ?", md_c("""
  if (i < 0 || i >= v->length)
    return -1;
  *val = *(v->tab+i);
  return 0;
}
"""))

# ╔═╡ 7808e8d0-597c-422a-95eb-cc581fb65d87
wooclap("JAPRXX")

# ╔═╡ 44c8617f-ba56-40fe-80b4-963cf6e6f4b5
frametitle("Modification d'un élément")

# ╔═╡ c306afc9-f86e-4407-8757-272561980a72
md_c("""/*
 * @pre
 * @post place val comme ième élément
 *             du tableau
 *       -1 en cas d'erreur, 0 sinon
 */

int set(struct vector_t *v, int i,
struct vector_t  v     // 1
struct vector_t ** v   // 2
struct vector_t * v    // 3
) {""")

# ╔═╡ d85db8cc-56b6-42e5-8175-3c53d345282e
qa(md"Comment implémenter `set` ?", md_c("""
  if (i < 0 || i >= v->length)
    return -1;
  *(v->tab+i) = val;
  return 0;
}
"""))

# ╔═╡ 594773b5-7e89-41a1-a873-387a096ee3b5
wooclap("JAPRXX")

# ╔═╡ 03847d85-c675-4b4a-9331-fd7a32b26938
frametitle("Libération de la mémoire")

# ╔═╡ 406d30a9-f477-4898-9caf-770fcc25b2a9
md"Comment libérer la mémoire quand le vecteur est devenu inutile ?"

# ╔═╡ cb9c27b9-ce7d-4bdf-af7d-c88883a210bc
md_c("""
/*
 * libère la mémoire utilisée pour le vecteur
 * -1 en cas d'erreur, 0 sinon
 */
""")

# ╔═╡ e1b6f1d3-9d06-4ee4-854d-8ede288f369c
qa(md_c("int destroy(struct vector_t *v) {"), md_c("""
  free(v->tab);
  free(v);
  return 0;
}"""))

# ╔═╡ 986cdd2f-c22a-497b-8ce4-d6755a871c15
wooclap("JAPRXX")

# ╔═╡ 6f257725-72c3-404c-bb35-079265058a43
section("Pointeur de fonction")

# ╔═╡ 14a56b43-789a-42f0-9228-0c6a660629c9
md"`mapreduce` donne un exemple de fonction d'ordre supérieur en C"

# ╔═╡ 3cc18d67-b0d7-4b4b-afb6-5b48eddd89d2
tutor("""
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

# ╔═╡ 4e5e1340-c2e6-4b4a-bfb9-e1096d179040
section("Retourner un tableau")

# ╔═╡ 8283cc88-a3c8-4bb2-af31-0b72f2eb2c4a
frametitle("Heap ou stack ?")

# ╔═╡ b8392f14-05d4-43e4-bd2a-3d4ba6ced65b
md"Laquelle de ces deux fonctions présente une façon correcte de retourner un tableau ?"

# ╔═╡ 27b6779a-5624-4e8e-ae32-8a8971923d01
md_c("""
int *stack() {
  int v[] = {1, 2, 3};
  return v;
}

int *heap() {
  int *v = (int *) malloc(3 * sizeof(int));
  v[0] = 1; v[1] = 2; v[2] = 3;
  return v;
}""")

# ╔═╡ a13bf677-9c63-4f8e-b3dd-27b3aad7f956
wooclap("JAPRXX")

# ╔═╡ 4643cd02-67f4-40cd-aa7d-cfdb83fc62be
frametitle("Retourner un tableau : visualization")

# ╔═╡ accfaade-96ce-4869-83ce-9dd5489b65a2
tutor("""
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

# ╔═╡ 319bc8b4-7139-43b0-a57b-66c6a9da7cb9
section("Structure différente du stack et heap")

# ╔═╡ 132663c2-dfdd-4426-991a-bc9c95bbdad1
hbox([
	md"""
* Stack : Pile de mémoire locale des functions, structure connue à la **compilation**
* Heap : Alloué et désalloué avec des tailles connues à l'**exécution**. L'OS fait de son mieux pour organiser cette mémoire et réassigner les fragments formés suite aux désallocations


""",
	img("heapstack", :width => "350px"),
])

# ╔═╡ 20d23ab4-ae24-4169-92be-ed9ec77c5518
aside(md"[Source](https://learn.adafruit.com/memories-of-an-arduino/measuring-free-memory)", v_offset = -200)

# ╔═╡ 72370890-1eed-4567-afa6-b492d7d3c898
section("Projet")

# ╔═╡ 70172d7b-db88-40dd-9e1b-dcd1e00f2d62
md"""
* Si vous avez une question sur le projet, ouvrez une issue [ici](https://forge.uclouvain.be/lepl15031/students/project-matrix/projet-matrix)
"""

# ╔═╡ 661121be-c888-4b91-acd6-ba1f7c665ae8
Pkg.instantiate()

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
# ╠═132663c2-dfdd-4426-991a-bc9c95bbdad1
# ╠═20d23ab4-ae24-4169-92be-ed9ec77c5518
# ╟─72370890-1eed-4567-afa6-b492d7d3c898
# ╟─70172d7b-db88-40dd-9e1b-dcd1e00f2d62
# ╟─d2952bc0-5506-49c4-b7e5-95e319700cf2
# ╟─678cc353-0b54-4b92-9f08-71556177a038
# ╟─661121be-c888-4b91-acd6-ba1f7c665ae8
# ╟─90a4fe3c-02c7-46e6-b2fb-526e73508101
