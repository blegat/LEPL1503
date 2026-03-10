### A Pluto.jl notebook ###
# v0.20.23

using Markdown
using InteractiveUtils

# ╔═╡ 62ea7632-cfe1-4d0a-90db-d7d3eee27763
using Luxor, PlutoUI, PlutoUI.ExperimentalLayout, HypertextLiteral, PlutoTeachingTools, CommonMark, SimpleClang

# ╔═╡ d9b5ce6e-f80d-11ef-26cd-f5e2c18c51bb
@htl("""
<p align=center style=\"font-size: 40px;\">LEPL1503/LSINC1503 - Cours 3</p><p align=right><i>O. Bonaventure, B. Legat, M. Baerts</i></p>
$(PlutoTeachingTools.ChooseDisplayMode())
$(PlutoUI.TableOfContents(depth=1))
""")

# ╔═╡ cbab5d55-63e2-46a4-b86f-d00eb0f1c507
md"## Rappel organisation du cours"

# ╔═╡ 28ad2f17-89d5-44b4-87c3-d385d874ed87
md"""
Rappel slides du premier cours

> Permanence le vendredi de 13h à 15h les semaines où il n’y a pas de cours théorique

Le tuteur n'a pas le temps de résoudre les problèmes d'installation en séance
"""

# ╔═╡ 93efbc2f-e078-46aa-b33d-03b30ee629ab
md"# Stack overflow 💥"

# ╔═╡ 2dc74f5c-a40e-4a3f-964d-d77e46684592
md"## Factorial"

# ╔═╡ 0c516dcd-ae8b-4ad5-834d-2964d1c6738b
Foldable(md"Que se passe-t-il si on oublie `if (n <= 1)` ?", md"On pourrait croire que le programme ne s'arrête jamais. Seulement, la taille de la stack va grandir progressivement jusqu'à atteindre la limite mémoire. Ceci provoquera une *stack overflow*.")

# ╔═╡ 0bcea29e-a529-4a34-98b3-f7708ae0c164
md"## Fibonacci"

# ╔═╡ f8650fa0-02be-4117-9f70-e2d71a6dcc68
md"Cette implémentation de Fibonacci a une très mauvaise complexité mais elle illustre bien la dynamique de la stack qui grandit et rapetissit rapetissit au rythme des appels de fonctions."

# ╔═╡ 226a5f51-738e-4abf-9cbe-f131dae2ea55
md"# Git"

# ╔═╡ 88674bd2-66b1-4c49-a7dd-071b93188d1f
md"## Contexte"

# ╔═╡ 2f255c13-f975-40b6-9ca4-e3ca08960126
md"## Typical workflow"

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
md"## Le cycle de vie d'une branch"

# ╔═╡ 34da9f3f-4bde-45da-b27b-d6b4445bbe8b
md"""
* Avant tout changement, on part de la dernière version de main:
  - `git switch main`
  - `git pull origin main`
* Utilisez `git status` pour savoir où on en est et avoir des recommendations.
* Utilisez `git diff` pour voir les changements opérés. Avec `--cached` pour voir les changements acceptés dans la "stage", prêts à être commités.
* Après tout changement, on crée une branche et on la push
  - `git switch -c new_branch`
  - `git status` pour voir où on en est
  - `git diff` pour voir les changements opérés
  - `git add -p` pour ajouter les changements de manière interractive: on en profite pour s'auto-reviewer et on peut découper les commits pour aider les reviewers. `y` pour yes, `n` pour no, `?` pour l'aide.
  - `git add <new_files>` au cas où il y a de nouveaux fichiers
  - `git status` pour voir où on en est
  - `git diff --cached` pour voir les changements acceptés, prêts à être commités
  - `git commit -m "Courte description <50 caractères" -m "Expliquer la raison: pourquoi est-ce utile"
  - `git commit --amend` peut être utilisé pour éditer le message de commit et corriger des changements. Attention, Tous les changements ajoutés précédemment avec `git add` vont être fusionnés dans le commit précédent. Utilisez `git status` pour voir où vous en êtes.
  - `git push origin new_branch`
* Sur GitLab, on crée un merge request (MR) et on attend
  1) le résultat de GitLab CI
  2) les peer reviewing de nos pairs
* Pour résoudre les problèmes de CI ou les reviews, on ajoute des commits sur la branche
  - `git switch new_branch` (plus besoin de `-c` car la branche existe déjà)
  - `git pull origin new_branch` au cas où d'autres l'ont changé
  - `git status` pour voir où on en est
  - `git diff` pour voir les changements opérés
  - `git add -p` pour ajouter les changements de manière interractive: on en profite pour s'auto-reviewer et on peut découper les commits pour aider les reviewers. `y` pour yes, `n` pour no, `?` pour l'aide.
  - `git add <new_files>` au cas où il y a de nouveaux fichiers
  - `git status` pour voir où on en est
  - `git diff --cached` pour voir les changements acceptés, prêts à être commités
  - `git commit -m "Courte description <50 caractères" -m "Expliquer la raison: pourquoi est-ce utile"
  - `git push origin new_branch`
* Une fois que le CI est vert et que nos pairs on accepté, on merge le MR
"""

