### A Pluto.jl notebook ###
# v0.20.23

using Markdown
using InteractiveUtils

# ╔═╡ c212b18e-c7ab-46da-9492-f8ba6e4a08bd
using Luxor, PlutoUI, PlutoUI.ExperimentalLayout, SimpleClang, HypertextLiteral, PlutoTeachingTools, CommonMark

# ╔═╡ b150ab7f-d9b0-448b-920e-572e27c5b48b
@htl("""
<p align=center style=\"font-size: 40px;\">LEPL1503/LSINC1503 - Cours 4</p><p align=right><i>O. Bonaventure, B. Legat, M. Baerts</i></p>
$(PlutoTeachingTools.ChooseDisplayMode())
$(PlutoUI.TableOfContents(depth=1))
""")

# ╔═╡ 9c2a75a0-cfb4-4e06-ae51-a1228269fb08
md"# Ordinateurs actuels"

# ╔═╡ 523984b7-91df-41fe-a2b0-bf90539bd53e
md"## Votre Raspberry pi 3B+"

# ╔═╡ 4ea7323d-1f71-41ed-9da8-a974522168fe
md"## Caractéristiques de votre Raspberry pi 3B+"

# ╔═╡ af7b9efc-ba32-4b03-add1-a8f190c8c288
md"## Complexité des processeurs"

# ╔═╡ d6f888cc-582b-4b24-88a6-94e1ca2e9bd0
md"## Caractéristiques des processeurs"

# ╔═╡ 65019147-232a-4162-b747-6ae08f8928fa
md"## L'accès à la mémoire"

# ╔═╡ cb70d153-f0a0-44eb-b315-36283d701163
md"## Les mémoires cache"

# ╔═╡ 4a3420e3-0de6-4015-a97b-f9fdc87eaa9c
md"## Exemple : multiplication de matrices"

# ╔═╡ 1c4fba05-2124-40d5-af13-8812e8369c01
hbox([
	c"""
	void multiply_matrices(int mat1[N][N], int mat2[N][N], int res[N][N])
	{
	    int i, j, k;
	    for (i = 0; i < N; i++) {  // 'i' first
	        for (j = 0; j < N; j++) {
	            res[i][j] = 0;
	            for (k = 0; k < N; k++)
	                res[i][j] += mat1[i][k] * mat2[k][j];
	        }
	    }
	}
	""",
	c"""
	void multiply_matrices2(int mat1[N][N], int mat2[N][N], int res[N][N])
	{
	    int i, j, k;
	    for (j = 0; j < N; j++) {  // 'j' first
	        for (i = 0; i < N; i++) {
	            res[i][j] = 0;
	            for (k = 0; k < N; k++)
	                res[i][j] += mat1[i][k] * mat2[k][j];
	        }
	    }
	}
	"""
])

# ╔═╡ b5012813-42d2-40f3-a8af-96fc9c60be91
md"# Fichiers"

# ╔═╡ cd7b42ef-10c0-41df-a434-ed25efa09d6e
md"## Les appels system"

# ╔═╡ c31eb3a1-2c0e-4360-86eb-de982ba45c03
c"""
// Ouvre le fichier et retourne un file descriptor, en cas d'erreur return -1
int open(const char *pathname, int flags, mode_t mode);

// Toutes les fonctions suivantes utilisent le file descriptor retourné par open

// Permet de lire dans un fichier, en cas d'erreur return -1
ssize_t read(int fd, void buf[.count], size_t count);

// Permet d'écrire dans un fichier, en cas d'erreur return -1
ssize_t write(int fd, const void buf[.count], size_t count);

// Permet de se déplacer dans un fichier, en cas d'erreur return -1
off_t lseek(int fd, off_t offset, int whence);
"""

# ╔═╡ 7a20ee7e-8a2b-4e32-bc7b-fcdbdc981bed
md"## Appel system Open"

# ╔═╡ dd7ffd0c-e2a1-4e37-bc49-3dd2c23aa0dd
md"""
```c
int open(const char *pathname, int flags, mode_t mode);
```

Descriptions des arguments :
1. Le chemin vers le fichier
2. Le drapeau qui designe le mode d'accès du fichier
```
    - O_RDONLY        open for reading only
    - O_WRONLY        open for writing only
    - O_RDWR          open for reading and writing
    - O_APPEND        append on each write
    - O_CREAT         create file if it does not exist
    - O_TRUNC         truncate size to 0
```
3. Le mode qui représente les permissions (uniquement pour la création de fichier)
```
    - S_IRWXU  00700 user (file owner) has read, write, and execute permission
    - S_IRUSR  00400 user has read permission
    - S_IWUSR  00200 user has write permission
    - S_IRWXG  00070 group has read, write, and execute permission
    - S_IRGRP  00040 group has read permission
    - S_IWOTH  00002 others have write permission
```
"""

# ╔═╡ f00ce4dc-7031-428d-a4ea-0c4138eee251
md"## Detection d'erreurs lors des appels system"

# ╔═╡ 7ad1992d-9cc0-4fbe-9b10-4b7d0c9bca47
md"""
**Un appel système peut échouer pour diverses raisons, il faut donc vérifier le retour de la fonction appelée**
  - La variable globale *errno* mise à jour par **Unix** vous donne un code qui vous informe sur la nature de l'échec de l'appel de la fonction.
  - Cette variable se met à jour seulement en cas d'erreur et n'est pas re-initialisée
  - La fonction `void perror(const char *s)` permet d'interpreter l'erreur courante de errno
  - La fonction `char *strerror(int errnum)` permet d'nterpreter l'erreur courante de errno
"""

# ╔═╡ cfe36d4f-f80a-4ed9-9692-c283dfa15ccd
c"""
int fd = open(filename, flags, mode);
if (fd == -1) {
    if (errno == ENOENT) {
        // No such file or directory
    } else if (errno == EACCES)
        // Permission denied
    } else {
        perror('open');
    }
}
"""

# ╔═╡ 15cf3ef6-1026-4c18-928c-b2fe2618621e
md"## Les descripteurs de fichiers"

