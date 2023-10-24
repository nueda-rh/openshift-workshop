* [イントロダクション](../../README.md)
* [OpenShift ユーザエクスペリエンス](../../modules/03_OpenShift_User_Experience/chap-3.md)
* [アプリケーションデプロイメント (s2i,Tekton)](../../modules/04_Application_Deployment/chap-4.md)


# OpenShift ユーザエクスペリエンス 

## シナリオ

このラボでは、Red Hat OpenShift Container Platform でアプリケーションをデプロイするデモを行います。デプロイしたアプリの詳細情報を閲覧します。
また、OperatorHub から Operator をインストールします。

### ゴール
* Web コンソールのパースペクティブ(管理者向け表示と開発者)を理解
* Gitリポジトリからアプリケーションをビルドしてデプロイ
* デプロイしたアプリを、ウェブコンソールのトポロジービューを通して確認
* OperatorHub から Operator をインストール


---
## 開発者パースペクティブ

OpenShift Container PlatformのWebコンソールには、管理者向け表示と開発者の2つのパースペクティブがあります。開発者パースペクティブでは、開発者のユースケースに特化したワークフローを提供します。

* **開発者パースペクティブに切り替えます。**

    アプリケーションを作成するためのオプションを持つトポロジービューが表示されます。”Developerパースペクティブへようこそ！”という画面が表示された場合には、[ツアーをスキップ]をクリックしてください。

![開発者パースペクティブ](./images/03_1_developer_perspective.png)
<div style="text-align: center;">開発者パースペクティブ</div>

<br>

## Project 作成

プロジェクトによって、あるユーザーのコミュニティが他のコミュニティから切り離された状態でコンテンツを整理・管理できます。プロジェクトはKubernetesネームスペースに対するOpenShiftの拡張で、ユーザーのセルフプロビジョニングを可能にする機能を追加したものです。 ほとんどの場合に互換性があります。

* **プロジェクトドロップダウンメニューをクリック -> プロジェクトの作成 を選択します。**

![Project作成](./images/03_1_create_project_developer_perspective.png)
<div style="text-align: center;">Project作成</div>

<br>

> NOTE:
>
> 異なるプロジェクトはそれぞれに対応した異なるユーザー権限とクォータを持つことができます

* *名前* を `<英字氏名>-test` として、プロジェクトを作成します。 例） `yamadataro-test`

    プロジェクトが `<英字氏名>-test` に切り替わったことを確認します。

   　プロジェクト名はOpenShiftクラスタ内で一意である必要があります。


---
## アプリケーションデプロイメント

Web コンソールの 開発者パースペクティブでは、追加ビューからアプリケーションおよび関連サービスを作成できます。OpenShift Container Platform にデプロイするためにはいくつかのオプションがあります（例 Dockerfile、Git、Catalog、YAMLなど）。

* *Devfile*：これはDevfilev2仕様を使用してアプリケーションスタックを作成します。devfile.yamlリポジトリには、Devfilev2形式で名前が付けられたファイルが含まれている必要があります。
* *Dockerfile*：これにより、既存のDockerfileからコンテナイメージが作成されます。
* *ビルダーイメージ*：これは、Source-to-Imageと呼ばれるメカニズムを使用して、ソースコードから直接コンテナーイメージを自動的に作成します。

本手順では、GitHub にある既存のコードベースを利用して、OpenShift Container Platform上でアプリケーションを作成、構築、デプロイします。開発者パースペクティブでアプリケーションを作成するための *Gitからのインポート* オプションを使います。 


### アプリケーションの作成
* **追加で `Gitからのインポート` をクリックし、Git フォームを表示します。**

![開発者パースペクティブ](./images/03_1_add_application_from_git.png)
<div style="text-align: center;">開発者パースペクティブ</div>

<br>


* **Git セクションで、アプリケーションの作成に使用するコードベースの Git リポジトリー URL を入力します。**

```
https://github.com/sclorg/nodejs-ex.git
```

![Gitからのインポート](./images/03_1_import_from_git_form_url.png)
<div style="text-align: center;">Gitからのインポート</div>

<br>

* **`インポートストラテジーの編集` をあえて選択し、適切なビルダーイメージが検出されているかを確認します。**
    * **Builder セクション**で、URL の検証後に、自動的に選択されます（スターのマークが付きます）。
    * ビルダーイメージが自動検出されていない場合は、ビルダーイメージを選択します。必要に応じて、ビルダーイメージのバージョン のドロップダウンリストを使用してバージョンを変更できます。

* **一般 セクションで、以下を確認します（特に変更不要です）。**

    * **アプリケーション名** ：アプリケーションを分類するために一意の名前 (nodejs-ex-app など) を入力します。
    * **名前** ：このアプリケーション用に作成されたリソースを分類するために一意な名前を入力します。これは Git リポジトリー URL をベースとして自動的に設定されます。

