# PTP ワークショップ - OpenShift 基礎編

このコンテンツは、PTP ワークショップ OpenShift基礎編で利用するハンズオンコンテンツです。実施前に、Red Hat OPENTLC 環境より、Hands-on 環境を払い出す必要があります。

- OPENTLC Catalog : OPENTLC OpenShift 4 Labs -> Hands On with OpenShift 4.10

- GitHub: https://github.com/RH-OPEN/ptp-openshift
- Web ドキュメント： https://rh-open.github.io/ptp-openshift/

### 更新方法
GitBook を使い、ドキュメントを GitHub Pages で公開をしています。
ビルド方法はこちらです。

1. gitbook のインストール
gitbook をインストールします。
```
npm install -g gitbook-cli
```
`gitbook --version` などのコマンドを実行し無事インストールがされていることを確認します。

2. レポジトリのクローン
本レポジトリをクローンしてください。
```
$ git clone https://github.com/RH-OPEN/ptp-openshift.git
```

3. ドキュメントの更新
クローンしたドキュメントの更新を行います。

4. ローカルビルド
```
$ pwd
/Users/rsuzuki/project/pej/ptp-openshift
　
$ gitbook build . docs
```


5. localhost で確認
ドキュメントを html に変換したページが localhost に表示され、ローカルから確認ができます。
```
$ gitbook serve . docs
　　　　　：
　　　　　：
Starting server ...
Serving book on http://localhost:4000
```

### 参考
- [OpenShift Starter Guides](https://redhat-scholars.github.io/openshift-starter-guides/rhs-openshift-starter-guides/4.9/index.html)

