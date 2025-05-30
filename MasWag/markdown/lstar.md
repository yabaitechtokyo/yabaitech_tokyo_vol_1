# L\*アルゴリズム

前節で定義した正規言語をDFAの形式で人間が書くことも当然できますが、これ以降本章では未知の正規言語を学習するという問題を主に考えます。機械学習の教師付き二値分類問題では「正例と負例からなる訓練用データを与えて、訓練用以外のデータについても高い確率で正しく分類する」という問題設定が良く用いられますが、ここでは*exact learning*と呼ばれる学習を考えます。Exact learningでは、未知の正規言語を近似する正規言語を学習するのではなく、未知の正規言語と完全に等しい正規言語を表現するDFAを学習します。ここで、任意の文字列の有限集合は正規言語であるので、有限個の訓練用データを与えても本当に学習したい正規言語に辿り着くのは難しそうです。本節では (というよりexact learningの文脈ではしばしば) 、訓練用データの代わりに次の二つの質問を神託に聞くことを通して学習を行なう、という設定を考えます。現実的にこんなことがわかる神託をどうやって用意するのか、という問題はここでは考えません。

* 所属性質問 (membership query): 文字列 $w \in \Sigma^\ast$ を神託に与えて、$w$ が学習したい言語 $L\subseteq \Sigma^\ast$ に含まれているか ($w \in L$)を問う質問。
* 等価性質問 (equivalence query): 正規言語 $L' \subseteq \Sigma^\ast$ を神託に与えて、$L'$ が学習したい言語 $L$ と等しいかどうかを問う質問。$L'\neq L$である場合には反例 $w\in \Sigma^\ast$、つまり $w\in L \triangle L'$ を充たす最短の文字列 $w$ が返る。ここで$\triangle$は集合の対称差の記号である。