# ╔═╡ ec48c057-5561-4bff-953f-c9f3654855cb
md"""
- Il s'agit d'un ID qui permet d'identifier les fichiers ouverts par un processus
- La liste de ces descripteurs de fichiers sont maintenus par le Noyau pour chaque processus

| File Descriptor | Flux       |
|-----------------|------------|
| 0               | Stdin      |
| 1               | Stdout     |
| 2               | Stderr     |
| 3               | First File |
- Le file descriptor est le premier entier disponible dans la liste sinon on en crée un nouveau
"""

# ╔═╡ b6e44edd-c618-408d-818c-bbc45e019c72
c"""
#include <fcntl.h> // pour open
#include <stdio.h>

int main(int argc, char **argv) {
	int fd1, fd2, fd3, err;

	fd1 = open("/dev/zero",O_RDONLY);
	printf("Filedescriptor : %d\n",fd1);

	fd2 = open("/dev/zero",O_RDONLY);
	printf("Filedescriptor : %d\n",fd2);

	err = close(fd1);

	fd3 = open("/dev/zero",O_RDONLY);
	printf("Filedescriptor : %d\n",fd3);
}
"""

# ╔═╡ 9695ec17-accc-48e9-9ed6-d8884887eb55
md"## La gestion de la mémoire dans le passé"

# ╔═╡ ce754992-1197-4565-87f6-a69faa9c9e20
md"## La gestion de la mémoire de nos jours"

# ╔═╡ 21e3e276-8d04-431d-892b-94f3df45e765
md"## Le mappage en mémoire"

# ╔═╡ 0f1dbd64-a0a3-4410-b886-6849cf88b991
md"## Appel système mmap et munmap"

# ╔═╡ cdf8d4a6-4b07-48da-b4ee-0ed99b314450
md"""
```c
void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
```

Descriptions des arguments :
1. L'addresse où le le fichier a été mappé. Quand il est à `NULL`, le noyau choisit l'addresse
2. La taille du fichier en octets
3. La protection appliquée à l'emplacement en mémoire
```
    - PROT_EXEC  Pages may be executed.
    - PROT_READ  Pages may be read.
    - PROT_WRITE Pages may be written.
    - PROT_NONE  Pages may not be accessed.
```
4. Les drapeaux qui determine si les mise à jour du mapping seront exclusive ou non aux processus.
```
    - MAP_SHARED  Share this mapping.
    - MAP_PRIVATE Create a private copy-on-write mapping.
```
5. Le file descriptor obtenu avec `open`
6. offset permet de spécifier où il faut commencer à lire
"""

# ╔═╡ 2d31195c-d525-4b75-b448-eb3ba58486fd
c"""
int munmap(void addr, size_t length);
// Il supprime le mapping de la mémoire
"""

# ╔═╡ 9b9560e8-7b4b-43c1-9be7-079e1928567c
md"# Threads"

# ╔═╡ 6d232c36-68cc-42e4-b24f-3f8e28bbc21d
md"## Les pointeurs vers les fonctions"

# ╔═╡ ed08082d-0e3c-4919-b563-4e6b92cb1e01
md"""
```c
#include <stdlib.h>

void qsort(void *base, size_t nmemb, size_t size,
           int(*compar)(const void *, const void *));
```

DESCRIPTION:
- The `qsort()` function sorts an array with `nmemb` elements of size `size`. The `base` argument points to the start of the array.
- The contents of the array are sorted in ascending order according to a comparison function pointed to by `compar`, which is called with two arguments that point to the objects being compared.
- The comparison function must return an integer less than, equal to, or greater than zero if the first argument is considered to be respectively less than, equal to, or greater than the second. If two members compare as equal, their order in the sorted array is undefined.
"""

# ╔═╡ d3ace570-38c6-47a3-a456-70c051373289
c"""
// qsort(array, SIZE, sizeof(double), cmp);

int cmp(const void *ptr1, const void *ptr2) {
  const double *a = ptr1;
  const double *b = ptr2;

  if (*a == *b)
      return 0;
  else
    if (*a < *b)
      return -1;
    else
      return +1;
}
"""

# ╔═╡ 698ebf5d-2319-43be-bef2-138e64e0467b
md"## Partage du CPU"

# ╔═╡ 57b0ebb3-5fe4-498b-96e5-b870f23f5823
md"## Threads"

# ╔═╡ 470620b4-d817-43bb-ad13-24979b2cfc43
md"""
- De nombreuses applications font plusieurs actions simultannées
- un outil graphique avec fenêtres ouvertes
- un make compilant plusieurs fichiers C
- Il est naturel de séparer ces activités, mais créer un processus pour chacune est coûteux et complique les interactions entre sous-processus
"""

# ╔═╡ b0049332-4936-4175-8095-ce4f17885b1a
md"## Les appels system Threads"

# ╔═╡ 266e2b4b-2c31-4684-abff-18441b2906c8
c"""
// Cette fonction permet de créer le thread
int pthread_create(pthread_t *restrict thread,
                   const pthread_attr_t *restrict attr,
                   typeof(void *(void *)) *start_routine,
                   void *restrict arg);

// Cette fonction permet de terminer le thread et de retourner une valeur
void pthread_exit(void *retval);

// Cette fonction demande d'attendre que le thread se finisse
int pthread_join(pthread_t thread, void **retval);
"""

# ╔═╡ bf3106b8-337c-4b7e-98fd-1468ae5efeb1
md"## Appel system pthread_create"

# ╔═╡ ade1bc91-d0e8-470f-ab87-9d876b0c46cb
md"""
```c
int pthread_create(pthread_t *restrict thread,
                   const pthread_attr_t *restrict attr,
                   typeof(void *(void *)) *start_routine,
                   void *restrict arg);
```
Descriptions des arguments :
1. L'ID du thread
2. Les attributs du thread, il peut être NULL
3. Le foncteur qui va être exécuté
4. L'argument du foncteur
"""

