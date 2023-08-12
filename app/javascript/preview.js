function previewImage(event) {
    const target = event.target; // この行で event.target を使用
    const file = target.files[0];
    const reader = new FileReader();
    reader.onloadend = function () {
        const preview = document.querySelector("#preview");
        if (preview) {
            preview.src = reader.result;
        }
    };
    if (file) {
        reader.readAsDataURL(file);
    }
}

document.addEventListener("DOMContentLoaded", () => {
    const fileField = document.querySelector('input[type="file"]');
    if (fileField) {
        fileField.addEventListener("change", previewImage);
    }
});