本節では例として $L = \{ a \in \{\text{a,b}\} \mid \text{a, bの個数が共に偶数}\}$ を用います。例えば\\ref-figure(\`fig:evenDFA\`);のDFAがこの言語を認識します。

## 観察表

L\* アルゴリズムでは *観察表* (observation table) と呼ばれる表$T$に、各質問の結果を随時記入していくことで学習を進めていきます。観察表は\\ref-figure(\`fig:observationTable\`);にある様に行、列が共に$\Sigma$上の文字列で添字付けされている表です。観察表の各セルには所属性質問の結果が記入されます。各セル$T[w,w']$には文字列$w\cdot w'$の所属性質問の結果が記入されます。また、観察表には水平線より上側と下側の区別があります。
水平線より上側の行の添字集合を$P\subseteq \Sigma^\ast$,下側の添字集合を$P'\subseteq\Sigma^\ast$,また、列の添字集合を$S\subseteq\Sigma^\ast$と呼びます。
また、観察表が以下の条件を充たすとき、その観察表を*閉じている*と言います。

* 各$w'\in P'$について、$T[w,\text{-}]=T[w',\text{-}]$を充たす$w\in P$が存在する
* 各$w'\in P$、$a\in\Sigma$について、$w\cdot a\in P\cup P'$が成り立つ

|               | $\varepsilon$ | a |
|---------------|---------------|---|
| $\varepsilon$ | T             | F |
| a             | F             | T |
| b             | F             | F |
|---------------|---------------|---|
| aa            | T             | F |
| ab            | F             | F |
| ba            | F             | F |
| bb            | T             | F |

## L\* アルゴリズム

|               | $\varepsilon$ |
|---------------|---------------|
| $\varepsilon$ |               |

L\*アルゴリズムではまず始めに\\ref-figure(\`fig:initObservationTable\`);の観察表から始めます。最初に空欄になっているセル$T[\varepsilon, \varepsilon]$を所属性質問を用いて埋め、同時に$P'$にa,bを追加し、同様に埋めます (\\ref-figure(\`fig:observationTable1\`);) 。

|               | $\varepsilon$ |
|---------------|---------------|
| $\varepsilon$ | T             |
|---------------|---------------|
| a             | F             |
| b             | F             |

ここで\\ref-figure(\`fig:observationTable1\`);の観察表が閉じているかを判定します。今回は行aの行ベクトル$T[\text{a,-}]$が水平線の上側の何れの行ベクトルとも一致しないので閉じていません。そこで閉じていない原因の行aを水平線の上側に移動します。このとき各$\{\text{a} \cdot a \mid a \in \Sigma\}$を添字とする列が$P$と$P'$のどちらにもに存在しない場合、その存在しない添字を$P'$に追加します (\\ref-figure(\`fig:observationTable2\`);) 。

|               | $\varepsilon$ |
|---------------|---------------|
| $\varepsilon$ | T             |
| a             | F             |
|---------------|---------------|
| b             | F             |
| aa            | T             |
| ab            | F             |


今回は観察表が閉じました。観察表が閉じている場合、次のルールに従って観察表からDFAを生成することができます。

- 各$w\in P$に対して、DFAの状態$q_w$を生成する
- DFAの初期状態は$q_{\varepsilon}$とする
- DFAの受理状態は$T[w,\varepsilon] = \mathrm{T}$となる状態$q_w$とする
- DFAの遷移関数$\Delta(q_w,a)$は、$w\cdot a\in P$の場合$\Delta(q\_w,a)=q\_{w\cdot a}$とし、そうでない場合$T[w\cdot a,\text{-}] = T[w',\text{-}]$を充たす$w'\in P$について、$\Delta(q\_w,a)=q\_{w'}$とする。

例えば\\ref-figure(\`fig:observationTable2\`);の観察表からは\\ref-figure(\`fig:evenDFAStep1\`);のDFA、$\mathcal{A}_1$が生成されます。

DFAを一つ生成することができたので等価性質問によってこのDFA学習したい正規言語を認識するかどうかを調べてみます。
今回、DFA$\mathcal{A}_1$は言語$L$を認識しないので、最短の反例 ba が返ります。
次に反例 baがどの位置から\\ref-figure(\`fig:observationTable2\`);の観察表と食い違ったかを見てみます。
今回は$T[\text{b,-}]= T[\text{a,-}]$で、実際$b\not\in L$と$a\not\in L$が成り立ちますが、$ba\not\in L$、$aa \in L$となるので末尾のaで観察表と食い違いました。
これはつまり現在の状態の受理・非受理のみではなく、現在の状態からaを読んだときの受理・非受理も考慮する必要があるということになります。
これを表わすために$S$の列にaを加え、先と同様に観察表が閉じるまで所属性質問を繰り返します (\\ref-figure(\`fig:observationTable3\`);) 。

|            | $\varepsilon$ | a |
|------------|------------|---|
| $\varepsilon$ | T          | F |
| a          | F          | T |
| b          | F          | F |
|------------|------------|---|
| aa         | T          | F |
| ab         | F          | F |
| ba         | F          | F |
| bb         | T          | F |



|            | $\varepsilon$ | a | b |
|------------|------------|---|---|
| $\varepsilon$ | T          | F | F |
| a          | F          | T | F |
| b          | F          | F | T |
| ab         | F          | F | F |
|------------|------------|---|---|
| aa         | T          | F | F |
| ba         | F          | F | F |
| bb         | T          | F | F |
| aba        | F          | F | T |
| abb        | F          | T | F |

\\ref-figure(\`fig:observationTable3\`);の下側の観察表から生成されるDFAについて等価性質問を問い合わせると学習したい言語と一致するので、今回の学習はここで終了となります。
ここまでの流れだけを見ると今回たまたま上手く行っただけで、この学習が有限回で停止しない場合もあるのではないかと疑問に思うと思われますが、実は常に有限回 (より正確には多項式回)で停止しますし、更にはこの方法で生成されるDFAは与えられた言語を認識するDFAのなかで状態数が最小となることもわかります。
これらの点について次に説明していきます。

## Myhill-Nerodeの定理とDFAの最小性

さて、L\*アルゴリズムの停止性を見るために、まずは正規言語の「有限らしさ」の特徴付けであるMyhill-Nerodeの定理を見ていきます。

### Myhill-Nerode同値関係 {.definition}

有限文字集合$\Sigma$上の言語$L$について、*Myhill-Nerode同値関係*$R_L\subseteq\Sigma^\ast\times\Sigma^\ast$を、次のように定義する。文字列$w,w'\in\Sigma^\ast$について$w R_L w'$が成り立つのは以下のときである。

$$\forall w'' \in \Sigma^\ast. w \cdot w'' \in L \Leftrightarrow w'\cdot w'' \in L $$

### Myhill-Nerodeの定理 {.theorem}

有限文字集合$\Sigma$上の言語$L$について、$L$が正規言語であることの必要十分条件は、商集合$L/R_L$が有限集合となることである。

文字列$w,w'$とMyhill-Nerode同値関係$R_L$について、$w R_L w'$が成り立つということの直観は、「これから与えられる未知の文字列$w''\in\Sigma^\ast$について$w\cdot w''\in L$が成り立つかどうかを調べたいときに、今まで読んだ文字が$w$であるか$w'$であるかは気にしなくて良い」ということになります。
このことについて木を使ってより詳しく見ていきます。
文字集合$\Sigma=\{\text{a,b}\}$上の言語$L$として、「aとbの出現回数が共に偶数回」というものを考えます。
この言語を受理する(無限状態数の)オートマトンとして\\ref-figure(\`fig:evenTree\`);の上側の木を考えます。
この木では各文字列$w\in\Sigma^\ast$について一つの状態が割り当てられ、$L$に含まれる文字列と対応する状態が受理状態となります。
ここで今回、例えば$\text{b} R_L \text{aba}$が成り立ちますが、これは木の上の性質としてみると、bを根としたときの部分木と、abaを根としたときの部分木が等しいということになります。
従って\\ref-figure(\`fig:evenTree\`);の下側の(無限状態の)オートマトンのように、状態bと状態abaを一つにまとめても、受理言語は変わらないと言えます。
商集合$L/R_L$が有限集合、つまり右側のオートマトンのように状態を纏める操作を行うと最終的に有限状態のオートマトンになるとき、確かに$L(\mathcal{A})=L$が成り立つような、状態数$|L/R_L|$のDFA$\mathcal{A}$を構成できるので$L$は正規言語になります。
また、$L$が正規言語である、つまり$L(\mathcal{A})=L$が成り立つようなDFA$\mathcal{A}$が存在するとき、文字列$w,w'$について$\delta(q_0,w)=\delta(q_0,w')$が成り立つならば$w R_L w'$も成り立つので$L/R_L$は有限集合となります。
以上がMyhill-Nerodeの定理が成り立つ簡単な理由です。
さらに、正規言語$L$とDFA$\mathcal{A}$について、状態数が$|L/R_L|$より少ない場合$\delta(q_0,w)=\delta(q_0,w')$であって$w R_L w'$が成り立たないような文字列$w,w'\in\Sigma^\ast$が存在するので、次の系が成り立ちます。

#### 状態数最小のDFA {.corollary}

正規言語$L$について、状態数$|L/R_L|$で$L$を認識するDFAが存在し、また、状態数$L/R_L$未満の任意のDFAは$L$を認識しない。

さて、Myhill-Nerodeの定理の立場からL\*アルゴリズムの観察表を見ていきます。
まず、各$w\in P$について行ベクトル$T[w,\text{-}]$は互いに異なる、つまり適宜末尾に文字列を加えたときの受理/非受理の関係が異なるので、$P$の要素数は$L/R\_L$の要素数以下になり、$L$が正規言語であるとならば上限が存在します。
各$P'$の要素は$P$の要素に一文字付け加えたものであるので、$|P'|\leq|P|\times|\Sigma|$となります。
また、$S$に添字$w'$を追加する際は$w'$を追加することで新たに食い違うような$w'$のみを追加する、つまり各$w\in S$について$T[u,w]=T[u',w]$であるが$T[u,w']\neq T[u',w']$である様な$u,u' \in P\cup P'$が存在するときのみ$w'$を$S$に追加します。
従って、$|S|\leq |L/R\_L|\times (1+|\Sigma|)$も成立します。
更に観察表を閉じる際及び等価性質問の結果反例が返って来た際には$P$と$S$の大きさが1以上増えます。
以上よりL\*アルゴリズムは$L$が正規言語であれば常に停止し、$L(\mathcal{A})=L$を充たすDFA$\mathcal{A}$を返することがわかります。
また、L\*アルゴリズムが生成するDFAの状態数は$|P|$ですが、$L(\mathcal{A})=L$を充たす任意のDFAの状態数は$L/R_L$以下であることから、$\mathcal{A}$は$L(\mathcal{A})=L$を充たす状態数が最小のDFAであることもわかります。