# ╔═╡ 15953e07-0d3a-462a-8f4d-8c1609d37b50
md"# Merge"

# ╔═╡ 0b248037-782c-4f57-ad2c-c20d2940f3db
md"[Source des images](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)"

# ╔═╡ a0adfd7c-52eb-437f-b9af-9323fc374c1a
md"## Deux branches en cours..."

# ╔═╡ e4fa4941-25bb-4191-a7df-700852e7b5bc
md"## Une des deux est mergée en premier"

# ╔═╡ 96e9ced9-9f89-4053-90b9-679447316ca6
md"```sh
$ git switch main
$ git merge a
```"

# ╔═╡ 61ff6065-3bfe-432e-ba07-87b9ef7c72f1
md"Comme `main` était un ancètre de `a`, c'est un *fast forward* merge. On aurait pu faire
```sh
$ git merge --ff-only a
```
pour qu'il envoie une erreur si ce n'est pas fast forward."

# ╔═╡ 6050693f-ac64-4537-a561-93688ab94b85
md"## Un merge explicite"

# ╔═╡ 32b000ef-39a2-4682-b45a-d9cfd2e33f81
md"```sh
$ git switch main
$ git merge --no-ff a
```"

# ╔═╡ ac0487f3-d9ae-45a4-b4ff-81f0fb1553a5
md"**Important** Comme on était sur la branche `main`, on ne modifie **que** `main`. Remarquez que `a` n'a pas bougé! Ceci est toujours vrai sur `git`, vous ne modifiez que la branche sur laquelle vous êtes."

# ╔═╡ 373dc385-d77e-495a-9f1f-f9424a8f27bb
md"## Si l'autre branche est prête, on la merge"

# ╔═╡ b9746823-8c9b-462d-875a-250b882efcad
md"""
```sh
$ git switch main
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
md"## Si l'autre branche n'est pas prête, que faire ?"

# ╔═╡ 5628641b-ad16-40ac-8156-cbdb19ac4f45
Foldable(
	md"Peut-on continuer à commit sur l'autre branche sans synchroniser ?",
	md"Très déconseillé, on risque de créer des conflits, il faut synchroniser le plus vite possible!"
)

# ╔═╡ 3d2bad59-45a8-48ea-8a7b-55ffa34af747
md"## Avant de continuer, on synchronise"

# ╔═╡ a03740c1-28a4-4233-9c21-2feca082aa90
md"""
```sh
$ git switch b
$ git merge main
```
"""

# ╔═╡ 8a2a0c95-1544-42e4-a1ab-a2e9f23be57f
md"## On peut ensuite continuer"

# ╔═╡ 82a1475b-2d04-4a46-86cd-1f437ab9c6b9
md"## Quand la seconde branche est finie"

# ╔═╡ d863aac9-b9f7-480e-892d-1d510f34dfa7
md"## Bouton merge sur GitHub/GitLab"

# ╔═╡ 4be20622-1534-4bd1-9653-66527226e670
md"La branche `main` du slides précédente contient des détails internes aux branches `a` et `b`. On aimerait plutôt avoir un commit par branche avec un lien vers le merge request correspondant pour voir plus de détails le cas échéant."

# ╔═╡ 5febbc94-db91-4c60-acae-9888fef74d63
md"## Squash commits"

# ╔═╡ ae673c76-0bda-41bd-b218-be3f358a97a2
md"[Source des images](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/about-pull-request-merges)"

# ╔═╡ b379b723-d3e4-45d3-b5e8-9958c6f5dd9b
md"## Reset"

