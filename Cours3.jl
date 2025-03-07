### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 3467ae64-1162-40c3-ae82-fa605e1325df
import Pkg

# ╔═╡ 76aa8111-1ecd-44c8-8ee2-6d74d82d38c5
Pkg.activate(".")

# ╔═╡ 62ea7632-cfe1-4d0a-90db-d7d3eee27763
using PlutoUI, PlutoUI.ExperimentalLayout, MyUtils, PlutoTeachingTools, CommonMark

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

# ╔═╡ 0746db48-8e50-4050-8f88-c7a90fcd8b55
img("https://git-scm.com/book/en/v2/images/basic-branching-4.png")

# ╔═╡ e4fa4941-25bb-4191-a7df-700852e7b5bc
frametitle("Une des deux est mergée en premier")

# ╔═╡ 566046e2-c690-4955-ae63-44a83cfe3234
img("https://git-scm.com/book/en/v2/images/basic-branching-5.png")

# ╔═╡ 373dc385-d77e-495a-9f1f-f9424a8f27bb
frametitle("On pourrait continue à commit sur iss53")

# ╔═╡ 11177e51-65d5-4450-93d8-1c90e4e4c40c
md"""```sh
$ git checkout iss53
$ git commit -am "C5"
```"""

# ╔═╡ c7fd84df-fd14-41dc-86c4-a2b205d9be56
img("https://git-scm.com/book/en/v2/images/basic-branching-6.png")

# ╔═╡ b05cbd8f-8e3e-4627-872b-dc6c53bb7014
Foldable(md"Vaut-il mieux continuer à commit sur l'autre branche comme si de rien n'était ?", md"Non, Il vaut mieux se synchroniser avec master le plus vite possible car tout nos nouveaux commits sont des sources additionnelles de conflits")

# ╔═╡ 84b048b6-6b9e-40e6-8865-9999d6000a8a
frametitle("Merge de deux branches")

# ╔═╡ 8edebbe3-0640-42db-a3c7-b29c8eb81dfc
img("https://git-scm.com/book/en/v2/images/basic-merging-1.png")

# ╔═╡ 82544684-0c33-4eb9-bbae-8e0398b951e7
frametitle("Si iss53 est finie, on merge dans master")

# ╔═╡ 4edef8de-5ac2-42ab-b478-8167f269d5f7
md"```sh
$ git checkout master
$ git merge iss53
```"

# ╔═╡ 95424c24-0f7d-4a72-9270-2c70575436a1
img("https://git-scm.com/book/en/v2/images/basic-merging-2.png")

# ╔═╡ 1f90facc-e2e3-4c19-8975-4a825a920e86
frametitle("Si iss53 n'est pas finie, on merge master dans iss53")

# ╔═╡ d6259127-0f8f-4da5-bed4-c3e8f6e99e54
md"```sh
$ git checkout iss53
$ git merge master
```"

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
# ╟─0746db48-8e50-4050-8f88-c7a90fcd8b55
# ╟─e4fa4941-25bb-4191-a7df-700852e7b5bc
# ╟─566046e2-c690-4955-ae63-44a83cfe3234
# ╟─373dc385-d77e-495a-9f1f-f9424a8f27bb
# ╟─11177e51-65d5-4450-93d8-1c90e4e4c40c
# ╟─c7fd84df-fd14-41dc-86c4-a2b205d9be56
# ╟─b05cbd8f-8e3e-4627-872b-dc6c53bb7014
# ╟─84b048b6-6b9e-40e6-8865-9999d6000a8a
# ╟─8edebbe3-0640-42db-a3c7-b29c8eb81dfc
# ╟─82544684-0c33-4eb9-bbae-8e0398b951e7
# ╟─4edef8de-5ac2-42ab-b478-8167f269d5f7
# ╟─95424c24-0f7d-4a72-9270-2c70575436a1
# ╟─1f90facc-e2e3-4c19-8975-4a825a920e86
# ╟─d6259127-0f8f-4da5-bed4-c3e8f6e99e54
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
