{ 
  document.addEventListener('DOMContentLoaded', () => {
    const checkBoxes = document.querySelectorAll('.checkbox')
    
    checkBoxes.forEach((checkBox)=>{
      checkBox.addEventListener('change', () =>{ // チェック/解除された場合
        let checkCount = 0; // チェック数を初期化(初期化しないとどんどんカウントが増える)

        checkBoxes.forEach((checkBox) => { // チェックしたり外すたびに毎回チェックされたチェックボックスの総数を数える
          if (checkBox.checked == true) {
          checkCount += 1;
          }
        });
  
        if (checkCount >= 4) {
          alert('3つまでだよ😥')
          checkBox.checked = false;
        }
      })
    });
  });
}