# ╔═╡ 23f5128b-3f6e-42a1-b807-25aad7a442ee
c"""
void *f1(void *param) { }
void  f2(void *param) { }
void *f3(void param) { }
void  f4() { }
"""

# ╔═╡ e30651f2-2eed-49c8-8f8b-3823ca349f15
c"""
#include <pthread.h>
#include <stdio.h>
int global = 0;
void *thread_first(void * param) {
	global++;
	return(NULL); // Une facon de terminer un thread
}
void *thread_second(void * param) {
	global++;
	pthread_exit(NULL); // Une autre facon de terminer un thread
}

int main(int argc, char *argv[])  {
	pthread_t first, second;
	int err;

	err = pthread_create(&first, NULL, &thread_first, NULL);
	if (err != 0)
		perror("pthread_create");

	err = pthread_create(&second, NULL, &thread_second, NULL);

	for (int i = 0; i < 1000000000; i++) { /*...*/ }

	err = pthread_join(first, NULL);
	if (err != 0)
		perror("pthread_join");

    err = pthread_join(second, NULL);
	if (err != 0)
		perror("pthread_join");
}
"""

# ╔═╡ 26a1ee91-1710-4940-a66d-825dd892bcba
md"## "

# ╔═╡ c6d9420b-8ba9-40df-b649-1a78653acf3e
c"""
pthread_t threads[NTHREADS];
int arg[NTHREADS];
void *neg(void * param) {
	int *l, r;
	l = (int *)param;
	r = -*l;
	return ((void *) &r);
}
int main(int argc, char *argv[])  {
	int err;
	for (long i = 0; i < NTHREADS; i++) {
		arg[i] = i;
		err = pthread_create(&(threads[i]), NULL, &neg, (void *)&(arg[i]));
		if (err != 0)
		    error(err, "pthread_create");

		int *r;
		err = pthread_join(threads[i], (void **)&r);
		if (err != 0)
		    error(err, "pthread_join");

        printf("Resultat[%d]=%d\n", i, *r);
	}
}
"""

# ╔═╡ 72986e7d-37c8-4d0c-9624-24336a08fc20
c"""
pthread_t t1;

void *f(void *param) { }
void launch(void) {
	pthread_t t2;
	pthread_t *t3 = (pthread_t *)malloc(sizeof(pthread_t));

	int err = pthread_create(&t1, NULL, &f, v);
	err = pthread_create(t1, NULL, &f, v);
	err = pthread_create(&t2, NULL, &f, v);
	err = pthread_create(t3, NULL, &f, v);
}
"""

# ╔═╡ de619cdb-e82c-4899-931e-bd79e4a115a3
c"""
int fd1;

void *f1(void *param) {
	char buf;
	int err = read(fd1, &buf, sizeof(char));
}

int main(...) {
    fd1 = open("t1.dat", O_RDWR);
    int err = pthread_create(&(t1), NULL, &f1, NULL);
"""

# ╔═╡ 3b4da661-112b-4c07-b1fa-9b48f8b88c55
md"## Passer plusieurs réels à un thread"

# ╔═╡ f69608cd-b72b-4de7-b723-f3a3c195efed
c"""
pthread_t pt;
double tab[2] = {2.0, 3.0}; // Utiliser un tableau

void *f3(void *param) {
	printf("f3\n");
	double *p = (double *)param;
	printf("%f %f\n", *p, *p+1);
	return NULL;
}

int main(int argc, char **argv) {
	int err = pthread_create(&pt, NULL, &f3, (void *)tab);
"""

# ╔═╡ 3d63c085-d739-4553-9e8d-fdc21a529954
c"""
pthread_t pt;
struct pair { // Utiliser une structure
	double x;
	double y;
};

void *f2(void *param) {
	struct pair *p = (struct pair *)param;
	printf("%f %f\n", p->x, p->y);
	return NULL;
}

int main(int argc, char **argv) {
	struct pair * a = (struct pair *)malloc(sizeof(struct pair));
	a->x = 2.3;
	a->y = 4.5;
	int err = pthread_create(&pt, NULL, &f2, (void *)a);
"""

# ╔═╡ 37eb768e-d085-4dc6-87f5-8ad91227acb6
md"## Attention à `printf()`"

# ╔═╡ a594301e-c385-4cf6-b80f-af3b6c8f2ffb
md"""
Méfiez-vous !
- Tous les threads partagent `stdout`, mais `printf` utilise un buffer qui n'envoie des données sur `stdout` que lorsqu'il y en a suffisamment
- `man fflush`
"""

# ╔═╡ 89e02c70-2a4f-4b99-b82d-9cfda85267b4
md"## Les états d'un thread"

# ╔═╡ f8cb54d2-2b46-4839-8f4f-cff9dffe5972
md"# Mutex et sémaphores"

# ╔═╡ 104ce982-0363-4e52-9663-9df6e9f7c83d
md"## Communication entre threads"

# ╔═╡ 29933156-5532-43cf-8577-ecbac51b0bd3
md"## Les dangers avec les threads"

# ╔═╡ 638df949-1488-456a-a91d-afc2e34c2549
md"""
Violation d’exclusion mutuelle
- Deux threads modifient la même zone mémoire sans coordination
"""

# ╔═╡ 0c0106db-8117-4d18-82e2-effde1379a6b
hbox([
	c"""long global = 0;
int increment(int i) {
    return i+1;
}
void *func(void *param) {
    for(int j = 0; j < 1000000; j++) {
        global = increment(global);
    }
    return(NULL);
} """,
	md"""
    $ for i in {1..5}; do ./pthread-test; done
    global: 3408577
    global: 3175353
    global: 1994419
    global: 3051040
    global: 2118713
"""
])

# ╔═╡ 3b08b786-abb9-404d-8c76-4db9e6c10915
md"## Problème de l'exclusion mutuelle: les sections critiques"

# ╔═╡ 464190c6-a826-4c61-ab4f-0b936816d0c2
md"""
Conditions à remplir par une solution :

- Deux threads ne peuvent y être en même temps
- Un thread se trouvant hors de sa section critique ne peut pas bloquer un autre thread
- Un thread ne doit pas attendre indéfiniment le droit d'entrer dans sa section critique
- Aucune hypothèse n'est faite sur la vitesse des threads ou le nombre de CPUs
"""

