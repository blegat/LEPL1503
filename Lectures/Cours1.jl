### A Pluto.jl notebook ###
# v0.20.22

using Markdown
using InteractiveUtils

# ╔═╡ 0973097a-02c4-11f1-ac60-339637a3ae4b
using PlutoUI, PlutoUI.ExperimentalLayout, HypertextLiteral, PlutoTeachingTools, SimpleClang

# ╔═╡ a4adbbef-a392-40da-9443-0ec5c7b07914
@htl("""
<p align=center style=\"font-size: 40px;\">LEPL1503/LSINC1503 - Cours 1</p><p align=right><i>O. Bonaventure, B. Legat, M. Baerts</i></p>
$(PlutoTeachingTools.ChooseDisplayMode())
$(PlutoUI.TableOfContents(depth=1))
""")

# ╔═╡ c9babcf0-963d-46e3-b8d9-9593e0ea66c0
md"# Pointeurs "

# ╔═╡ f0f26473-f64a-4111-b40e-79e3b60f2b9d
swap_c = c"""
#include <stdio.h>

void swap(int a, int b)
{
    int c = a;
    a = b;
    b = c;
}

int main()
{
    int x = 1;
    int y = 2;
    swap(x, y);
    printf("%d %d\n", x, y);
}
""";

# ╔═╡ 7c7f942d-c235-4ec9-b21b-dcb6c90554a8
md"""
## Comment échanger deux variables entières ?
$swap_c
"""

# ╔═╡ d3d74430-c125-40a8-9d38-9ad5c01b62cd
md"""
## Pointeurs en C
```julia
int x = 123;
int *ptr;
ptr = &x;
```
"""

# ╔═╡ b59bf796-fc44-4ce8-9fdc-60f36bcb021f
md"## Echange du contenu de variables"

# ╔═╡ 19f03198-5180-432c-bbce-4107c1593ff1
md"## Considérons le code ci-dessous"

# ╔═╡ 7ba78557-0744-45a9-bcd7-d7f24d91fe89
md"""
* `x_ptr` est l'adresse du premier élément du tableau `x`
* `y_ptr` est l'adresse du premier élément du tableau `y`
"""

# ╔═╡ ba1c0405-b097-43ae-bf46-57c507453bee
xy_ptr = c"""
#include <stdio.h>

int main()
{
    int x[] = {10, 20, 30, 40, 50, 60, 70, 80};
    int y[] = {2, 4, 6, 8};
    int *x_ptr = x;
    int *y_ptr = &(y[0]);
}
""";

# ╔═╡ c457f42e-7d5d-4e98-93e0-5ef06271350d
xy_ptr

# ╔═╡ adbe76b7-b1a0-4f87-84c3-29d78e85aa54
md"## Arithmétique des pointeurs"

# ╔═╡ a0b28bb3-42b2-4dbc-957d-207599096308
md"""
* Il est possible de réaliser des calculs sur les pointeurs
* Si `ptr` pointe vers une zone de type donné en mémoire, alors `ptr+1` pointe vers la zone suivante de **ce type** en mémoire.

Pourquoi pas juste le byte suivant ? Par exemple, expliquez l'output suivant:
"""

# ╔═╡ b6b11213-78a8-472c-ae3b-b9962326c613
compile_and_run(c"""
#include <stdio.h>
int main()
{
    int x[] = {2026, 6, 2};
    char *y = (char *)x;
    printf("%lu %d %d\n", sizeof(int), x[0], x[1]);
    printf("%lu %d %d\n", sizeof(char), y[0], y[1]);
}
""")

# ╔═╡ 068aca17-76d9-4d4a-9c13-c4c7086280fc
md"## Arithmetique des pointeurs"

# ╔═╡ dfac707f-f492-44e1-9cb0-600ec29af681
md"L'entier 2026 est représenté sur 32 bits: 4 bytes de 8 bits chacun"

# ╔═╡ 9a313e99-ff30-435b-a716-0ae1ea3203e0
bitstring(Cint(2026))

# ╔═╡ 1f574a88-0516-4e19-a146-beda76e2cc5e
md"Un `char` ne représente qu'en seul byte, donc `y[0]` voit les bytes suivant:"

# ╔═╡ 72243e55-0806-4380-a054-d463dcd30832
bitstring(Cint(2026))[end-7:end]

# ╔═╡ 1c3b5990-6802-4773-bd72-53f3a0eff470
md"Comme on utilise `%d`, c'est interprété comme un entier signé, les 7 premiers bits représentent 106"

# ╔═╡ 76e2d7c4-e54c-402d-b444-4eece84104b5
Cint(0b1101010)

# ╔═╡ 1394d233-a1d1-4575-9b2d-bd6a2d59de4c
md"Le bit de signe signifie qu'il faut soustraire 128, on arrive à `-22`"

