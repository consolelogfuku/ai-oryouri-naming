import { Controller } from "@hotwired/stimulus"

import { Toast } from "bootstrap"

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
    // Toastを生成
    const toast = new Toast(this.element)
    // Toastを表示
    toast.show()
  }
}
