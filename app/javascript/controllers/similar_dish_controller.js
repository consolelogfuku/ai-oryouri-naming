import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="similar-dish"
export default class extends Controller {
  static targets = [ 'mask', 'modal', 'button', 'buttonText' ]

  showModal() {
    // ボタンをおしたら、data-actionの値がcloseModalに変更されるよう設定
    this.buttonTarget.setAttribute('data-action', 'click->similar-dish#closeModal');
    this.buttonTextTarget.textContent = '閉じる';
    this.maskTarget.classList.remove('hidden');
    this.modalTarget.classList.remove('hidden');
  };

  closeModal() {
    // ボタンをおしたら、data-actionの値showModalに変更されるよう設定
    this.buttonTarget.setAttribute('data-action', 'click->similar-dish#showModal');
    this.buttonTextTarget.textContent = '似た料理を見る';
    this.maskTarget.classList.add('hidden');
    this.modalTarget.classList.add('hidden');
  };
}
