import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="similar-dish"
export default class extends Controller {
  static targets = [ 'mask', 'modal', 'button', 'buttonText' ]

  showModal() {
    this.buttonTarget.setAttribute('data-action', 'click->similar-dish#closeModal');  // data-actionを変更
    this.buttonTextTarget.textContent = '閉じる';
    this.maskTarget.classList.remove('hidden');
    this.modalTarget.classList.remove('hidden');
  };

  closeModal() {
    this.buttonTarget.setAttribute('data-action', 'click->similar-dish#showModal');  // data-actionを元に戻す
    this.buttonTextTarget.textContent = '似た料理を見る';
    this.maskTarget.classList.add('hidden');
    this.modalTarget.classList.add('hidden');
  };
}