* **Resources セクションで、デフォルトのリソース `Deployment` を選択します** 

> NOTE:
> 
> OpenShift Deployment Configsに加えて、Kubernetes _Deployments_ もサポートされています。

* **その他の設定は変更せず、`作成済み` をクリックします。**

> NOTE :
>
> Knative Service オプションは、Serverless Operator がクラスターにインストールされている場合にのみ、Gitからのインポート 形式で表示されます。

## トポロジービュー

1. Web コンソールの開発者パースペクティブにあるトポロジービューでは、プロジェクト内のすべてのアプリケーション、そのビルドステータス、およびそれらに関連するコンポーネントとサービスを視覚的に表示します。

![トポロジービュー](./images/03_1_topology_view_a.png)
<div style="text-align: center;">トポロジービュー</div>

<br>

> NOTE:
> 
> * **アプリケーションを作成したら、トポロジービューに自動的に移動します。**
>
>    * ここでは、アプリケーション Pod のステータスの確認、パブリック URL でのアプリケーションへの迅速なアクセス、ソースコードへのアクセスとその変更、最終ビルドのステータスの確認ができます。
>    * ズームインおよびズームアウトにより、特定のアプリケーションの詳細を表示することができます。
>
>    * グラフィカルな表示が表示されない場合は、Web コンソールの右上にある「トポロジー」アイコンをクリックします。（下記参照）

![トポロジービューの切り替え](./images/03_1_topology_view_switch_view.png)
<div style="text-align: center;">トポロジービューの切り替え</div>
<br>

2. アプリケーションをビルドすると、Runningと表示されます。  
<div align="center">
<img src="./images/03_1_topology_nodejs_pod_running.png" width=50%>
</div>
<div style="text-align: center;">Running</div>

<br>

以下のように、異なるタイプのリソースオブジェクトのインジケーターと共に、アプリケーションリソース名が追加されます。


* *D*: Deployment
* *DC*: Deployment Configs
* *SS*: StatefulSet
* *DS*: Daemonset


注: OpenShift Deployment Configsに加えて、Kubernetes _Deployments_ もサポートされていることに注意します。 Kubernetes Deploymentは、Deployment Configs で利用可能な機能の多くを共有しており、OpenShift Container Platform 4.5からはデフォルトのデプロイメントリソースオブジェクトとなっています。


**アプリケーションの中心のロゴをクリックすると、右側から詳細画面が表示され、関連するリソースを閲覧することができます。**

![Project作成](./images/03_2_topology_nodejs_pod_running.png)
<div style="text-align: center;"></div>

<br>

> NOTE:
> 
> アイコンの緑のチェックにマウスを合わせると、`ビルド Complete` と表示され、ビルドが完了していることが分かります。また、右上の四角と矢印のアイコン `URL を開く`は、アプリケーションに接続するためのへのリンクが提供されています。`Github のキャラクター オクトキャット` をクリックすると、Github でソースコードの編集を行う事が出来ます。  
> 右ペインの詳細 (Delailes) タブに表示されている青い円の横にある上や下の矢印を押すと、Pod の数の増減が出来ます。簡単にスケールアップ、スケールダウンが出来るオペレーション是非試してみてください。


* **Deploymentの円の右上の `URL を開く` (四角と矢印)アイコンをクリックして、アプリケーションのルートにアクセスしてみてください。**

![nodejs-ex アプリ](./images/03_2_import_from_git_form_url_result.png)
<div style="text-align: center;">nodejs-ex アプリ</div>

<br>

> NOTE :
>
> 詳細オプションセクションでは、**アプリケーションのルートを作成する** がデフォルトで選択されるため、公開されている URL を使用してアプリケーションにアクセスできます。
> アプリケーションをパブリックルートに公開したくない場合は、チェックボックスをクリアできます。

---
## アプリケーションデプロイメント (dc-metro-map)
各自で実施してみてください。

### アプリケーションの作成
* **以下の設定で、アプリケーションをデプロイしてみてください。**
    * GitHub レポジトリ URL：
    ```
    https://github.com/RedHatGov/openshift-workshops.git
    ```

    * "Show advanced Git options"を表示し、表示されたメニューから"Context dir"を設定します：
    ```
    /dc-metro-map
    ```

* **その他の設定は変更せず、`作成済み` をクリックします。**

![openshift-workshopsアプリ](./images/03_3_import_from_git_form_url_setting.png)
<div style="text-align: center;">openshift-workshopsアプリ</div>

<br>

* **ルート（URLを開く）からアプリケーションにアクセスしてみてください。**

![openshift-workshopsアプリ](./images/03_3_import_from_git_form_url.png)
<div style="text-align: center;">openshift-workshopsアプリ</div>

