# はじめに

本章では、ICML 2018に採択された Extracting Automata from Recurrent Neural Networks Using Queries and Counterexamples \\cite([\`conf/icml/WeissGY18\`]); について、オートマトン理論的な背景に重点を置いて解説します。本章において、形式言語理論についての知識は仮定しませんが、素朴集合論や基本的なグラフ理論の知識や記号などは適宜使用します。また、RNNについての基本的な知識を仮定します。
この論文では、文字列の二値分類問題について学習済みのLong Short-Term Memory (LSTM)やGated Recurrent Unit (GRU)などのRecurrent Neural Network (RNN)からDetermistic Finite Automaton(決定的有限オートマトン、DFA)を抽出する手法を提案しています。本手法は神託を用いて正規言語を学習するAngluinによるL\*アルゴリズムを、RNNを用いて学習する手法に応用したものになります。L\*アルゴリズムではある文字列 $w \in \Sigma^\ast$ が学習したい言語 $L\subseteq \Sigma^\ast$ に含まれているか ($w \in L$)を質問する*所属性質問* (membership query)と、学習した言語$L'\subseteq \Sigma^\ast$が学習したい言語$L\subseteq \Sigma^\ast$と等しいかどうかを質問する*等価性質問* (equivalence query)の二種類の質問を繰り返すことで効率良く、学習したい言語を最小の状態数を持つオートマトンで学習します。RNNを用いて学習する場合には、所属性質問に答えることは可能ですが (RNNに文字列を与えれば良い) 、等価性質問に答えることは一般には不可能です。この論文の主な貢献は、RNNを用いて(近似的に)等価性質問に答える手法を与えた、ということになります。

本章の構成は以下のようになります。まず第二節で形式言語やオートマトンの必要な定義を与えます。第三節ではAngluinのL\*アルゴリズムやそれに関連してMyhill-Nerodeの定理など正規言語の学習についての紹介を行います。第四節では本題の、RNNを用いてL\*アルゴリズムの等価性質問に答える手法を説明します。