# ╔═╡ d55c4b86-88f9-423c-8def-3c4de83ad3bb
md"""
Si vous avez sans faire exprès commit sur `main`, faites
```sh
$ git switch -c new_branch
$ git switch main
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
md"## Stash changes"

# ╔═╡ b58456cf-b417-4f40-a854-c04b6db744db
md"""
On est parfois dans la mauvaise branche et on veut appliquer nos changement dans une autre ou nouvelle branche.
On doit alors faire `git switch` mais `git` ne voudra pas si on a changé des fichiers qui différent (même si c'est à des lignes différentes).
On `stash` alors les changements.
Conceptuellement la même chose que `cherry-pick` 🚁 mais sans faire de commit.
"""

# ╔═╡ 00837930-704a-44eb-84c2-bece8894ef0f
md"""
```
$ git stash
$ git switch main
$ git stash apply
```
"""

# ╔═╡ 27e4de24-a81c-4437-a566-05da736f6e9d
md"# Markdown"

# ╔═╡ 50acf567-a72a-4ada-af79-876b782e85c4
md"""
* Lors du peer review, l'utilisation correcte du Markdown sera prise en compte dans la cotation
* Markdown est un *markup language* (comme LaTeX ou HTML) [inventé par John Grubber en 2004](https://daringfireball.net/projects/markdown/)
* Il a ajourd'hui différentes variantes qui l'étende ou interprète différemment des ambiguité dans sa définition de 2004.
* En 2014, [CommonMark](https://commonmark.org/) est publié pour but de standardiser ces extensions et clarifier les ambiguités.
"""

# ╔═╡ 006977f7-c420-4562-b193-7fa7053c3397
md"## Example avec CommonMark"

# ╔═╡ 93b2e538-939a-4ed6-a039-cd749110987e
cm"""
| Aligne à gauche | Aligne à droite | Aligne au centre  |
|:---------- | ----------:|:------------:|
| Row `1`    | Column `2` |      [^1]    |
| *Row* 2    | **Row** 2  | Column ``|`` |

[^1]: Footnote
"""

# ╔═╡ 1b304f84-b649-45a0-860f-eb6a573df510
md"## Syntax highlighting"

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
md"## Permalink"

# ╔═╡ 3cbfb4f4-28a2-4c72-83ae-7f9c6233e8b6
md"""Un lien vers des lignes spécifiques du code doivent être liées à un commit spécifique car une branche évolue avec le temps. [GitHub affiche un code snippet](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-a-permanent-link-to-a-code-snippet) comme ci-dessous [mais pas encore sur GitLab](https://stackoverflow.com/questions/76063040/how-do-i-link-or-add-a-reference-to-specific-lines-of-code-of-a-file-in-the-repo)"""

# ╔═╡ f29ce947-3563-4582-a40f-18eaab01dd18
import HTTP

# ╔═╡ a150428a-f03a-47ce-ba03-cd3b855ca137
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

# ╔═╡ 0a31d929-9d65-417b-b6b2-e432a1f01ffe
md"""
* [Tutoriel $(img("https://upload.wikimedia.org/wikipedia/commons/e/e0/Git-logo.svg", :height => "15pt")) disponible dans le syllabus](https://lepl1503.info.ucl.ac.be/syllabus/outils/git.html)
* [Learn Git Branching interactivey](https://learngitbranching.js.org/) $(img("https://learngitbranching.js.org/assets/favicon.ico", :height => "15pt"))
"""

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

# ╔═╡ 76e9e011-6665-4688-b3d6-c64b0d06c222
img("https://docs.github.com/assets/cb-68457/mw-1440/images/help/repository/rendered-code-snippet.webp")

# ╔═╡ 11a1f2b2-dcf2-4750-b86f-5d6b4f5831b5
function CenteredBoundedBox(str)
    xbearing, ybearing, width, height, xadvance, yadvance =
        Luxor.textextents(str)
    lcorner = Luxor.Point(xbearing - width/2, ybearing + height/2)
    ocorner = Luxor.Point(lcorner.x + width, lcorner.y + height)
    return Luxor.BoundingBox(lcorner, ocorner)
end

# ╔═╡ b04dfc49-b96d-4cbf-a7ef-735996eec8b8
function boxed(str::AbstractString, p; hue = "lightgrey")
    Luxor.gsave()
    Luxor.translate(p)
    Luxor.sethue(hue)
    Luxor.poly(CenteredBoundedBox(str) + 5, action = :stroke, close=true)
    Luxor.sethue("black")
    Luxor.text(str, Luxor.Point(0, 0); halign = :center, valign = :middle)
    #settext("<span font='26'>$str</span>", halign="center", markup=true)
    Luxor.origin()
    Luxor.grestore() # strokecolor
end

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

# ╔═╡ 38669159-401b-40e8-82b3-24ecabced3ca
# No need to go beyond `620` because pythontutor will just add an internal slider an not show full code
function tutor(code::Code; width = 800, height = min(620, 260 + 20 * countlines(IOBuffer(code.code))), frameborder = 0, curInstr = 0)
	esc_code = HTTP.escapeuri(code.code)
    src = "https://pythontutor.com/iframe-embed.html#code=$esc_code&cumulative=false&py=$(source_extension(code))&curInstr=$curInstr"
	return HTML("""<iframe width="$width" height="$height" frameborder="$frameborder" src="$src"></iframe>""")
end

# ╔═╡ 2dc7800b-f584-4ddc-9f19-486ca0ce21f5
tutor(c"""
int factorial(int n)
{
    if (n <= 1)
        return 1;
    else
        return n * factorial(n - 1);
}

int main()
{
    factorial(10);
}
""")

# ╔═╡ 90ca03b6-331f-401b-bacc-2999e184055b
tutor(c"""
int fibonacci(int n)
{
    if (n <= 2)
        return 1;
    else
        return fibonacci(n - 1) + fibonacci(n - 2);
}

int main()
{
    fibonacci(6);
}
""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
Luxor = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SimpleClang = "d80a2e99-53a4-4f81-9fa2-fda2140d535e"

[compat]
CommonMark = "~0.10.3"
HTTP = "~1.10.19"
HypertextLiteral = "~1.0.0"
Luxor = "~4.4.1"
PlutoTeachingTools = "~0.4.7"
PlutoUI = "~0.7.79"
SimpleClang = "~0.1.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.5"
manifest_format = "2.0"
project_hash = "181c1d445014f30b0850c5c3b69cdd1a2ec88ce3"

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

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.Cairo]]
deps = ["Cairo_jll", "Colors", "Glib_jll", "Graphics", "Libdl", "Pango_jll"]
git-tree-sha1 = "71aa551c5c33f1a4415867fe06b7844faadb0ae9"
uuid = "159f3aea-2a34-519c-b102-8c37f9878175"
version = "1.1.1"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a21c5464519504e41e0cbc91f0188e8ca23d7440"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.5+1"

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

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "37ea44092930b1811e666c3bc38065d7d87fcc74"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.1"

[[deps.CommonMark]]
deps = ["PrecompileTools"]
git-tree-sha1 = "65ea18ada9814f09c5013924c42fe8b53d6ee467"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.10.3"

    [deps.CommonMark.extensions]
    CommonMarkMarkdownASTExt = "MarkdownAST"
    CommonMarkMarkdownExt = "Markdown"

    [deps.CommonMark.weakdeps]
    Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
    MarkdownAST = "d0879d2d-cac2-40c8-9cee-1863dc0c7391"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "21d088c496ea22914fe80906eb5bce65755e5ec8"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.1"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "e357641bb3e0638d353c4b29ea0e40ea644066a6"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.3"

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

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "27af30de8b5445644e8ffe3bcb0d72049c089cf1"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.7.3+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "95ecf07c2eea562b5adbd0696af6db62c0f52560"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.5"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "01ba9d15e9eae375dc1eb9589df76b3572acd3f2"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "8.0.1+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "6522cfb3b8fe97bec632252263057996cbd3de20"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.18.0"
weakdeps = ["HTTP"]

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "f85dac9a96a01087df6e3a749840015a0ca3817d"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.17.1+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "2c5512e11c791d1baed2049c5652441b28fc6a31"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "7a214fdac5ed5f59a22c2d9a885a16da1c74bbc7"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.17+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "24f6def62397474a297bfcec22384101609142ed"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.86.3+0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "a641238db938fff9b2f60d08ed9030387daf428c"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.3"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a6dbda1fd736d60cc477d99f2e7a042acfa46e8"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.15+0"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5e6fe50ae7f23d171f44e311c2960294aaa0beb5"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.19"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "f923f9a774fcf3f5cb761bfa43aeadd689714813"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.1+0"

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

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aaafe88dccbd957a8d82f7d05be9b69172e0cee3"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.0.1+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eb62a3deb62fc6d8822c0c4bef73e4412419c5d8"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.8+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

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

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "97bbca976196f2a1eb9607131cb108c69ec3f8a6"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.41.3+0"

[[deps.Librsvg_jll]]
deps = ["Artifacts", "Cairo_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pango_jll", "XML2_jll", "gdk_pixbuf_jll"]
git-tree-sha1 = "e6ab5dda9916d7041356371c53cdc00b39841c31"
uuid = "925c91fb-5dd6-59dd-8e8c-345e74382d89"
version = "2.54.7+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "f04133fe05eff1667d2054c53d59f9122383fe05"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.2+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d0205286d9eceadc518742860bf23f703779a3d6"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.41.3+0"

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

[[deps.Luxor]]
deps = ["Base64", "Cairo", "Colors", "DataStructures", "Dates", "FFMPEG", "FileIO", "PolygonAlgorithms", "PrecompileTools", "Random", "Rsvg"]
git-tree-sha1 = "e820980fe5635ec27cc96d2cd407f16e72169866"
uuid = "ae8d54c2-7ccd-5906-9d76-62fc9837b5bc"
version = "4.4.1"

    [deps.Luxor.extensions]
    LuxorExtLatex = ["LaTeXStrings", "MathTeXEngine"]
    LuxorExtTypstry = ["Typstry"]

    [deps.Luxor.weakdeps]
    LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
    MathTeXEngine = "0a4f8689-d25c-4efe-a92b-7142dfc1aa53"
    Typstry = "f0ed7684-a786-439e-b1e3-3b82803b501e"

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
git-tree-sha1 = "8785729fa736197687541f7053f6d8ab7fc44f92"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.10"

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

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "9b8215b1ee9e78a293f99797cd31375471b2bcae"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.3"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "NetworkOptions", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "1d1aaa7d449b58415f97d2839c318b70ffb525a0"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.6.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e2bb57a313a74b8104064b7efd01406c0a50d2ff"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.6.1+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.44.0+1"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "0662b083e11420952f2e62e17eddae7fc07d5997"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.57.0+0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

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

[[deps.PolygonAlgorithms]]
git-tree-sha1 = "5608c3c5b78134cd5da29571ef3736077408031f"
uuid = "32a0d02f-32d9-4438-b5ed-3a2932b48f96"
version = "0.3.5"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "07a921781cab75691315adc645096ed5e370cb77"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.3"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "8b770b60760d4451834fe79dd483e318eee709c4"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.2"

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

[[deps.Rsvg]]
deps = ["Cairo", "Glib_jll", "Librsvg_jll"]
git-tree-sha1 = "e53dad0507631c0b8d5d946d93458cbabd0f05d7"
uuid = "c4c386cf-5103-5370-be45-f3a111cca3b8"
version = "1.1.0"

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

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "80d3930c6347cfce7ccf96bd3bafdf079d9c0390"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.9+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "9cce64c0fdd1960b597ba7ecda2950b5ed957438"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.2+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "808090ede1d41644447dd5cbafced4731c56bd2f"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.13+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "1a4a26870bf1e5d26cd585e38038d399d7e65706"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.8+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "7ed9347888fac59a618302ee38216dd0379c480d"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.12+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.gdk_pixbuf_jll]]
deps = ["Artifacts", "Glib_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Xorg_libX11_jll", "libpng_jll"]
git-tree-sha1 = "895f21b699121d1a57ecac57e65a852caf569254"
uuid = "da03df04-f53b-5353-a52f-6a8b0620ced0"
version = "2.42.13+0"

[[deps.libLLVM_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8f36deef-c2a5-5394-99ed-8e07531fb29a"
version = "18.1.7+5"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "371cc681c00a3ccc3fbc5c0fb91f58ba9bec1ecf"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.13.1+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "125eedcb0a4a0bba65b657251ce1d27c8714e9d6"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.4+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e015f211ebb898c8180887012b938f3851e719ac"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.55+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"
"""

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
# ╟─50acf567-a72a-4ada-af79-876b782e85c4
# ╟─006977f7-c420-4562-b193-7fa7053c3397
# ╟─93b2e538-939a-4ed6-a039-cd749110987e
# ╟─1b304f84-b649-45a0-860f-eb6a573df510
# ╠═04b7e3c9-0962-4146-bcc3-0274efc33644
# ╠═33967cf6-dc82-4bf5-9239-e0d5a12b1397
# ╟─d7102814-0102-43fb-b9ee-f78da0b2febe
# ╟─3cbfb4f4-28a2-4c72-83ae-7f9c6233e8b6
# ╟─76e9e011-6665-4688-b3d6-c64b0d06c222
# ╠═62ea7632-cfe1-4d0a-90db-d7d3eee27763
# ╠═f29ce947-3563-4582-a40f-18eaab01dd18
# ╟─a150428a-f03a-47ce-ba03-cd3b855ca137
# ╟─11a1f2b2-dcf2-4750-b86f-5d6b4f5831b5
# ╟─b04dfc49-b96d-4cbf-a7ef-735996eec8b8
# ╟─38669159-401b-40e8-82b3-24ecabced3ca
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