# ╔═╡ 0b42d8e7-adcf-43ed-bb5f-5f6ffa92a70a
md"## Mutex posix"

# ╔═╡ d246b6fe-977b-4c68-b8b3-807898da6936
md"""
Structure de données spéciale de la librairie threads POSIX associée à une ressource

- libre (unlocked en anglais)
- réservée (locked en anglais)
"""

# ╔═╡ 788ec052-987d-4328-9e53-c030bd3def87
md"## Les opérations sur les mutex"

# ╔═╡ f42ade01-d9b5-4832-b280-f310b89d773c
md"""
3 opérations possibles sur un mutex

1. Initialisation à unlocked
2. lock(m)
3. unlock(m)
"""

# ╔═╡ f700dd17-a1e1-4cf2-a03b-58dbadf6dcb2
c"""
pthread_mutex_lock(…)
pthread_mutex_unlock(…)
pthread_mutex_init(…)
"""

# ╔═╡ f77751d5-065b-48ee-8646-d3e27f642ec7
md"## Le diner des philosophes"

# ╔═╡ 2e673875-f180-4efd-8f63-7496c6e6e22a
md"## Problème avec deux philosophes"

# ╔═╡ b592b2c4-af2b-41a7-8ec4-52b0afd6ff69
md"## Problème avec deux philosophes sans deadlock"

# ╔═╡ 4b482044-dd71-4a22-84d4-9de77d6933b9
md"## Problème avec trois philosophes"

# ╔═╡ e1ff9f23-3480-4bc5-87cc-48e9e5feafa0
md"## Problème avec N philosophes sans deadlock"

# ╔═╡ 3af1f5ab-d7f9-45f8-acce-ab412f72a825
md"## Les sémaphores"

# ╔═╡ aa81dd8f-99ea-47bb-a1dd-cbfb5f466f37
md"""
3 opérations possibles sur un mutex :

1. `Init(s)` A une valeur entière non-négative
2. `Down(s)` parfois appelé `wait(s)` ou `P(s)`
3. `Up(s)` parfois appelé `signal(s)`, `post(s)` ou `V(s)`
"""

# ╔═╡ d717a3c4-6113-46ed-90a8-9bc9f97eaa1b
md"## Appel system pour les semaphores"

# ╔═╡ 413c8ec4-4c87-43b8-9577-2316e8eda546
c"""
// Initialise le nombre de lock
int sem_init(sem_t *sem, int pshared, unsigned int value);

// Decrémente le nombre de lock
int sem_wait(sem_t *sem);

// Decrémente le nombre de lock
int sem_trywait(sem_t *sem);

// Incrémente le nombre de lock
int sem_post(sem_t *sem);
"""

# ╔═╡ 41f23129-cabe-469d-88cc-793f5108fc6f
md"## Le problème du producteur-consommateur"

# ╔═╡ 00f9a1b9-c649-459c-a6d1-0f0954868f0b
md"## Le problème du producteur-consommateur sans deadlock"

# ╔═╡ b01b54e8-bb01-4998-9542-78a993d41e9d
md"## Le problème du producteur-consommateur"

# ╔═╡ 3aad0ff2-f363-4369-a2f8-4863bdcd2b58
md"# Seconde phase du projet"

# ╔═╡ 331a4763-62b3-4498-a16c-8e726f5ad5e4
md"## Réduire le temps de calcul"

# ╔═╡ 81c6f074-d947-49f7-97aa-85a2ffdc649d
md"""
1. Activer les optimisations du compilateur
    - Multiplication de matrices (1000x1000):
    - `gcc mat.c` -> exécution en 6.3 secondes
    - `gcc –Ofast mat.c` -> exécution en 1.6 secondes
2. Utiliser le plus efficacement les quatre cœurs
    - Réduire les lock/wait au strict nécessaire, sans risquer de violation de section critique
    - Vos threads doivent être les plus indépendants possibles pour être efficaces
    - Vous avez quatre cœurs, ce n’est probablement pas utile de lancer 32 threads, mais peut-être que 6 ou 8 pourraient vous donner de bons résultats
3. Utiliser le plus efficacement la mémoire cache
    - Un code est plus efficace si il utilise travaille sur des zones de mémoire proches
    - Les éléments d’une structure sont stockés à des adresses proches en mémoire
"""

# ╔═╡ 40025646-a342-4573-995e-8192e853f686
md"## Consommation du raspberry pi 3B+"

# ╔═╡ 4a0d76a4-9655-4ec0-930b-3e8776c45c14
md"## Optimisations possibles"

# ╔═╡ 8610572e-e21d-4e24-ada3-8634dcf40d85
md"""
1. Désactiver ce qui est inutile
    - HDMI
    - Réseau ?
    - USB  ?
    - Gardez l’accès à la machine!

2. Ajuster la fréquence du CPU
    - Un CPU moins rapide peut consommer moins d’énergie qu’un CPU rapide

3. Désactiver un ou plusieurs coeurs
[source](https://forums.raspberrypi.com/viewtopic.php?f=29&t=99372)
"""

# ╔═╡ e7d69964-de82-4883-a39c-66f0d606a3e6
md"## Réduire la consommation de mémoire"

# ╔═╡ 836deb6f-e1f3-4766-b5e7-6c5bf788e0f9
md"""
1. Compacter les structures de données utilisées
2. Stocker intelligemment les matrices creuses
    - Si une matrice a 90% de zéros, inutile de stocker tous ces zéros en mémoire
    - Vous devez avoir le même résultat numérique !
3. Réduire la taille du programme
    - Différentes stratégies possibles, optimisation du compilateur, retirer une partie des librairies
    - https://interrupt.memfault.com/blog/code-size-optimization-gcc-flags
4. Allouer la mémoire par blocs plutôt que globalement au début du programme
"""

# ╔═╡ 9b05d5b4-edbf-4702-9b67-ced9130bf36e
import HTTP

