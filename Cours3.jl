### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 3467ae64-1162-40c3-ae82-fa605e1325df
import Pkg

# ╔═╡ 76aa8111-1ecd-44c8-8ee2-6d74d82d38c5
Pkg.activate(".")

# ╔═╡ 62ea7632-cfe1-4d0a-90db-d7d3eee27763
using Luxor, PlutoUI, PlutoUI.ExperimentalLayout, MyUtils, PlutoTeachingTools, CommonMark

# ╔═╡ d9b5ce6e-f80d-11ef-26cd-f5e2c18c51bb
header("LEPL1503/LSINC1503 - Cours 3", "O. Bonaventure, B. Legat, L. Metongnon")

# ╔═╡ cbab5d55-63e2-46a4-b86f-d00eb0f1c507
frametitle("Rappel organisation du cours")

# ╔═╡ 28ad2f17-89d5-44b4-87c3-d385d874ed87
md"""
Rappel slides du premier cours

> Permanence le vendredi de 13h à 15h les semaines où il n’y a pas de cours théorique

Le tuteur n'a pas le temps de résoudre les problèmes d'installation en séance
"""

# ╔═╡ 93efbc2f-e078-46aa-b33d-03b30ee629ab
section("Stack overflow 💥")

# ╔═╡ 2dc74f5c-a40e-4a3f-964d-d77e46684592
frametitle("Factorial")

# ╔═╡ 2dc7800b-f584-4ddc-9f19-486ca0ce21f5
tutor("""
int factorial(int n) {
  if (n <= 1)
    return 1;
  else
    return n * factorial(n - 1);
}

int main () {
  factorial(10);
}
""")

# ╔═╡ 0c516dcd-ae8b-4ad5-834d-2964d1c6738b
Foldable(md"Que se passe-t-il si on oublie `if (n <= 1)` ?", md"On pourrait croire que le programme ne s'arrête jamais. Seulement, la taille de la stack va grandir progressivement jusqu'à atteindre la limite mémoire. Ceci provoquera une *stack overflow*.")

# ╔═╡ 0bcea29e-a529-4a34-98b3-f7708ae0c164
frametitle("Fibonacci")

# ╔═╡ f8650fa0-02be-4117-9f70-e2d71a6dcc68
md"Cette implémentation de Fibonacci a une très mauvaise complexité mais elle illustre bien la dynamique de la stack qui grandit et rapetissit rapetissit au rythme des appels de fonctions."

# ╔═╡ 90ca03b6-331f-401b-bacc-2999e184055b
tutor("""
int fibonacci(int n) {
  if (n <= 2)
    return 1;
  else
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main () {
  fibonacci(6);
}
""")

# ╔═╡ 226a5f51-738e-4abf-9cbe-f131dae2ea55
section("Git")

# ╔═╡ 0a31d929-9d65-417b-b6b2-e432a1f01ffe
md"""
* [Tutoriel $(img("https://upload.wikimedia.org/wikipedia/commons/e/e0/Git-logo.svg", :height => "15pt")) disponible dans le syllabus](https://lepl1503.info.ucl.ac.be/syllabus/outils/git.html)
* [Learn Git Branching interactivey](https://learngitbranching.js.org/) $(img("https://learngitbranching.js.org/assets/favicon.ico", :height => "15pt"))
"""

# ╔═╡ 88674bd2-66b1-4c49-a7dd-071b93188d1f
frametitle("Contexte")

