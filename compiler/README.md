# JFTT - Kompilator
## Szymon Wróbel 236761
#### Semestr zimowy 2018/19
---

## Wymagania
Najlepszym sposobem instalacji zależności jest instalacja `Haskell Platform`, która zawiera większość poniższych narzędzi i bibliotek.

### Kompilator Haskella
* GHC >= 8.4.3  

### Generatory lekserów i parserów 

* alex >= 3.2.4
* happy >= 1.19.9

`alex` i `happy` to odpowiedniki `flex`-a i `bison`-a dla Haskella, jeśli nie są zainstalowane, można je pobrać przy użyciu komend:

```
cabal install 'alex >= 3.2.4'
```

```
cabal install 'happy >= 3.2.4'
```

### Inne biblioteki 
* containers >= 0.5.11.0

Biblioteka zawierająca funkcyjne struktury danych.

```
cabal install 'containers >= 0.5.11.0'
```
