import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview"
export default class extends Controller {
  static targets = [ 'image' ]

  previewImage(e) {  // eはchangeイベント発生したイベントオブジェクト
    const target = e.target;
    const file = target.files[0];
    const reader = new FileReader(); // ユーザーが選択したファイルを読み取るためのオブジェクトを作成

    reader.onloadend = () => { // アップロードしたファイルの読み込みが完了したら実行されるコールバック
      // imageTargetが存在すれば
      if (this.hasImageTarget) {
        this.imageTarget.src = reader.result; // 読み取ったファイルの内容(URL)をターゲットのsrc属性に設定
        // <img src="URL" data-target="preview.image"></img>みたいになる
      }
  };
  if (file) { // ファイルが選択されていたら
      reader.readAsDataURL(file); // そのファイルをデータURLとして読み込む
  }
  }
}