# ╔═╡ 5a3397a8-bdd5-4e09-a2e3-dc93cb82a9d2
Cint(0b1101010) - 128

# ╔═╡ 92da2bc6-df2d-4e3f-b25d-78d60e656c14
md"Le byte suivant représente 7"

# ╔═╡ a79d619c-a091-4242-b292-0844fbf493d0
bitstring(Cint(2026))[end-15:end-8]

# ╔═╡ 3da8667c-0d2b-4ffe-bfbd-df350837fdda
0b111

# ╔═╡ d47ad331-b1a4-49e9-a2ff-9243d5df1cbd
md"## Exécution du code"

# ╔═╡ f02e4c73-7369-4f00-a350-341424bb1b0e
md"## Questions"

# ╔═╡ 695d0382-f30a-4b0f-9110-21cb640941bf
xy_ptr

# ╔═╡ 85d7d6e9-5d64-4756-95f4-d9e653fd8f4c
md"## Pointeurs vers des entiers"

# ╔═╡ ccb1cfec-aaca-43ca-87c2-c860188f9cdf
c"""
int tab[] = {2, 4, 8, 16};
printf("%d \n", *(tab + 1));
"""

# ╔═╡ bc821e86-8e8b-46db-8738-dac57d2711f2
md"## Pointeurs vers des entiers"

# ╔═╡ e23fb881-bcf0-46db-8806-c9591a02c391
c"""
int tab[] = {2, 4, 8, 16};
printf("%d \n", *(tab) + 2);
"""

# ╔═╡ 4e590ad1-d5ca-48e9-bbce-a2027905f74a
md"## Pointeurs vers des entiers"

# ╔═╡ 6e9e33e2-1610-4cb1-be29-72750d639992
c"""
int tab[] = {2, 4, 8, 16};
printf("%d \n", *tab + 3);
"""

# ╔═╡ f8866701-312c-4dd1-9edc-5acbb60c2e07
md"## Prototypes de fonctions"

# ╔═╡ c0a45b63-9272-4cdf-a652-299ee9c7dfff
md"""
Lequel de ces prototypes est possible pour une fonction qui retourne le maximum d'un vecteur de réels ?
"""

# ╔═╡ 75d35f92-191a-4e12-a3ba-b5e68ebca644
c"""
double max1(double v);
double max2(double *v);
double max3(double *v, int n);
double *max4(double *v, int n);
"""

# ╔═╡ 188d706c-1e55-4b22-9bf5-13c00585e7d2
md"## Qu’affiche ce code ?"

# ╔═╡ e90a55d8-e909-4404-937b-a6a2c6818a66
somme = c"""
#include <stdio.h>

int main()
{
    int sum = 0;
    int x[] = {10, 20, 30};
    int *ptr = x;
    for (int i = 0; i < 4; i++)
    {
        sum += *(ptr);
        ptr++;
    }
    printf("Somme: %d\n", sum);
    return 0;
}
""";

# ╔═╡ f2c55534-28a4-4774-b1c2-50e3c922dd12
somme

# ╔═╡ 7318d4e6-a8ad-4f1d-8f1d-35b091ea0409
md"## Somme d'entiers"

# ╔═╡ b4e552a2-49a2-4cb4-bab5-f854efa55dbf
md"# Chaînes de caractères en C"

# ╔═╡ 4d42068f-fb23-4402-a80f-a720e11153ff
md"## Chaînes de caractères en java​"

# ╔═╡ 06291f81-a945-4538-a632-a95a4b032d41
md"## Chaines de caractère en C"

# ╔═╡ 55cf950e-8408-477c-9b11-bb8bf2b79332
md"## printf"

# ╔═╡ d4e85b27-3ef5-45ed-a144-33994780d83f
run(`man 3 printf`)

# ╔═╡ eac15e33-2d8e-4dff-93f5-6e06d1f86620
md"## Comment calculer la longueur d’une chaîne de caractères en C ?"

# ╔═╡ 1cf54714-a2a6-45ca-9bf8-b6ef53ab5765
run(`man 3 strlen`)

# ╔═╡ cfd9ff83-db13-42d4-9676-4ea8ee6021cd
md"## Comment écrire cette fonction en C ?"

# ╔═╡ 62ca9b5e-260c-4823-9a47-a9afa7d1becc
md"## Même exemple avec des pointeurs"

# ╔═╡ 0177da0f-4992-4b4f-a199-026fab7cc9b4
md"## Qu'affiche"

# ╔═╡ bd9511dd-d51a-4382-8c69-274c571784c0
md"## Pointeurs et chaînes de caractères"

# ╔═╡ fea327e5-62c8-4772-8cc0-00c7f225e1c4
md"Qu'affiche ?"

# ╔═╡ 5fd01b09-3301-4b6f-b8f9-89e3a1075a8c
c"""
char *string = "abcdef";
printf("%s\n", string + 2);
"""

