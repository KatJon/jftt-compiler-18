# JFTT - Kompilator
## Szymon Wróbel 236761
#### Semestr zimowy 2018/19
---

## Wymagania
Najlepszym sposobem instalacji zależności jest instalacja `Haskell Platform`, która zawiera większość poniższych narzędzi i bibliotek.

### Kompilator Haskella
* GHC >= 8.4.3  

Poniższa komenda instaluje pełną wersję haskella, wraz z bibliotekami 
```
sudo apt-get install haskell-platform
```

### Generatory lekserów i parserów 

* alex >= 3.2.4
* happy >= 1.19.9

`alex` i `happy` to odpowiedniki `flex`-a i `bison`-a dla Haskella.
Haskell Platform powinien zainstalować `alex`-a i `happy`-ego, co można sprawdzić przy użyciu komend:

```
alex -v
```

```
happy -v
```

W przeciwnym wypadkku można je pobrać przy użyciu komend:

```
cabal install 'alex >= 3.2.4'
```

```
cabal install 'happy >= 3.2.4'
```

### Inne biblioteki 
Zainstalowaną wersję pakietu można sprawdzić przy uzyciu komendy

```
cabal list <package> --installed
```

gdzie \<package\> jest nazwą pakietu.

---

* containers >= 0.5.11.0

Biblioteka zawierająca funkcyjne struktury danych.

```
cabal install 'containers >= 0.5.11.0'
```

* mtl >= 2.2.2

Biblioteka zawierająca transformatory monad

```
cabal install 'mtl >= 2.2.2'
```

* array >= 0.5.2.0

Biblioteka zawierająca interfejs funkcyjny do tablic

```
cabal install 'array >= 0.5.2.0'
```
