# やんばるCODE Rubyチャレンジ問題集
## ドラクエ風プログラム

ドラゴンクエスト2をイメージしたバトルプログラムとなっています。

- `ruby main.rb` でチャレンジ問題の回答プログラムを実行します。

- 【追加機能】 コマンドライン引数を入力すると多対多の戦闘プログラムを実行します。
  - ドラクエ２をイメージしているので、勇者チームの順番は固定となっています。
  
    1.ローレシア王子 もょもと
    
    2.サマルトリア王子 トンヌラ
    
    3.ムーンブルク王女 プリン
  - モンスターは以下のリストから重複なしでランダムに選ばれます。
    - メタルスライム
    - キメラ
    - アークデーモン
    - りゅうおう
    - シドー
    - ゾーマ

第1引数: 勇者の人数 （1〜3）第2引数: モンスターの数（1〜6）

実行例： 勇者３人 vs モンスター２体 → `ruby main.rb 3 2`