# ╔═╡ b156e291-cd1b-48cf-91a2-0c44634bafe9
md"## Pointeurs et chaînes de caractères"

# ╔═╡ 1139437c-739e-4599-aa56-6654925bcb02
md"Qu'affiche ?"

# ╔═╡ 0d6ed070-3364-404b-a585-e5775bdf6fa4
c"""
char *string = "abcdef";
printf("%c\n", *(string + 3));
"""

# ╔═╡ 0703ee4a-eada-4243-a9e1-bf054cbf4bc5
danger(md"Le `\0` a été supprimé, printf affichera cette chaîne uniquement si il y a un `\0` en mémoire à l’adresse qui suit celle de `G`")

# ╔═╡ b40eb78b-591a-4230-ab4d-55e04d6d6d8c
danger(md"Vous avez écrit en mémoire à une adresse en dehors de la chaine
de caractère et avez potentiellement modifié la valeur d’une autre variable ou pire…")

# ╔═╡ 8768cc26-9bcc-41d9-b49d-2462870d58f3
md"## Pointeurs et chaînes de caractères"

# ╔═╡ 9303edd4-71df-499a-b64f-eebef96819a6
md"Lesquelles de ces déclarations sont valides ?"

# ╔═╡ ddbe345b-d667-47df-8232-839ebe393d53
c"""
char *string1 = "abcdef";
char string2[] = "abcdef";
char string3 = "ab";
char *string4 = 'A';
char string5 = 'B';
char *string6 = "C";
"""

# ╔═╡ 839fd0b2-57b2-4986-9fc7-5ae5f80f45cd
md"# Organisation des processus en mémoire"

# ╔═╡ 089700ff-5dd6-4677-b346-d2ab2c0e3cc4
md"## Mémoire"

# ╔═╡ 883b6212-354a-4c7c-805a-c6919b63f6a4
md"## Segment text"

# ╔═╡ 2e421906-8749-4a02-95b5-49afb07532c5
md"""```
objdump -S a.out 

a.out:     file format elf32-i386

Disassembly of section .init:

08048290 <_init>:
 8048290:	55                   	push   %ebp
 8048291:	89 e5                	mov    %esp,%ebp
 8048293:	53                   	push   %ebx
 8048294:	83 ec 04             	sub    $0x4,%esp
 8048297:	e8 00 00 00 00       	call   804829c <_init+0xc>
 804829c:	5b                   	pop    %ebx
 804829d:	81 c3 88 13 00 00    	add    $0x1388,%ebx
 80482a3:	8b 93 fc ff ff ff    	mov    -0x4(%ebx),%edx
 80482a9:	85 d2                	test   %edx,%edx
 80482ab:	74 05                	je     80482b2 <_init+0x22>

Text
```"""

# ╔═╡ 2a149ea2-8d0f-411b-b0cf-e6ecfce51183
md"## malloc(3)"

# ╔═╡ 183e26c0-77ac-4d9e-9be9-4d5cc3bfb8c4
run(`man 3 malloc`)

# ╔═╡ 1e738ec1-9c1a-474f-a49c-42409da9f473
md"## Points d'attention"

# ╔═╡ 51030efe-c399-4d98-9cf4-551fc177c1be
md"""
La fonction `malloc` peut échouer à allouer de la mémoire

* Vous devez **toujours** tester la valeur de retour de `malloc`
* Si malloc a retourné `NULL`, votre code doit réagir correctement
"""

# ╔═╡ 69dc6465-f42c-4f66-8ec8-d3fd3c942f80
md"""
## Points d'attention

La fonction `malloc` *réserve* de la mémoire **mais ne l'initialise pas**

* En bon programmeur, vous devez évidemment initialiser la mémoire **avant** de l'utiliser
* `calloc` initialise la mémoire pour vous à zéro
"""

# ╔═╡ 07ed2c6b-c475-4a7d-8d57-6abdf112e77d
md"""
## Points d'attention

* Le pointeur retourné par `malloc` a 2 rôles
  - Il vous permet d'accéder à la zone mémoire que vous avez alloué
    * Vous devrez le manipuler dans le code
  -  C'est l'identifiant utilisé par `malloc`/`free` qui sera nécessaire pour libérer la mémoire ultérieurement
    * Gardez une copie de cette adresse dans votre code
"""

# ╔═╡ 562ca6c1-634a-428b-aa18-fe77fb8878c4
md"""
## Points d'attention

* Toute zone mémoire allouée par `malloc` doit être libérée explicitement par `free` avant la fin de l'exécution du programme

  - Il n'y a pas de garbage collector en C
  - Si vous oubliez de libérer de la mémoire que vous avez alloué, vous causez un memory leak
"""

# ╔═╡ a47e967c-078a-44ab-bfcb-c069e155ce25
md"""
## Pile
"""

# ╔═╡ 1294b025-2ffb-499f-b72c-7d4aee21b53c
md"""
## Informations sur la pile/stack

* paramètres passés aux fonctions
  - optimisation : certains paramètres sont passés dans des registres du CPU
* variables locales aux fonctions
* adresse de retour des fonctions
"""

# ╔═╡ ba1a0a5c-9a68-4c26-bfd3-cc25608c7cc7
md"""
## Exemples
"""

# ╔═╡ 3aa0b2f0-a3d1-4201-a68d-57ba7b08842e
md"## Y-a-t-il une différence de performance entre ces 2 fonctions ?"

# ╔═╡ d901922a-ba35-47fa-9e3a-051926f24afb
c"""
#define MILLION 1000000

struct large_t
{
    int i;
    char str[MILLION];
};

int sum(struct large_t s1, struct large_t s2)
{
    return (s1.i + s2.i);
}

int sumptr(struct large_t *s1, struct large_t *s2)
{
    return (s1->i + s2->i);
}
"""

# ╔═╡ 5da040e9-84c2-4f4b-9f84-a8fe46ba7126
md"## Localisation en mémoire"

# ╔═╡ c7119f95-2485-49ac-bd33-0c4bc907df7c
md"Dans le code ci-dessous, dans quelle zone de la mémoire se trouve le contenu du tableau `tab[]`"

# ╔═╡ dfef622a-c02a-428e-94e5-035019fd3457
md"## Localisation en mémoire"

# ╔═╡ 667efd31-4b95-4546-be32-76b383e256e1
md"Dans le code ci-dessous, dans quelle zone de la mémoire se trouve **le pointeur** `tab[]`"

# ╔═╡ f0ef730f-1a20-481a-8301-490b3664ed94
md"## Localisation en mémoire"

# ╔═╡ 3fe81691-b8f3-47a2-9a11-78233b34874c
md"Dans le code ci-dessous, dans quelle zone de la mémoire se trouve le contenu du tableau `tab`"

# ╔═╡ c5ecef00-e1e6-4201-8108-3fa287af548c
md"## Accès après free"

# ╔═╡ cebdcb4d-6894-4b04-91b8-c9f83d1c9fc8
c"""int *tab2 = (int *)malloc(4 * sizeof(int));
*tab2 = 2;
*(tab2 + 1) = 4;
free(tab2);
printf("%d\n", *(tab2 + 1));"""

# ╔═╡ 369c4985-cdb5-4a30-a6e0-2ac02217489a
md"## Free depuis un pointeur dans le tableau"

# ╔═╡ 627ad27a-d332-4f12-b1c9-70926864232d

c"""
int *tab2 = (int *)malloc(4 * sizeof(int));
*tab2 = 2;
tab2++;
*tab2 = 4;
free(tab2);
printf("%d\n", *(tab2));"""

# ╔═╡ ec2e4242-de1e-4fde-866c-fa7847c28c1b
html"<p align=center style=\"font-size: 20px; margin-bottom: 5cm; margin-top: 5cm;\">The End</p>"

# ╔═╡ 8158cd5f-4bb1-4357-b1df-a74e336b2ca2
md"## Utils"

# ╔═╡ 56a4c9f3-f9a9-484c-92ec-b2e9b4d9f11d
import HTTP, Clang_jll, MultilineStrings, InteractiveUtils

# ╔═╡ 13cdb2a5-e913-413d-a766-ba56a74520a6
begin
struct JavaCode <: Code
    code::String
end

macro java_str(s)
    return :($JavaCode($(esc(s))))
end

SimpleClang.source_extension(::JavaCode) = "java"
end

# ╔═╡ 698f24bf-e894-4884-b281-a7cdcdafd719
# No need to go beyond `620` because pythontutor will just add an internal slider an not show full code
function tutor(code::Code; width = 800, height = min(620, 260 + 20 * countlines(IOBuffer(code.code))), frameborder = 0, curInstr = 0)
	esc_code = HTTP.escapeuri(code.code)
    src = "https://pythontutor.com/iframe-embed.html#code=$esc_code&cumulative=false&py=$(source_extension(code))&curInstr=$curInstr"
	return HTML("""<iframe width="$width" height="$height" frameborder="$frameborder" src="$src"></iframe>""")
end

# ╔═╡ a06ca6e6-c523-4197-9d07-fab9af844d5e
tutor(swap_c)

# ╔═╡ 129b9cce-3c46-40aa-a53a-4e2fbff5d151
tutor(xy_ptr)

# ╔═╡ f91691a7-4bd9-4d32-a012-89ec73bbe9e0
tutor(somme)

# ╔═╡ eb61d818-8ee6-4f49-b865-93ae58bd8739
tutor(java"""
public class MainClass {
  public static void main(String[] args) {
	String str = "Hello";
	System.out.println(str);
	System.out.println(str.length());
  }
}
""")

# ╔═╡ 68c0d683-71b7-48d9-850a-1fe9b551608a
tutor(c"""
#include <stdio.h>
int main()
{
    char c = 'X';
    char str[] = "EPL";
    char str2[] = "UCLouvain";
    char *ptr;
    printf("Caractère: %d\n", c);
    printf("String 1: %s\n", str);
    printf("String 2: %s\n", str2);
    ptr = str2;
    printf("String 3: %s\n", ptr);
    return 0;
}
""")

# ╔═╡ 0be89cc6-b76f-4ca3-af18-0b573a5291d9
tutor(c"""
#include <stdio.h>
int len(char str[])
{
    int i = 0;
    while (str[i] != '\0')
        i++;
    return i;
}
int main()
{
    char str[] = "UCLouvain";
    printf("Longueur: %d\n", len(str));
}
""")

# ╔═╡ 8b0305e1-cf04-4632-8da4-a688cf5c2a10
tutor(c"""
#include <stdio.h>
int len(char str[])
{
    int i = 0;
    while (*(str + i) != '\0')
        i++;
    return i;
}
int main()
{
    char str[] = "UCLouvain";
    printf("Longueur: %d\n", len(str));
}
""")

# ╔═╡ bbb4ca2c-c063-4495-bfd2-1999f8f13b08
tutor(c"""
#include <stdio.h>
int main()
{
    char *str = "UCLouvain";
    int len = 0;
    while (*(str) != '\0')
    {
        len++;
        str++;
    }
    printf("Chaîne %s longueur %d\n", str, len);
    return 0;
}
""")

# ╔═╡ 0352ffa1-6a82-4bcf-a510-450d9d5c8aca
tutor(c"""
#include <stdio.h>
// retourne i*j
int times(int i, int j)
{
    int m;
    m = i * j;
    return m;
}
// calcul récursif de factorielle
// n>0
int fact(int n)
{
    int f;
    if (n == 1)
    {
        return (n);
    }
    f = fact(n - 1);
    f = times(n, f);
    return f;
}
int main()
{
    printf("%d\n", fact(3));
}
""")

# ╔═╡ 05e27527-c3bd-41d1-a364-a214eb9a0ad6
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

# ╔═╡ 9a4f381c-f042-48a6-9657-56a8a7b911a0
img("https://lepl1503.info.ucl.ac.be/syllabus/theorie/_images/figures-001-c.png", :width => 200)

# ╔═╡ 06a88c15-1816-4244-8780-9413aba45f4a
img("https://lepl1503.info.ucl.ac.be/syllabus/theorie/_images/figures-001-c.png", :width => 200)

# ╔═╡ 526040f3-9711-4461-965b-b0c00bd54c3e
two_columns(left, right) = hbox([
	left,
	Div(html" ", style = Dict("flex-grow" => "1")),
	right,
])

# ╔═╡ 6c1b0d3d-0aee-44d0-9154-2d2711dc7a3d
two_columns(c"""int main(int argc, char **argv) {
   int tab[] = {2, 4, 8, 16};
""",
md"""
* segments text
* données
* heap
* stack
""")

# ╔═╡ cbaea0f9-6290-49f6-9e5a-7146d5f81f2f
two_columns(c"""int main(int argc, char **argv) {
   int *tab = (int *)malloc(4 * sizeof(int));
""",
md"""
* segments text
* données
* heap
* stack
""")

# ╔═╡ 750d19b9-5f61-435f-b44f-c197f259cc28
two_columns(c"""int main(int argc, char **argv) {
   int *tab = (int *)malloc(4 * sizeof(int));
""",
md"""
* segments text
* données
* heap
* stack
""")

# ╔═╡ e8faf704-58b2-4462-a73d-89f6a1eed45e
three_columns(left, center, right) = hbox([
	left,
	Div(html" ", style = Dict("flex-grow" => "1")),
	center,
	Div(html" ", style = Dict("flex-grow" => "1")),
	right,
])

# ╔═╡ 1154b80f-a695-4a64-a145-15606066c132
function wooclap(link)
	logo = HTML("""<img alt="Wooclap Logo" src="https://www.wooclap.com/images/wooclap-logo.svg">""")
	url = "https://app.wooclap.com/$link"
	a = HTML("""<a style="margin-left: 80px;" href="https://app.wooclap.com/$link"><tt>$url</tt></a>""")
	qr = img("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$url", :height => 50, name = "$link.png")
	return three_columns(logo, a, qr)
end

# ╔═╡ d4fdfcfd-2849-4577-bce4-41f7e21c1127
woo = wooclap("EPL1503")

# ╔═╡ 8ade0a12-13de-4307-a26f-9ac74fd3d7db
woo

# ╔═╡ e20d4483-a5fa-4c5a-b367-60dff0e12712
woo

# ╔═╡ afc0886b-24b4-4002-b0f6-838d86975789
woo

# ╔═╡ 97766d38-44ac-466f-a993-bfcb73781202
woo

# ╔═╡ 0933258d-9d23-4136-96a4-f40333ac6f1a
woo

# ╔═╡ fe198976-eec1-47ed-9671-6d6274a304ed
woo

# ╔═╡ a739b3fa-489c-4384-8104-680b250ce611
woo

# ╔═╡ 7f6df947-f1b8-47c5-8fb7-e7d0ff6d2f75
woo

# ╔═╡ 9db6379e-ba20-4175-bfe6-ea6e6991f475
woo

# ╔═╡ 04abaa32-e036-4dae-9cb6-3d1c5288e336
function wooslide(title, code)
	return md"""
	## $title

	` `

	$code

	` `

	$woo
	"""
end

# ╔═╡ 95941d9c-4cf1-4142-b46b-7335ec9a229e
wooslide("Pointeurs et chaînes de caractères", c"""
char string[] = "abcdef";
*(string + 1) = 'X';
printf("%s\n", string);
""")

# ╔═╡ bad4291c-c917-41bf-bf14-3eedb6b46ea5
wooslide("Pointeurs et chaînes de caractères", c"""
char string[] = "abcdef";
*(string + 1) = 'X';
printf("%s\n", string);
""")

# ╔═╡ ef7a1f2f-e0ae-4b71-9d93-c2a8574adfe1
wooslide("Pointeurs et chaînes de caractères", c"""
char *string = "abcdef";
string++;
printf("%s\n", string);
""")

# ╔═╡ 97a71eed-8d15-4dfd-8072-28cfd060e704
wooslide("Pointeurs et chaînes de caractères", c"""
char string[] = "abcdef";
*(string + strlen(string)) = 'G';
printf("%s\n", string);
""")

# ╔═╡ 1ecfb069-83b2-43c6-aae2-da371f67165c
wooslide("Pointeurs et chaînes de caractères", c"""
char string[] = "abcdef";
*(string + strlen(string) + 1) = 'Z';
printf("%s\n", string);
""")

# ╔═╡ 5b416b7e-4197-4479-9146-abbafc09ff69
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

# ╔═╡ b70ff116-76ec-4243-ad67-fb30e0a8b1f3
qa(md"Qu'affiche ce code ?", md"Lorsque free libère la mémoire, il ne la remet pas à zéro, mais vous ne devriez pas accéder à une mémoire libérée par free")

# ╔═╡ 0a44d32b-b0cc-4986-ac9f-64bd435d4779
qa(md"Qu'affiche ce code ?", md"Free provoque une erreur, pointeur non alloué par malloc")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Clang_jll = "0ee61d77-7f21-5576-8119-9fcc46b10100"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
MultilineStrings = "1e8d2bf6-9821-4900-9a2f-4d87552df2bd"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SimpleClang = "d80a2e99-53a4-4f81-9fa2-fda2140d535e"

[compat]
Clang_jll = "~18.1.7"
HTTP = "~1.10.19"
HypertextLiteral = "~1.0.0"
MultilineStrings = "~1.0.0"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.79"
SimpleClang = "~0.1.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.5"
manifest_format = "2.0"
project_hash = "b1cc3c95a018c3b2d5fb189ee0868b92a7a0c5b3"

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
git-tree-sha1 = "21d088c496ea22914fe80906eb5bce65755e5ec8"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.1"

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
git-tree-sha1 = "d1a86724f81bcd184a38fd284ce183ec067d71a0"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "1.0.0"

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

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

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
git-tree-sha1 = "8c49220ba78101000fcbbf9cb858010dd9b74a7b"
uuid = "1e8d2bf6-9821-4900-9a2f-4d87552df2bd"
version = "1.0.0"

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

[[deps.SimpleClang]]
deps = ["Clang_jll", "InteractiveUtils", "LLVMOpenMP_jll", "Markdown", "MultilineStrings"]
git-tree-sha1 = "b3d3225c2513bedab65df13f7968c3ab48e785cc"
uuid = "d80a2e99-53a4-4f81-9fa2-fda2140d535e"
version = "0.1.0"

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
# ╟─a4adbbef-a392-40da-9443-0ec5c7b07914
# ╟─c9babcf0-963d-46e3-b8d9-9593e0ea66c0
# ╟─7c7f942d-c235-4ec9-b21b-dcb6c90554a8
# ╟─8ade0a12-13de-4307-a26f-9ac74fd3d7db
# ╟─f0f26473-f64a-4111-b40e-79e3b60f2b9d
# ╟─d3d74430-c125-40a8-9d38-9ad5c01b62cd
# ╟─b59bf796-fc44-4ce8-9fdc-60f36bcb021f
# ╟─a06ca6e6-c523-4197-9d07-fab9af844d5e
# ╟─19f03198-5180-432c-bbce-4107c1593ff1
# ╟─c457f42e-7d5d-4e98-93e0-5ef06271350d
# ╟─7ba78557-0744-45a9-bcd7-d7f24d91fe89
# ╟─ba1c0405-b097-43ae-bf46-57c507453bee
# ╟─adbe76b7-b1a0-4f87-84c3-29d78e85aa54
# ╟─a0b28bb3-42b2-4dbc-957d-207599096308
# ╟─b6b11213-78a8-472c-ae3b-b9962326c613
# ╟─068aca17-76d9-4d4a-9c13-c4c7086280fc
# ╟─dfac707f-f492-44e1-9cb0-600ec29af681
# ╠═9a313e99-ff30-435b-a716-0ae1ea3203e0
# ╟─1f574a88-0516-4e19-a146-beda76e2cc5e
# ╠═72243e55-0806-4380-a054-d463dcd30832
# ╟─1c3b5990-6802-4773-bd72-53f3a0eff470
# ╠═76e2d7c4-e54c-402d-b444-4eece84104b5
# ╟─1394d233-a1d1-4575-9b2d-bd6a2d59de4c
# ╠═5a3397a8-bdd5-4e09-a2e3-dc93cb82a9d2
# ╟─92da2bc6-df2d-4e3f-b25d-78d60e656c14
# ╟─a79d619c-a091-4242-b292-0844fbf493d0
# ╠═3da8667c-0d2b-4ffe-bfbd-df350837fdda
# ╟─d47ad331-b1a4-49e9-a2ff-9243d5df1cbd
# ╟─129b9cce-3c46-40aa-a53a-4e2fbff5d151
# ╟─f02e4c73-7369-4f00-a350-341424bb1b0e
# ╟─695d0382-f30a-4b0f-9110-21cb640941bf
# ╟─e20d4483-a5fa-4c5a-b367-60dff0e12712
# ╟─85d7d6e9-5d64-4756-95f4-d9e653fd8f4c
# ╟─ccb1cfec-aaca-43ca-87c2-c860188f9cdf
# ╟─afc0886b-24b4-4002-b0f6-838d86975789
# ╟─bc821e86-8e8b-46db-8738-dac57d2711f2
# ╟─e23fb881-bcf0-46db-8806-c9591a02c391
# ╟─97766d38-44ac-466f-a993-bfcb73781202
# ╟─4e590ad1-d5ca-48e9-bbce-a2027905f74a
# ╟─6e9e33e2-1610-4cb1-be29-72750d639992
# ╟─0933258d-9d23-4136-96a4-f40333ac6f1a
# ╟─f8866701-312c-4dd1-9edc-5acbb60c2e07
# ╟─c0a45b63-9272-4cdf-a652-299ee9c7dfff
# ╟─75d35f92-191a-4e12-a3ba-b5e68ebca644
# ╟─fe198976-eec1-47ed-9671-6d6274a304ed
# ╟─188d706c-1e55-4b22-9bf5-13c00585e7d2
# ╟─f2c55534-28a4-4774-b1c2-50e3c922dd12
# ╟─e90a55d8-e909-4404-937b-a6a2c6818a66
# ╟─7318d4e6-a8ad-4f1d-8f1d-35b091ea0409
# ╟─f91691a7-4bd9-4d32-a012-89ec73bbe9e0
# ╟─b4e552a2-49a2-4cb4-bab5-f854efa55dbf
# ╟─4d42068f-fb23-4402-a80f-a720e11153ff
# ╟─eb61d818-8ee6-4f49-b865-93ae58bd8739
# ╟─06291f81-a945-4538-a632-a95a4b032d41
# ╟─a739b3fa-489c-4384-8104-680b250ce611
# ╟─68c0d683-71b7-48d9-850a-1fe9b551608a
# ╟─55cf950e-8408-477c-9b11-bb8bf2b79332
# ╠═d4e85b27-3ef5-45ed-a144-33994780d83f
# ╟─eac15e33-2d8e-4dff-93f5-6e06d1f86620
# ╠═1cf54714-a2a6-45ca-9bf8-b6ef53ab5765
# ╟─cfd9ff83-db13-42d4-9676-4ea8ee6021cd
# ╟─0be89cc6-b76f-4ca3-af18-0b573a5291d9
# ╟─62ca9b5e-260c-4823-9a47-a9afa7d1becc
# ╟─8b0305e1-cf04-4632-8da4-a688cf5c2a10
# ╟─0177da0f-4992-4b4f-a199-026fab7cc9b4
# ╟─bbb4ca2c-c063-4495-bfd2-1999f8f13b08
# ╟─bd9511dd-d51a-4382-8c69-274c571784c0
# ╟─fea327e5-62c8-4772-8cc0-00c7f225e1c4
# ╟─5fd01b09-3301-4b6f-b8f9-89e3a1075a8c
# ╟─7f6df947-f1b8-47c5-8fb7-e7d0ff6d2f75
# ╟─b156e291-cd1b-48cf-91a2-0c44634bafe9
# ╟─1139437c-739e-4599-aa56-6654925bcb02
# ╟─0d6ed070-3364-404b-a585-e5775bdf6fa4
# ╟─9db6379e-ba20-4175-bfe6-ea6e6991f475
# ╟─95941d9c-4cf1-4142-b46b-7335ec9a229e
# ╟─bad4291c-c917-41bf-bf14-3eedb6b46ea5
# ╟─ef7a1f2f-e0ae-4b71-9d93-c2a8574adfe1
# ╟─97a71eed-8d15-4dfd-8072-28cfd060e704
# ╟─0703ee4a-eada-4243-a9e1-bf054cbf4bc5
# ╟─1ecfb069-83b2-43c6-aae2-da371f67165c
# ╟─b40eb78b-591a-4230-ab4d-55e04d6d6d8c
# ╟─8768cc26-9bcc-41d9-b49d-2462870d58f3
# ╟─9303edd4-71df-499a-b64f-eebef96819a6
# ╟─ddbe345b-d667-47df-8232-839ebe393d53
# ╟─839fd0b2-57b2-4986-9fc7-5ae5f80f45cd
# ╟─089700ff-5dd6-4677-b346-d2ab2c0e3cc4
# ╟─9a4f381c-f042-48a6-9657-56a8a7b911a0
# ╟─883b6212-354a-4c7c-805a-c6919b63f6a4
# ╟─2e421906-8749-4a02-95b5-49afb07532c5
# ╟─2a149ea2-8d0f-411b-b0cf-e6ecfce51183
# ╠═183e26c0-77ac-4d9e-9be9-4d5cc3bfb8c4
# ╟─1e738ec1-9c1a-474f-a49c-42409da9f473
# ╟─51030efe-c399-4d98-9cf4-551fc177c1be
# ╟─69dc6465-f42c-4f66-8ec8-d3fd3c942f80
# ╟─07ed2c6b-c475-4a7d-8d57-6abdf112e77d
# ╟─562ca6c1-634a-428b-aa18-fe77fb8878c4
# ╟─a47e967c-078a-44ab-bfcb-c069e155ce25
# ╟─06a88c15-1816-4244-8780-9413aba45f4a
# ╟─1294b025-2ffb-499f-b72c-7d4aee21b53c
# ╟─ba1a0a5c-9a68-4c26-bfd3-cc25608c7cc7
# ╟─0352ffa1-6a82-4bcf-a510-450d9d5c8aca
# ╟─3aa0b2f0-a3d1-4201-a68d-57ba7b08842e
# ╟─d901922a-ba35-47fa-9e3a-051926f24afb
# ╟─5da040e9-84c2-4f4b-9f84-a8fe46ba7126
# ╟─c7119f95-2485-49ac-bd33-0c4bc907df7c
# ╟─6c1b0d3d-0aee-44d0-9154-2d2711dc7a3d
# ╟─dfef622a-c02a-428e-94e5-035019fd3457
# ╟─667efd31-4b95-4546-be32-76b383e256e1
# ╟─cbaea0f9-6290-49f6-9e5a-7146d5f81f2f
# ╟─f0ef730f-1a20-481a-8301-490b3664ed94
# ╟─3fe81691-b8f3-47a2-9a11-78233b34874c
# ╟─750d19b9-5f61-435f-b44f-c197f259cc28
# ╟─c5ecef00-e1e6-4201-8108-3fa287af548c
# ╟─cebdcb4d-6894-4b04-91b8-c9f83d1c9fc8
# ╟─b70ff116-76ec-4243-ad67-fb30e0a8b1f3
# ╟─369c4985-cdb5-4a30-a6e0-2ac02217489a
# ╟─627ad27a-d332-4f12-b1c9-70926864232d
# ╟─0a44d32b-b0cc-4986-ac9f-64bd435d4779
# ╟─ec2e4242-de1e-4fde-866c-fa7847c28c1b
# ╟─8158cd5f-4bb1-4357-b1df-a74e336b2ca2
# ╟─04abaa32-e036-4dae-9cb6-3d1c5288e336
# ╠═d4fdfcfd-2849-4577-bce4-41f7e21c1127
# ╠═0973097a-02c4-11f1-ac60-339637a3ae4b
# ╠═56a4c9f3-f9a9-484c-92ec-b2e9b4d9f11d
# ╟─13cdb2a5-e913-413d-a766-ba56a74520a6
# ╟─698f24bf-e894-4884-b281-a7cdcdafd719
# ╟─1154b80f-a695-4a64-a145-15606066c132
# ╟─05e27527-c3bd-41d1-a364-a214eb9a0ad6
# ╟─526040f3-9711-4461-965b-b0c00bd54c3e
# ╟─e8faf704-58b2-4462-a73d-89f6a1eed45e
# ╟─5b416b7e-4197-4479-9146-abbafc09ff69
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