# ╔═╡ fe8b1e1b-8a8b-4d44-8045-0fbc205e7814
md"""
* Linus Torvalds crée $(img("https://upload.wikimedia.org/wikipedia/commons/e/e0/Git-logo.svg", :height => "15pt")) en 2005
* [A maintenant 87 % du market share les logiciels de gestion de versions](https://6sense.com/tech/version-control)
* Serveur open source $(img("https://upload.wikimedia.org/wikipedia/commons/c/c8/GitLab_logo_%282%29.svg", :height => "15pt")) (utilisé par [la forge](https://forge.uclouvain.be))
  - GitLab CI permet de run les tests et build la documentation de façon **automatisé** et **reproductible** à *chaque nouveau commit*
* En 2014, Satya Nadella remplace Steve Ballmer en tant que CEO de $(img("https://upload.wikimedia.org/wikipedia/commons/9/96/Microsoft_logo_%282012%29.svg", :height => "15pt"))
  - 2016: Release du logicel open source VS Code $(img("https://upload.wikimedia.org/wikipedia/commons/9/9a/Visual_Studio_Code_1.35_icon.svg", :height => "15pt"))
  - 2016: Release de Windows Subsystem for Linux (WSL) → *Virtually* all OS are $(img("https://static.wikia.nocookie.net/logopedia/images/0/0e/Unix.svg", :height => "12pt")) now!
  - En 2018,  acquisition de $(img("https://static.wikia.nocookie.net/windows/images/0/01/GitHub_logo_2013.png/revision/latest?cb=20231201024220", name = "GitHub_logo_2013.png", :height => "20pt"))
    * Lancement de GitHub Actions (imitant GitLab CI) gratuit pour dépôts open source
"""

# ╔═╡ 2f255c13-f975-40b6-9ca4-e3ca08960126
frametitle("Typical workflow")

# ╔═╡ 41830ab8-ad81-4116-972d-9e36a5ee89a1
md"""
Dans le projet, on vous demande d'utiliser le workflow Git classique (voir par exemple [$(img("https://jump.dev/JuMP.jl/dev/assets/logo-with-text-background.svg", :width => 45px))](https://github.com/jump-dev/JuMP.jl/)):

* **Invariant** La branche `main` la dernière version
  - Elle doit passer tous les tests sans erreurs
  - Les changements incorporés dans `main` ne sont plus sujets à discussion
* Une branch correspond à **un changement**
  - Eviter de mettre plusieurs changements qui ne sont pas liés dans la même branch
  - Une branche n'est **pas** la dernière version du code d'un dévelopeur
    * Un dévelopeur qui veut essayer un autre changement doit repartir de `main` et créer une nouvelle branche
    * Un dévelopeur qui veut aider au même changement peut commit sur la même branch.
"""

# ╔═╡ 6ea1cef3-384c-40a1-a09b-edf604888c3d
diff_version = Foldable(
  md"Si l'invariant est respecté, tout nouveau commit dans `main` pourrait faire l'objet d'une nouvelle release **mais**",
md"""
* Chaque nouvelle release va engendré une update pour les utilisateurs donc évite de le faire ça chaque commit
* Il faut respecter le [semantic versioning](https://semver.org/) donc
  - Si `main` possède une nouvelle feature par rapport à la dernière release, il faut passer par exemple de `1.3.8` à `1.4.0`.
  - Si `main` possède un breaking change par rapport à la dernière release, il faut passer par exemple de `0.3.8` à `0.4.0` ou `1.3.8` à `2.0.0`
""");

# ╔═╡ d6db0b27-cec7-4696-a56b-ced00bf2c843
aside(warning_box(md"""
Il faut faire la différence entre un l*ogiciel de gestion de versions* comme Git et les *versions de releases*.
$diff_version
"""), v_offset = -300)

# ╔═╡ 1c39a7f2-cd5e-456a-bf16-76493e29adeb
frametitle("Le cycle de vie d'une branch")

# ╔═╡ 34da9f3f-4bde-45da-b27b-d6b4445bbe8b
md"""
* Avant tout changement, on part de la dernière version de main:
  - `git checkout main`
  - `git pull origin main`
* Après tout changement, on crée une branche et on la push
  - `git checkout -b new_branch`
  - `git commit -am "Courte description"` ce message deviendra le titre du MR
  - `git push origin new_branch`
* Sur GitLab, on crée un merge request (MR) et on attend
  1) le résultat de GitLab CI
  2) les peer reviewing de nos pairs
* Pour résoudre les problèmes de CI ou les reviews, on ajoute des commits sur la branche
  - `git checkout new_branch` (plus besoin de `-b` car la branche existe déjà)
  - `git pull origin new_branch` au cas où d'autres l'ont changé
  - `git commit -am "Address review"` ce message a moins d'importance
  - `git push origin new_branch`
* Une fois que le CI est vert et que nos pairs on accepté, on merge le MR
"""