# ╔═╡ c642977a-56e8-4a6a-b7b1-27caae9b2427
# No need to go beyond `620` because pythontutor will just add an internal slider an not show full code
function tutor(code::Code; width = 800, height = min(620, 260 + 20 * countlines(IOBuffer(code.code))), frameborder = 0, curInstr = 0)
	esc_code = HTTP.escapeuri(code.code)
    src = "https://pythontutor.com/iframe-embed.html#code=$esc_code&cumulative=false&py=$(source_extension(code))&curInstr=$curInstr"
	return HTML("""<iframe width="$width" height="$height" frameborder="$frameborder" src="$src"></iframe>""")
end

# ╔═╡ dd5a283e-d1c3-42f2-a961-4b078fa0b2af
tutor(c"""
#include <stdio.h>
int mul(int a, int b) {
  return a * b;
}

int sum(int a, int b) {
  return a + b;
}

int main(int argc, char **argv) {
  int (*f) (int, int);
  f = &sum;
  printf("%d, %p\\n", f(4, 5), f);
  f = &mul;
  printf("%d, %p\\n", f(4, 5), f);

  return 0;
}
""")

# ╔═╡ 3012b1bb-43a7-4a8f-b079-402fe5b9ba09
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

# ╔═╡ c51e7692-5526-4396-b847-b240de1acb98
hbox([
	img("raspberry", :width => "600px"),
	md"""
	[Source](https://datasheets.raspberrypi.com/rpi3/raspberry-pi-3-b-plus-product-brief.pdf)
	"""
])

# ╔═╡ ff9764dc-270a-42ec-a698-3d6ff1357cae
hbox([
	md"""
	### 1.4 GHz
	### 2300 MIPS @ 1Ghz
	### Mémoire cache
	- 16 KB de cache d’instruction L1 pour chaque cœur
	- 16 KB de cache de données L1 pour chaque cœur
	- 512KB de cache unifiée L2
	""",
img("raspberry_little", :width => "350px")
])

# ╔═╡ 4516e783-9589-4ab6-a634-c1902551745f
hbox([
	md"""
	## Loi de Moore
	Le nombre de transistors dans un circuit intégré double quasiment tous les 2 ans
	""",
	img("nb_transistors_progress_graph", :width => "450px")

])

# ╔═╡ 32d33645-25f9-4bd5-9ca4-7ba35965935f
hbox([
img("freq_horloge_cpu_graph", :width => "350px"),
img("nb_instructions_per_sec_graph", :width => "380px")
])

# ╔═╡ 2131de3a-1f37-4e9b-8faf-22319384acee
img("memory_access_graph", :width => "650px")

# ╔═╡ 19cb3ad3-962e-48d1-857d-b77f451031ac
hbox([
	img("Mem_hierarchy.svg", :width => "600px"),
	md"""
	[Source](https://fr.wikipedia.org/wiki/Mémoire_cache)
	"""
])

# ╔═╡ 8912c828-f5f8-4b17-8dc3-66a23d2f9d2c
img("ram", :width => "650px")

# ╔═╡ 011aded6-5b13-43b5-861f-c8c8d28ba218
img("mmu", :width => "650px")

# ╔═╡ 45438920-b6f1-4b3f-86f1-0b84f5e4f031
img("map", :width => "650px")

# ╔═╡ cda42027-df22-436f-b1bd-6c854334008e
hbox([
	md"""
	- Plusieurs processus tournent en même temps sur un ordinateur
	- Exécution OS
	- Hardware génère une interruption toutes t millisecondes, horloge appel système
	- Un processus peut être interrompu à tout instant par le kernel !
	""",
	img("partage_cpu", :width => "350px")
])

# ╔═╡ 040ed39b-e547-4bdd-9c1c-0cc83dc9010d
img("thread_state", :width => "650px")

# ╔═╡ d5e2e2ad-d2d7-432c-98a9-bcb71922804b
hbox([
	img("stack_threads", :width => "450px"),
	md"""
	En utilisant les zones mémoires accessibles aux deux threads

	- variables globales
	- heap
	"""
])

# ╔═╡ 2e5622a7-5fe7-4c2e-b33b-a986dba643f6
hbox([
md"""
## Deadlock

L’ensemble du programme est bloqué en attente sur des mutex ou des sémaphore
""",
img("hellgrind", :width => "350px")
])

# ╔═╡ 85b929fa-848d-47d5-9a9f-e458753f7e2d
img("section_critique", :width => "650px")

# ╔═╡ 4faa992d-20d1-4913-b2b9-b23c55044bcf
img("mutex", :width => "650px")

# ╔═╡ 254eb375-41e0-40b2-8fc6-f99491fac0b2
hbox([
md"""
N philosophes doivent se partager un repas dans une salle de méditation

- La table contient N fourchettes et N assiettes
- Chaque philosophe a une place réservée et a besoin pour manger de :
  - La fourchette à sa gauche
  - La fourchette à sa droite
""",
img("diner_philosophes", :width => "400px")
])

# ╔═╡ c9ee0134-5bb1-48b4-80c4-41d40731a4fc
img("2_philosophers_with_deadlock", :width => "650px")

# ╔═╡ da2931d1-42fa-44b6-982b-c70b17fb6b34
img("2_philosophers_without_deadlock", :width => "650px")

# ╔═╡ 11c610ad-7f0c-49ed-b3ed-4c14e9ac57ef
img("3_philosophers_with_deadlock", :width => "650px")

# ╔═╡ 5d876109-50c6-4d48-b602-e9eb7279c3b9
img("n_philosophers_without_deadlock", :width => "650px")

# ╔═╡ 83f6565e-1cf2-403d-989d-7d814b6919c6
img("disktra_semaphore", :width => "650px")

# ╔═╡ 41af2ddc-9c63-4ebb-bc91-5729fb936fe3
img("producteur_consommateur_with_deadlock", :width => "650px")

# ╔═╡ f123391a-4ebc-4994-9f60-da6ddd7772a2
img("producteur_consommateur_without_deadlock.png", :width => "650px")