<br>


## Monitoring ビューの確認 (OpenShift Monitoring)

Red Hat は、モニタリング機能をWebコンソールに統合しています。プロジェクト全体のメトリクスとイベントについてはこちらからご覧ください。

* 左側のパネルで **モニタリング**をクリックします。

![Project作成](./images/03_1_developer_perspective_monitoring.png)
<div style="text-align: center;"></div>

<br>

* *ダッシュボード* タブ 

    ダッシュボードタブは、プロジェクトのメトリクスをまとめて表示します。

* *メトリックス* タブ 

    メトリクスタブは、Prometheus Metricsのカスタムグラフを作成することができます。

* *イベント* タブ 

    イベントタブは、報告されたイベントが一つのストリームとして表示され、フィルターできます。


---
## Pod の確認 (Readiness Probe / Liveness Probes)

管理者向け表示から確認します。

* **左側のメニューから、 *Workloads -> Pods* を選びます**
    * プロジェクトの *Pods* ページは、プロジェクトの中で現在実行中の全てのPodを表示します。
        * `Running`, `Pending` などコンテナの状態を確認することができます。
        *  *Ready*  カラムは Readiness チェックにもとづいたコンテナ内アプリケーションの状態が表示されます。

* **`openshift-workshops-git-XXXXX` Pod をリストから選びます。**
    * それぞれの *Pod* ページでは以下が表示されます。
        * *Containers* セクション
            * イメージ名とコンテナの状態を含む情報が表示されます
            * Podのステータスとそれをホストする OpenShift ノード
    
    
* **`openshift-workshops-git` という名前のコンテナをクリックして *Container Details* ページを開く。**
    * アプリケーションコンテナの *Readiness Probe* と *Liveness Probes* を確認します。
    > NOTE:
    > 
    > 該当のアプリケーションでは、Readiness Probe/Liveness Probesが設定されていません。
    > 詳細な利用法は[こちら](https://developers.redhat.com/blog/2020/11/10/you-probably-need-liveness-and-readiness-probes#what_about_identical_liveness_and_a_readiness_probes_)の情報を参考にしてみてください。

* ***メトリクス* タブ を参照する**
    * メモリ、CPU などリソースの使用量が表示されます。
    ![](./images/03_1_admin_pod_details.png)
    <div style="text-align: center;">Memory Usage, CPU Usage, Filesystem のグラフ</div>

<br>

* **そのほか、各タブを見ていきます。**
    * *ログ* タブ 
        * Podのメッセージはここに表示され、更新されるにしたがって追跡することができます。
        * 更新によるログの出力を一時停止および再開することができます。

    * *ターミナル* タブ 
        * デバッグやテストのためにコンテナ内でコマンドを実行することができます。

    * *イベント* タブ 
        * このリストはPodのDeploymentで何かがおかしいかを探したり、イベントの連鎖を追跡したりするために使えます。

## OperatorHub から Operatorのインストール
管理者向け表示から確認します。

### OpenShift Pipelineのインストール

* **OpenShift Pipelineをインストール**
    * 管理者向け表示の下の左側のメニューから、Operator → OperatorHubに移動します。
    * 検索ボックスで`OpenShift Pipeline`を検索し、 表示された結果から`Red Hat OpenShift Pipelines`をクリックします。

![OperaterHub画面1](./images/03_100_prerequisites_operatorhub.png)
<div style="text-align: center;">OperaterHub画面1</div>

<br>

* **説明ビューで、`インストール` をクリックして、すべてのインストール設定を確認します。**

![OperaterHub画面2](./images/03_101_prerequisites_operatorhub_インストール_pipelines.png)
<div style="text-align: center;">OperaterHub画面2</div>

<br>

* **Update Channelが `latest` に設定されていることを確認し、 `インストール` をクリックしてOperatorのインストールを開始します。**

![OperaterHub画面3](./images/03_102_prerequisites_operatorhub_install_operator2.png)
<div style="text-align: center;">OperaterHub画面3</div>

<br>

* **数秒後、以下のような画面が表示され、インストールが正常に完了します。また、インストール済みのOperatorの画面の[Status]列を確認することで、インストールステータスが成功であるかどうかを確認できます。**

![OperaterHub画面4](./images/03_103_prerequisites_operatorhub_pipelines_installed.png)
<div style="text-align: center;">OperaterHub画面4</div>

<br>

---
## 追加のデモ （オプション）

興味のある Operator をインストールしてみてください（OpenShift Logging などなど）。

* [イントロダクション](../../README.md)
* [OpenShift ユーザエクスペリエンス](../../modules/03_OpenShift_User_Experience/chap-3.md)
* [アプリケーションデプロイメント (s2i,Tekton)](../../modules/04_Application_Deployment/chap-4.md)