# ╔═╡ 15953e07-0d3a-462a-8f4d-8c1609d37b50
section("Merge")

# ╔═╡ 0b248037-782c-4f57-ad2c-c20d2940f3db
md"[Source des images](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)"

# ╔═╡ a0adfd7c-52eb-437f-b9af-9323fc374c1a
frametitle("Deux branches en cours...")

# ╔═╡ e4fa4941-25bb-4191-a7df-700852e7b5bc
frametitle("Une des deux est mergée en premier")

# ╔═╡ 96e9ced9-9f89-4053-90b9-679447316ca6
md"```sh
$ git checkout main
$ git merge a
```"

# ╔═╡ 61ff6065-3bfe-432e-ba07-87b9ef7c72f1
md"Comme `main` était un ancètre de `a`, c'est un *fast forward* merge. On aurait pu faire
```sh
$ git merge --ff-only a
```
pour qu'il envoie une erreur si ce n'est pas fast forward."

# ╔═╡ 6050693f-ac64-4537-a561-93688ab94b85
frametitle("Un merge explicite")

# ╔═╡ 32b000ef-39a2-4682-b45a-d9cfd2e33f81
md"```sh
$ git checkout main
$ git merge --no-ff a
```"

# ╔═╡ ac0487f3-d9ae-45a4-b4ff-81f0fb1553a5
md"**Important** Comme on était sur la branche `main`, on ne modifie **que** `main`. Remarquez que `a` n'a pas bougé! Ceci est toujours vrai sur `git`, vous ne modifiez que la branche sur laquelle vous êtes `checkout`."

# ╔═╡ 373dc385-d77e-495a-9f1f-f9424a8f27bb
frametitle("Si l'autre branche est prête, on la merge")

# ╔═╡ b9746823-8c9b-462d-875a-250b882efcad
md"""
```sh
$ git checkout main
$ git merge b
```
"""

# ╔═╡ 4afc49da-240a-42c7-842f-d9adcdf26c5c
md"""Ici, le merge ne peut pas être fast forward donc
```sh
$ git merge --ff-only b
```
enverrait une erreur.
"""

# ╔═╡ 5caab77a-31c9-4042-8fba-2f9b3e1520b7
frametitle("Si l'autre branche n'est pas prête, que faire ?")

# ╔═╡ 5628641b-ad16-40ac-8156-cbdb19ac4f45
Foldable(
	md"Peut-on continuer à commit sur l'autre branche sans synchroniser ?",
	md"Très déconseillé, on risque de créer des conflits, il faut synchroniser le plus vite possible!"
)

# ╔═╡ 3d2bad59-45a8-48ea-8a7b-55ffa34af747
frametitle("Avant de continuer, on synchronise")

# ╔═╡ a03740c1-28a4-4233-9c21-2feca082aa90
md"""
```sh
$ git checkout b
$ git merge main
```
"""

# ╔═╡ 8a2a0c95-1544-42e4-a1ab-a2e9f23be57f
frametitle("On peut ensuite continuer")

# ╔═╡ 82a1475b-2d04-4a46-86cd-1f437ab9c6b9
frametitle("Quand la seconde branche est finie")

# ╔═╡ 7b512972-17ee-452b-b62c-c63f9f1ea9f1
function tree(t; s = 80)
	off(a, b) = a + sign(b - a) * 0.1
	c(m, i, j) = boxed(m, Point(i * s, j * s))
	a(i1, j1, i2, j2) = arrow(Point(off(i1, i2) * s, off(j1, j2) * s), Point(off(i2, i1) * s, off(j2, j1) * s))
	branch(m, i, j) = text(m, Point(i * s, j * s), halign=:left, valign=:middle)
	function ac(i1, j1, i2, j2, m)
		a(i1, j1, i2, j2)
		c(m, i2, j2)
	end
	@draw begin
		c("C0", -3, 0)
		ac(-3, 0, -2, 0, "C1")
		ac(-2, 0, -1, 0, "C2")
		aj = t <= 1 ? -1 : 0
		ac(-1, 0, 0, aj, "A1")
		ac(0, aj, 1, aj, "A2")
		ac(-1, 0, 0, 1, "B1")
		ac(0, 1, 1, 1, "B2")
		bj = t <= 6 ? 1 : 0
		if t == 4
			ac(1, 1, 2, 1, "B3")
		elseif t >= 5
			a(1, 0, 2, bj)
			ac(1, 1, 2, bj, "M")
		end
		if t >= 6
			ac(2, bj, 3, bj, "B3")
		end
		if t <= 1
			branch("a", 1.2, -1)
		end
		if t <= 6
			branch("b", t >= 4 ? (t >= 6 ? 3.2 : 2.2) : 1.2, 1)
		end
		if t == 1
			a(-1, 0, 2, 0)
			ac(1, -1, 2, 0, "M")
		elseif t == 3
			a(1, 1, 2, 0)
			ac(1, 0, 2, 0, "M")
		end
		branch("main", t == 7 ? 3.2 : (t == 0) ? -0.8 : ((t == 1 || t == 3) ? 2.2 : 1.2), 0)
	end 7.5s 2.7s
end;

# ╔═╡ f62f605f-56f1-4fed-bde5-a2d16310bfd9
tree(0)

# ╔═╡ 24eb8253-8718-4a11-930a-82ef5743cc75
tree(2)

# ╔═╡ ec4a0cad-f3ca-4f12-aab2-1df86e1e236d
tree(1)

# ╔═╡ 739a3253-91d9-4776-a130-d8c5bb2397e2
tree(3)

# ╔═╡ ed704366-8b0e-4b52-94d8-c05e1fd31b5d
tree(4)

# ╔═╡ 73911f1c-d2cb-4064-889c-fab5f95191ca
tree(5)

# ╔═╡ 7ebe2342-b365-44d9-a2bd-a1cea0a972e6
tree(6)

# ╔═╡ 4b870006-b221-49e9-b077-f1abf9ee10b4
tree(7)

# ╔═╡ d863aac9-b9f7-480e-892d-1d510f34dfa7
frametitle("Bouton merge sur GitHub/GitLab")

# ╔═╡ 4be20622-1534-4bd1-9653-66527226e670
md"La branche `main` du slides précédente contient des détails internes aux branches `a` et `b`. On aimerait plutôt avoir un commit par branche avec un lien vers le merge request correspondant pour voir plus de détails le cas échéant."

# ╔═╡ 18283586-52e0-477c-a926-e6c2e5cdbb6e
function squash(; s = 80)
	off(a, b) = a + sign(b - a) * 0.1
	c(m, i, j) = boxed(m, Point(i * s, j * s))
	a(i1, j1, i2, j2) = arrow(Point(off(i1, i2) * s, off(j1, j2) * s), Point(off(i2, i1) * s, off(j2, j1) * s))
	branch(m, i, j) = text(m, Point(i * s, j * s), halign=:left, valign=:middle)
	function ac(i1, j1, i2, j2, m)
		a(i1, j1, i2, j2)
		c(m, i2, j2)
	end
	@draw begin
		c("C0", -3, 0)
		ac(-3, 0, -2, 0, "C1")
		ac(-2, 0, -1, 0, "C2")
		ac(-1, 0, 0, 0, "A")
		ac(0, 0, 1, 0, "B")
		branch("main", 1.2, 0)
	end 7.5s 1.7s
end;

# ╔═╡ f1696330-2317-4cb4-989c-8e7395b47384
squash()

# ╔═╡ 5febbc94-db91-4c60-acae-9888fef74d63
frametitle("Squash commits")

# ╔═╡ 109a217e-bc88-46f9-b7f5-6a6993fc9918
img("squash")

# ╔═╡ 48d34efa-e884-41e2-84ee-9b418b063041
hbox([
md"""
Sans `Squash commits`
$(img("https://docs.github.com/assets/cb-5402/mw-1440/images/help/pull_requests/standard-merge-commit-diagram.webp", :height => "200pt"))
""",
md"""
Avec `Squash commits`
$(img("https://docs.github.com/assets/cb-5742/mw-1440/images/help/pull_requests/commit-squashing-diagram.webp", :height => "200pt"))
""",
])

# ╔═╡ ae673c76-0bda-41bd-b218-be3f358a97a2
md"[Source des images](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/about-pull-request-merges)"

# ╔═╡ b379b723-d3e4-45d3-b5e8-9958c6f5dd9b
frametitle("Reset")

# ╔═╡ d55c4b86-88f9-423c-8def-3c4de83ad3bb
md"""
Si vous avez sans faire exprès commit sur `main`, faites
```sh
$ git checkout -b new_branch
$ git checkout main
```
"""

# ╔═╡ 23067943-d07f-4f2a-a3f1-e49f2e2fc21e
danger(md"""
Vos changement sont maintenant sur `new_branch` donc vous pouvez les retirer de `main`.
Mais il faut faire très attention car les commandes suivantes peuvent vous faire perdre des changements.
Je conseille de faire `git push origin new_branch`, créer un merge request et vérifier visuellement dans l'interface GitLab que vos changements sont là.
Ensuite, 2 possibilités. Soit
```sh
$ git reset --hard origin/main # Dangereux command!
```
Soit en deux temps (en s'assurant qu'on est à la racine du dossier, sinon utiliser `..` ou `../..` etc... à la place de `.`)
```sh
$ git reset HEAD~1 # Annule le dernier commit, en supposant qu'il y en ai qu'un
$ git checkout . # Dangereux, ça écrase aussi les changements qui n'ont pas été commit
```
""")

# ╔═╡ 296818cf-7598-46d8-8c7d-c91fd41fa9d0
frametitle("Stash changes")

# ╔═╡ b58456cf-b417-4f40-a854-c04b6db744db
md"""
On est parfois dans la mauvaise branche et on veut appliquer nos changement dans une autre ou nouvelle branche.
On doit alors faire `git checkout` mais `git` ne voudra pas si on a changé des fichiers qui différent (même si c'est à des lignes différentes).
On `stash` alors les changements.
Conceptuellement la même chose que `cherry-pick` 🚁 mais sans faire de commit.
"""

# ╔═╡ 00837930-704a-44eb-84c2-bece8894ef0f
md"""
```
$ git stash
$ git checkout main
$ git stash apply
```
"""

# ╔═╡ 27e4de24-a81c-4437-a566-05da736f6e9d
section("Markdown")

# ╔═╡ 50acf567-a72a-4ada-af79-876b782e85c4
md"""
* Lors du peer review, l'utilisation correcte du Markdown sera prise en compte dans la cotation
* Markdown est un *markup language* (comme LaTeX ou HTML) [inventé par John Grubber en 2004](https://daringfireball.net/projects/markdown/)
* Il a ajourd'hui différentes variantes qui l'étende ou interprète différemment des ambiguité dans sa définition de 2004.
* En 2014, [CommonMark](https://commonmark.org/) est publié pour but de standardiser ces extensions et clarifier les ambiguités.
"""

# ╔═╡ 006977f7-c420-4562-b193-7fa7053c3397
frametitle("Example avec CommonMark")

# ╔═╡ 93b2e538-939a-4ed6-a039-cd749110987e
cm"""
| Aligne à gauche | Aligne à droite | Aligne au centre  |
|:---------- | ----------:|:------------:|
| Row `1`    | Column `2` |      [^1]    |
| *Row* 2    | **Row** 2  | Column ``|`` |

[^1]: Footnote
"""

# ╔═╡ 1b304f84-b649-45a0-860f-eb6a573df510
frametitle("Syntax highlighting")

# ╔═╡ 04b7e3c9-0962-4146-bcc3-0274efc33644
md"""
```c
int i = 0;
```
produit
```html
<code class="language-c">
int i = 0;
</code>
```
"""

# ╔═╡ 33967cf6-dc82-4bf5-9239-e0d5a12b1397
html"""<code class="language-c">int i = 0;</code>"""

# ╔═╡ d7102814-0102-43fb-b9ee-f78da0b2febe
frametitle("Permalink")

# ╔═╡ 3cbfb4f4-28a2-4c72-83ae-7f9c6233e8b6
md"""Un lien vers des lignes spécifiques du code doivent être liées à un commit spécifique car une branche évolue avec le temps. [GitHub affiche un code snippet](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-a-permanent-link-to-a-code-snippet) comme ci-dessous [mais pas encore sur GitLab](https://stackoverflow.com/questions/76063040/how-do-i-link-or-add-a-reference-to-specific-lines-of-code-of-a-file-in-the-repo)"""

# ╔═╡ 76e9e011-6665-4688-b3d6-c64b0d06c222
img("https://docs.github.com/assets/cb-68457/mw-1440/images/help/repository/rendered-code-snippet.webp")

# ╔═╡ e6b0b664-bf8e-419a-8c10-ac59fc1ae647
Pkg.instantiate()

# ╔═╡ Cell order:
# ╟─d9b5ce6e-f80d-11ef-26cd-f5e2c18c51bb
# ╟─cbab5d55-63e2-46a4-b86f-d00eb0f1c507
# ╟─28ad2f17-89d5-44b4-87c3-d385d874ed87
# ╟─93efbc2f-e078-46aa-b33d-03b30ee629ab
# ╟─2dc74f5c-a40e-4a3f-964d-d77e46684592
# ╟─2dc7800b-f584-4ddc-9f19-486ca0ce21f5
# ╟─0c516dcd-ae8b-4ad5-834d-2964d1c6738b
# ╟─0bcea29e-a529-4a34-98b3-f7708ae0c164
# ╟─f8650fa0-02be-4117-9f70-e2d71a6dcc68
# ╟─90ca03b6-331f-401b-bacc-2999e184055b
# ╟─226a5f51-738e-4abf-9cbe-f131dae2ea55
# ╟─0a31d929-9d65-417b-b6b2-e432a1f01ffe
# ╟─88674bd2-66b1-4c49-a7dd-071b93188d1f
# ╟─fe8b1e1b-8a8b-4d44-8045-0fbc205e7814
# ╟─2f255c13-f975-40b6-9ca4-e3ca08960126
# ╟─41830ab8-ad81-4116-972d-9e36a5ee89a1
# ╟─d6db0b27-cec7-4696-a56b-ced00bf2c843
# ╟─6ea1cef3-384c-40a1-a09b-edf604888c3d
# ╟─1c39a7f2-cd5e-456a-bf16-76493e29adeb
# ╟─34da9f3f-4bde-45da-b27b-d6b4445bbe8b
# ╟─15953e07-0d3a-462a-8f4d-8c1609d37b50
# ╟─0b248037-782c-4f57-ad2c-c20d2940f3db
# ╟─a0adfd7c-52eb-437f-b9af-9323fc374c1a
# ╟─f62f605f-56f1-4fed-bde5-a2d16310bfd9
# ╟─e4fa4941-25bb-4191-a7df-700852e7b5bc
# ╟─96e9ced9-9f89-4053-90b9-679447316ca6
# ╟─24eb8253-8718-4a11-930a-82ef5743cc75
# ╟─61ff6065-3bfe-432e-ba07-87b9ef7c72f1
# ╟─6050693f-ac64-4537-a561-93688ab94b85
# ╟─32b000ef-39a2-4682-b45a-d9cfd2e33f81
# ╟─ec4a0cad-f3ca-4f12-aab2-1df86e1e236d
# ╟─ac0487f3-d9ae-45a4-b4ff-81f0fb1553a5
# ╟─373dc385-d77e-495a-9f1f-f9424a8f27bb
# ╟─b9746823-8c9b-462d-875a-250b882efcad
# ╟─739a3253-91d9-4776-a130-d8c5bb2397e2
# ╟─4afc49da-240a-42c7-842f-d9adcdf26c5c
# ╟─5caab77a-31c9-4042-8fba-2f9b3e1520b7
# ╟─5628641b-ad16-40ac-8156-cbdb19ac4f45
# ╟─ed704366-8b0e-4b52-94d8-c05e1fd31b5d
# ╟─3d2bad59-45a8-48ea-8a7b-55ffa34af747
# ╟─a03740c1-28a4-4233-9c21-2feca082aa90
# ╟─73911f1c-d2cb-4064-889c-fab5f95191ca
# ╟─8a2a0c95-1544-42e4-a1ab-a2e9f23be57f
# ╟─7ebe2342-b365-44d9-a2bd-a1cea0a972e6
# ╟─82a1475b-2d04-4a46-86cd-1f437ab9c6b9
# ╟─4b870006-b221-49e9-b077-f1abf9ee10b4
# ╟─7b512972-17ee-452b-b62c-c63f9f1ea9f1
# ╟─d863aac9-b9f7-480e-892d-1d510f34dfa7
# ╟─4be20622-1534-4bd1-9653-66527226e670
# ╟─f1696330-2317-4cb4-989c-8e7395b47384
# ╟─18283586-52e0-477c-a926-e6c2e5cdbb6e
# ╟─5febbc94-db91-4c60-acae-9888fef74d63
# ╟─109a217e-bc88-46f9-b7f5-6a6993fc9918
# ╟─48d34efa-e884-41e2-84ee-9b418b063041
# ╟─ae673c76-0bda-41bd-b218-be3f358a97a2
# ╟─b379b723-d3e4-45d3-b5e8-9958c6f5dd9b
# ╟─d55c4b86-88f9-423c-8def-3c4de83ad3bb
# ╟─23067943-d07f-4f2a-a3f1-e49f2e2fc21e
# ╟─296818cf-7598-46d8-8c7d-c91fd41fa9d0
# ╟─b58456cf-b417-4f40-a854-c04b6db744db
# ╟─00837930-704a-44eb-84c2-bece8894ef0f
# ╟─27e4de24-a81c-4437-a566-05da736f6e9d
# ╠═50acf567-a72a-4ada-af79-876b782e85c4
# ╟─006977f7-c420-4562-b193-7fa7053c3397
# ╠═93b2e538-939a-4ed6-a039-cd749110987e
# ╟─1b304f84-b649-45a0-860f-eb6a573df510
# ╠═04b7e3c9-0962-4146-bcc3-0274efc33644
# ╠═33967cf6-dc82-4bf5-9239-e0d5a12b1397
# ╟─d7102814-0102-43fb-b9ee-f78da0b2febe
# ╟─3cbfb4f4-28a2-4c72-83ae-7f9c6233e8b6
# ╟─76e9e011-6665-4688-b3d6-c64b0d06c222
# ╟─3467ae64-1162-40c3-ae82-fa605e1325df
# ╟─76aa8111-1ecd-44c8-8ee2-6d74d82d38c5
# ╟─e6b0b664-bf8e-419a-8c10-ac59fc1ae647
# ╠═62ea7632-cfe1-4d0a-90db-d7d3eee27763