# ╔═╡ 991ff3ca-5741-42d6-85e0-7f35a2a2479a
img("producteur_consommateur_with_mutex_changed", :width => "650px")

# ╔═╡ d015b48a-391e-40d0-aa84-a3abdc7de99a
hbox([
img("consommation_raspberry_all", :width => "600px"), 
md"""
[source](https://www.raspberrypi-spy.co.uk/2018/11/raspberry-pi-power-consumption-data/)
"""
])

# ╔═╡ c77d9d17-ee6b-4d72-bd56-5a3951439030
hbox([
img("consommation_raspberry_3B_plus", :width => "600px"), 
md"""
[source](https://www.pidramble.com/wiki/benchmarks/power-consumption
)
"""
])

# ╔═╡ 68da5624-1bc8-4527-b4d2-081e33171e0c
hbox([
img("forum_optimizing_raspberry_consumption", :width => "600px"), 
md"""
[source](https://dev.blues.io/blog/tips-tricks-optimizing-raspberry-pi-power/)
"""
])

# ╔═╡ 8036cd43-199b-47c5-b755-ee789e5c8b3d
function wooclap(link)
	logo = HTML("""<img alt="Wooclap Logo" src="https://www.wooclap.com/images/wooclap-logo.svg">""")
	url = "https://app.wooclap.com/$link"
	a = HTML("""<a style="margin-left: 80px;" href="https://app.wooclap.com/$link"><tt>$url</tt></a>""")
	qr = img("https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$url", :height => 50, name = "$link.png")
	return ThreeColumn(logo, a, qr)
end

# ╔═╡ d693a605-4ddb-4434-9040-45f0732fa76e
wooclap("QEAHMX")

# ╔═╡ 66c96c52-82d6-4317-afe4-83cc6f3cab80
wooclap("QEAHMX")

# ╔═╡ 18f5a167-87af-4c53-89b1-18bf7677c241
wooclap("QEAHMX")

# ╔═╡ 86362358-a98f-485d-9783-9825cecf742b
wooclap("QEAHMX")

# ╔═╡ f9d5f5b7-a23b-46c8-bb03-a3d6d89e966a
wooclap("QEAHMX")

# ╔═╡ 7ad4d3f3-ba5c-4e2a-a013-a671c0183de6
wooclap("QEAHMX")

# ╔═╡ 82274b7c-b373-4ac5-81c8-f9c8ebc09c40
wooclap("QEAHMX")

# ╔═╡ 44c17290-1df2-455d-b792-d8db8f975ed5
wooclap("QEAHMX")

# ╔═╡ 248d6a2b-2f98-494a-818b-cec54d05f004
wooclap("QEAHMX")

# ╔═╡ 6bdd938f-3071-4f3a-94f7-a8920aeebff2
wooclap("QEAHMX")

# ╔═╡ 3e5a7c82-cab0-45d1-a726-29a1df84f387
wooclap("QEAHMX")

# ╔═╡ f71d5323-9389-4110-b904-64ab4bc2b875
wooclap("QEAHMX")

# ╔═╡ 22e5cd6d-8793-4f90-8b1d-a0bb3236e4c3
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

# ╔═╡ 832a9a8a-5827-4c11-99bd-be7c648f70f3
qa(md"Un des codes est-il plus rapide ?",
	hbox([
		md"""
		- 6 secondes sans optimisation gcc
		- 2.3 avec optimisation gcc
		""",
		md"""
		- 4.2 secondes sans optimisation gcc
		- 1.63 avec optimisation gcc
		"""
	])
)

# ╔═╡ 4cf4d300-b057-40c0-a667-e737e0d0c2f6
qa(md"Quel 2ème argument pour ouvrir un fichier en écriture, le créer si il n'existe pas et se mettre à la fin pour rajouter du contenu ?",
c"""
O_WRONLY | O_CREAT | 0_APPEND
"""
)

# ╔═╡ e4fea1d9-cbbf-43ba-8942-17bdb90a7f93
qa(md"Quel 3ème argument pour donner les permissions rw-r--r-- à un fichier",
c"""
S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
"""
)

# ╔═╡ d5f119b9-63a2-4c6f-9b3b-a3f9f33f6ec5
qa(md"Laquelle des fonctions suivantes",md"""
	void *f1(void *param) { }
""")

# ╔═╡ 4b2b6b79-21f1-4a2c-be2d-cf02467b6a13
qa(md"Le code est-il correct ?",
c""" int arg[NTHREADS];
pthread_t threads[NTHREADS];
void *neg(void *param) {
       int *l;
       l = (int *)param;
       int *r = (int *)malloc(sizeof(int));
       *r =- *l;
       return ((void *)r);
}

int main (int argc, char *argv[]) {
       int err;
       for (long i = 0; i < NTHREADS; i++) {
               arg[i] = i;
       err = pthread_create(&(threads[i]), NULL, &neg, (void *)&(arg[i]));
       if (err != 0)
               error(err, "pthread_create");

       int *r;
       err = pthread_join(threads[i], (void **)&r);
       printf("Resultat[%d]=%d\n", i, *r);
       free(r);
       if(err != 0)
               error(err, "pthread_join");
       }
"""
)

# ╔═╡ d5965023-ff2f-4147-8441-f9ef1b14528c
qa(md"Lequel ou lesquels des appels a pthread_create est correct",
c"""
pthread_create(&t1, NULL, &f, v);
pthread_create(t3, NULL, &f, v);
"""
)

# ╔═╡ 1f8f5bc3-94e9-4a2a-949f-50470c3801c9
qa(md"Que se passe t-il dans le thread principal et dans le thread créé",
md"Les deux threads ont accès au fichier, mais chacun avec le même pointeur de lecture")

# ╔═╡ 6efa874a-a030-4475-882a-c25b232ca06b
qa(md"""Lesquelles de ces fonctions pourraient bloquer le thread qui les exécute ?""",
c"""
pthread_mutex_lock(…)
""" )

