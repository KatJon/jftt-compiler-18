# JFTT - Kompilator
## Szymon Wróbel 236761
#### Semestr zimowy 2018/19
---

## Wymagania
Najlepszym sposobem instalacji zależności jest instalacja `Haskell Platform`, która zawiera większość poniższych narzędzi i bibliotek.

* GHC >= 8.4.3

Kompilator Haskella

* alex >= 3.2.4
* happy >= 1.19.9

`alex` i `happy` to odpowiedniki `flex`-a i `bison`-a dla Haskella, jeśli nie są zainstalowane, można je pobrać przy użyciu komend:

```
cabal install 'alex >= 3.2.4'
```

```
cabal install 'happy >= 3.2.4'
```