# ╔═╡ 05467069-852c-4548-9a36-352111723ea5
qa(md"""Y a-t-il un deadlock dans le code de ces 2 philosophes ?""",
	md"""
	Oui
	"""
)

# ╔═╡ 5e0b8a1e-1ae9-4ce7-96e0-723e675e228c
qa(md"""Y a-t-il un deadlock dans le code de ces 3 philosophes ?""",
md"""
Oui
"""
)

# ╔═╡ f6a80bd6-77b7-4bac-a317-b49d7238e7e2
qa(md"""Y a-t-il un deadlock dans le code du producteur-consommateurs ?""",
md"""
Oui
"""
)

# ╔═╡ 8161f0c4-726d-416c-be5e-1c16aeaf18af
qa(md"""Y a-t-il un deadlock dans le code du producteur-consommateurs ?""",
md"""
Non
"""
)

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
# ╟─b150ab7f-d9b0-448b-920e-572e27c5b48b
# ╟─9c2a75a0-cfb4-4e06-ae51-a1228269fb08
# ╟─523984b7-91df-41fe-a2b0-bf90539bd53e
# ╟─c51e7692-5526-4396-b847-b240de1acb98
# ╟─4ea7323d-1f71-41ed-9da8-a974522168fe
# ╟─ff9764dc-270a-42ec-a698-3d6ff1357cae
# ╟─af7b9efc-ba32-4b03-add1-a8f190c8c288
# ╟─4516e783-9589-4ab6-a634-c1902551745f
# ╟─d6f888cc-582b-4b24-88a6-94e1ca2e9bd0
# ╟─32d33645-25f9-4bd5-9ca4-7ba35965935f
# ╟─65019147-232a-4162-b747-6ae08f8928fa
# ╟─2131de3a-1f37-4e9b-8faf-22319384acee
# ╟─cb70d153-f0a0-44eb-b315-36283d701163
# ╟─19cb3ad3-962e-48d1-857d-b77f451031ac
# ╟─4a3420e3-0de6-4015-a97b-f9fdc87eaa9c
# ╟─1c4fba05-2124-40d5-af13-8812e8369c01
# ╟─d693a605-4ddb-4434-9040-45f0732fa76e
# ╟─832a9a8a-5827-4c11-99bd-be7c648f70f3
# ╟─b5012813-42d2-40f3-a8af-96fc9c60be91
# ╟─cd7b42ef-10c0-41df-a434-ed25efa09d6e
# ╟─c31eb3a1-2c0e-4360-86eb-de982ba45c03
# ╟─7a20ee7e-8a2b-4e32-bc7b-fcdbdc981bed
# ╟─dd7ffd0c-e2a1-4e37-bc49-3dd2c23aa0dd
# ╟─66c96c52-82d6-4317-afe4-83cc6f3cab80
# ╟─4cf4d300-b057-40c0-a667-e737e0d0c2f6
# ╟─18f5a167-87af-4c53-89b1-18bf7677c241
# ╟─e4fea1d9-cbbf-43ba-8942-17bdb90a7f93
# ╟─f00ce4dc-7031-428d-a4ea-0c4138eee251
# ╟─7ad1992d-9cc0-4fbe-9b10-4b7d0c9bca47
# ╟─cfe36d4f-f80a-4ed9-9692-c283dfa15ccd
# ╟─15cf3ef6-1026-4c18-928c-b2fe2618621e
# ╟─ec48c057-5561-4bff-953f-c9f3654855cb
# ╟─b6e44edd-c618-408d-818c-bbc45e019c72
# ╟─9695ec17-accc-48e9-9ed6-d8884887eb55
# ╟─8912c828-f5f8-4b17-8dc3-66a23d2f9d2c
# ╟─ce754992-1197-4565-87f6-a69faa9c9e20
# ╟─011aded6-5b13-43b5-861f-c8c8d28ba218
# ╟─21e3e276-8d04-431d-892b-94f3df45e765
# ╟─45438920-b6f1-4b3f-86f1-0b84f5e4f031
# ╟─0f1dbd64-a0a3-4410-b886-6849cf88b991
# ╟─cdf8d4a6-4b07-48da-b4ee-0ed99b314450
# ╟─2d31195c-d525-4b75-b448-eb3ba58486fd
# ╟─9b9560e8-7b4b-43c1-9be7-079e1928567c
# ╟─6d232c36-68cc-42e4-b24f-3f8e28bbc21d
# ╟─dd5a283e-d1c3-42f2-a961-4b078fa0b2af
# ╟─ed08082d-0e3c-4919-b563-4e6b92cb1e01
# ╟─d3ace570-38c6-47a3-a456-70c051373289
# ╟─698ebf5d-2319-43be-bef2-138e64e0467b
# ╟─cda42027-df22-436f-b1bd-6c854334008e
# ╟─57b0ebb3-5fe4-498b-96e5-b870f23f5823
# ╟─470620b4-d817-43bb-ad13-24979b2cfc43
# ╟─b0049332-4936-4175-8095-ce4f17885b1a
# ╟─266e2b4b-2c31-4684-abff-18441b2906c8
# ╟─bf3106b8-337c-4b7e-98fd-1468ae5efeb1
# ╟─ade1bc91-d0e8-470f-ab87-9d876b0c46cb
# ╟─23f5128b-3f6e-42a1-b807-25aad7a442ee
# ╟─86362358-a98f-485d-9783-9825cecf742b
# ╟─d5f119b9-63a2-4c6f-9b3b-a3f9f33f6ec5
# ╟─e30651f2-2eed-49c8-8f8b-3823ca349f15
# ╟─26a1ee91-1710-4940-a66d-825dd892bcba
# ╟─c6d9420b-8ba9-40df-b649-1a78653acf3e
# ╟─f9d5f5b7-a23b-46c8-bb03-a3d6d89e966a
# ╟─4b2b6b79-21f1-4a2c-be2d-cf02467b6a13
# ╟─72986e7d-37c8-4d0c-9624-24336a08fc20
# ╟─7ad4d3f3-ba5c-4e2a-a013-a671c0183de6
# ╟─d5965023-ff2f-4147-8441-f9ef1b14528c
# ╟─de619cdb-e82c-4899-931e-bd79e4a115a3
# ╟─82274b7c-b373-4ac5-81c8-f9c8ebc09c40
# ╟─1f8f5bc3-94e9-4a2a-949f-50470c3801c9
# ╟─3b4da661-112b-4c07-b1fa-9b48f8b88c55
# ╟─f69608cd-b72b-4de7-b723-f3a3c195efed
# ╟─3d63c085-d739-4553-9e8d-fdc21a529954
# ╟─37eb768e-d085-4dc6-87f5-8ad91227acb6
# ╟─a594301e-c385-4cf6-b80f-af3b6c8f2ffb
# ╟─89e02c70-2a4f-4b99-b82d-9cfda85267b4
# ╟─040ed39b-e547-4bdd-9c1c-0cc83dc9010d
# ╟─f8cb54d2-2b46-4839-8f4f-cff9dffe5972
# ╟─104ce982-0363-4e52-9663-9df6e9f7c83d
# ╟─d5e2e2ad-d2d7-432c-98a9-bcb71922804b
# ╟─29933156-5532-43cf-8577-ecbac51b0bd3
# ╟─638df949-1488-456a-a91d-afc2e34c2549
# ╟─0c0106db-8117-4d18-82e2-effde1379a6b
# ╟─2e5622a7-5fe7-4c2e-b33b-a986dba643f6
# ╟─3b08b786-abb9-404d-8c76-4db9e6c10915
# ╟─85b929fa-848d-47d5-9a9f-e458753f7e2d
# ╟─464190c6-a826-4c61-ab4f-0b936816d0c2
# ╟─0b42d8e7-adcf-43ed-bb5f-5f6ffa92a70a
# ╟─d246b6fe-977b-4c68-b8b3-807898da6936
# ╟─4faa992d-20d1-4913-b2b9-b23c55044bcf
# ╟─788ec052-987d-4328-9e53-c030bd3def87
# ╟─f42ade01-d9b5-4832-b280-f310b89d773c
# ╟─f700dd17-a1e1-4cf2-a03b-58dbadf6dcb2
# ╟─44c17290-1df2-455d-b792-d8db8f975ed5
# ╟─6efa874a-a030-4475-882a-c25b232ca06b
# ╟─f77751d5-065b-48ee-8646-d3e27f642ec7
# ╟─254eb375-41e0-40b2-8fc6-f99491fac0b2
# ╟─2e673875-f180-4efd-8f63-7496c6e6e22a
# ╟─c9ee0134-5bb1-48b4-80c4-41d40731a4fc
# ╟─248d6a2b-2f98-494a-818b-cec54d05f004
# ╟─05467069-852c-4548-9a36-352111723ea5
# ╟─b592b2c4-af2b-41a7-8ec4-52b0afd6ff69
# ╟─da2931d1-42fa-44b6-982b-c70b17fb6b34
# ╟─4b482044-dd71-4a22-84d4-9de77d6933b9
# ╟─11c610ad-7f0c-49ed-b3ed-4c14e9ac57ef
# ╟─6bdd938f-3071-4f3a-94f7-a8920aeebff2
# ╟─5e0b8a1e-1ae9-4ce7-96e0-723e675e228c
# ╟─e1ff9f23-3480-4bc5-87cc-48e9e5feafa0
# ╟─5d876109-50c6-4d48-b602-e9eb7279c3b9
# ╟─3af1f5ab-d7f9-45f8-acce-ab412f72a825
# ╟─aa81dd8f-99ea-47bb-a1dd-cbfb5f466f37
# ╟─83f6565e-1cf2-403d-989d-7d814b6919c6
# ╟─d717a3c4-6113-46ed-90a8-9bc9f97eaa1b
# ╟─413c8ec4-4c87-43b8-9577-2316e8eda546
# ╟─41f23129-cabe-469d-88cc-793f5108fc6f
# ╟─41af2ddc-9c63-4ebb-bc91-5729fb936fe3
# ╟─3e5a7c82-cab0-45d1-a726-29a1df84f387
# ╟─f6a80bd6-77b7-4bac-a317-b49d7238e7e2
# ╟─00f9a1b9-c649-459c-a6d1-0f0954868f0b
# ╟─f123391a-4ebc-4994-9f60-da6ddd7772a2
# ╟─b01b54e8-bb01-4998-9542-78a993d41e9d
# ╟─991ff3ca-5741-42d6-85e0-7f35a2a2479a
# ╟─f71d5323-9389-4110-b904-64ab4bc2b875
# ╟─8161f0c4-726d-416c-be5e-1c16aeaf18af
# ╟─3aad0ff2-f363-4369-a2f8-4863bdcd2b58
# ╟─331a4763-62b3-4498-a16c-8e726f5ad5e4
# ╟─81c6f074-d947-49f7-97aa-85a2ffdc649d
# ╟─40025646-a342-4573-995e-8192e853f686
# ╟─d015b48a-391e-40d0-aa84-a3abdc7de99a
# ╟─c77d9d17-ee6b-4d72-bd56-5a3951439030
# ╟─4a0d76a4-9655-4ec0-930b-3e8776c45c14
# ╟─8610572e-e21d-4e24-ada3-8634dcf40d85
# ╟─68da5624-1bc8-4527-b4d2-081e33171e0c
# ╟─e7d69964-de82-4883-a39c-66f0d606a3e6
# ╠═836deb6f-e1f3-4766-b5e7-6c5bf788e0f9
# ╠═c212b18e-c7ab-46da-9492-f8ba6e4a08bd
# ╠═9b05d5b4-edbf-4702-9b67-ced9130bf36e
# ╟─c642977a-56e8-4a6a-b7b1-27caae9b2427
# ╟─8036cd43-199b-47c5-b755-ee789e5c8b3d
# ╟─3012b1bb-43a7-4a8f-b079-402fe5b9ba09
# ╟─22e5cd6d-8793-4f90-8b1d-a0bb3236e4c3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
